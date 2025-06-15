#!/bin/bash
# Iceberg + Spark Docker Environment Manager

set -e

CONTAINER_NAME="spark-iceberg"
PROJECT_NAME="iceberg-spark"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

print_usage() {
    echo -e "${BLUE}Iceberg + Spark + Jupyter Environment Manager${NC}"
    echo ""
    echo "Usage: $0 [COMMAND]"
    echo ""
    echo "Commands:"
    echo "  start          Start the Docker environment"
    echo "  stop           Stop the Docker environment"
    echo "  restart        Restart the Docker environment"
    echo "  shell          Open bash shell in container"
    echo "  jupyter        Open Jupyter Lab in browser"
    echo "  spark          Start Spark Shell with Iceberg"
    echo "  test           Run Iceberg test script"
    echo "  logs           Show container logs"
    echo "  status         Show container status"
    echo "  clean          Remove container and volumes"
    echo ""
    echo "Examples:"
    echo "  $0 start       # Start environment"
    echo "  $0 jupyter     # Open Jupyter Lab"
    echo "  $0 spark       # Start Spark Shell"
    echo "  $0 test        # Run test script"
}

check_docker() {
    if ! docker --version &> /dev/null; then
        echo -e "${RED}❌ Docker is not installed or not running${NC}"
        exit 1
    fi
}

start_environment() {
    echo -e "${BLUE}🚀 Starting Spark + Iceberg environment...${NC}"

    if docker ps -q -f name=$CONTAINER_NAME | grep -q .; then
        echo -e "${YELLOW}⚠️  Container is already running${NC}"
        return 0
    fi

    docker-compose up -d

    echo -e "${YELLOW}⏳ Waiting for container to be ready...${NC}"
    sleep 3

    if docker ps -q -f name=$CONTAINER_NAME | grep -q .; then
        echo -e "${GREEN}✅ Environment started successfully!${NC}"
        echo ""
        echo -e "${BLUE}📋 Available commands:${NC}"
        echo "  ./manage.sh jupyter # Open Jupyter Lab"
        echo "  ./manage.sh shell   # Open bash shell"
        echo "  ./manage.sh spark   # Start Spark Shell"
        echo "  ./manage.sh test    # Run test script"
        echo ""
        echo -e "${BLUE}🌐 Jupyter Lab:${NC} http://localhost:8888 (no password required)"
        echo -e "${BLUE}🌐 Spark UI:${NC} http://localhost:4040 (when Spark is running)"
        echo -e "${BLUE}📁 Warehouse:${NC} ./warehouse"
    else
        echo -e "${RED}❌ Failed to start container${NC}"
        exit 1
    fi
}

stop_environment() {
    echo -e "${BLUE}🛑 Stopping Spark + Iceberg environment...${NC}"
    docker-compose down
    echo -e "${GREEN}✅ Environment stopped successfully!${NC}"
}

restart_environment() {
    stop_environment
    sleep 2
    start_environment
}

open_shell() {
    if ! docker ps -q -f name=$CONTAINER_NAME | grep -q .; then
        echo -e "${RED}❌ Container is not running. Start it first with: $0 start${NC}"
        exit 1
    fi

    echo -e "${BLUE}🐚 Opening bash shell in container...${NC}"
    docker exec -it $CONTAINER_NAME bash
}

open_jupyter() {
    if ! docker ps -q -f name=$CONTAINER_NAME | grep -q .; then
        echo -e "${RED}❌ Container is not running. Start it first with: $0 start${NC}"
        exit 1
    fi

    echo -e "${BLUE}🚀 Opening Jupyter Lab in browser...${NC}"
    echo -e "${YELLOW}📝 If it doesn't open automatically, visit: http://localhost:8888${NC}"

    # Try to open browser (works on macOS and Linux)
    if command -v open &> /dev/null; then
        open http://localhost:8888
    elif command -v xdg-open &> /dev/null; then
        xdg-open http://localhost:8888
    else
        echo -e "${YELLOW}💡 Please manually open http://localhost:8888 in your browser${NC}"
    fi
}

start_spark() {
    if ! docker ps -q -f name=$CONTAINER_NAME | grep -q .; then
        echo -e "${RED}❌ Container is not running. Start it first with: $0 start${NC}"
        exit 1
    fi

    echo -e "${BLUE}⚡ Starting Spark Shell with Iceberg...${NC}"
    echo ""
    echo -e "${YELLOW}📝 Once Spark starts, you can test with:${NC}"
    echo "   spark.sql(\"CREATE DATABASE IF NOT EXISTS local.demo\")"
    echo ""

    docker exec -it $CONTAINER_NAME bash -c "
        cd /home/jovyan/work &&
        /usr/local/spark/bin/spark-shell \
            --packages org.apache.iceberg:iceberg-spark-runtime-3.5_2.12:1.4.3 \
            --conf spark.sql.extensions=org.apache.iceberg.spark.extensions.IcebergSparkSessionExtensions \
            --conf spark.sql.catalog.local=org.apache.iceberg.spark.SparkCatalog \
            --conf spark.sql.catalog.local.type=hadoop \
            --conf spark.sql.catalog.local.warehouse=/home/jovyan/work/warehouse
    "
}

run_test() {
    if ! docker ps -q -f name=$CONTAINER_NAME | grep -q .; then
        echo -e "${RED}❌ Container is not running. Start it first with: $0 start${NC}"
        exit 1
    fi

    echo -e "${BLUE}🧪 Running Iceberg test script...${NC}"
    docker exec -it $CONTAINER_NAME bash -c "
        cd /home/jovyan/work &&
        /usr/local/spark/bin/spark-shell \
            --packages org.apache.iceberg:iceberg-spark-runtime-3.5_2.12:1.4.3 \
            --conf spark.sql.extensions=org.apache.iceberg.spark.extensions.IcebergSparkSessionExtensions \
            --conf spark.sql.catalog.local=org.apache.iceberg.spark.SparkCatalog \
            --conf spark.sql.catalog.local.type=hadoop \
            --conf spark.sql.catalog.local.warehouse=/home/jovyan/work/warehouse \
            -i /home/jovyan/work/scripts/test-iceberg.scala
    "
}

show_logs() {
    echo -e "${BLUE}📜 Container logs:${NC}"
    docker logs $CONTAINER_NAME
}

show_status() {
    echo -e "${BLUE}📊 Container status:${NC}"
    if docker ps -q -f name=$CONTAINER_NAME | grep -q .; then
        echo -e "${GREEN}✅ Container is running${NC}"
        docker ps -f name=$CONTAINER_NAME --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"
    else
        echo -e "${RED}❌ Container is not running${NC}"
    fi
}

clean_environment() {
    echo -e "${YELLOW}⚠️  This will remove the container and all data. Continue? (y/N)${NC}"
    read -r response
    if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
        echo -e "${BLUE}🧹 Cleaning up environment...${NC}"
        docker-compose down -v
        docker system prune -f
        echo -e "${GREEN}✅ Environment cleaned successfully!${NC}"
    else
        echo -e "${BLUE}❌ Cleanup cancelled${NC}"
    fi
}

# Main script logic
check_docker

case "${1:-help}" in
    "start")
        start_environment
        ;;
    "stop")
        stop_environment
        ;;
    "restart")
        restart_environment
        ;;
    "shell")
        open_shell
        ;;
    "jupyter")
        open_jupyter
        ;;
    "spark")
        start_spark
        ;;
    "test")
        run_test
        ;;
    "logs")
        show_logs
        ;;
    "status")
        show_status
        ;;
    "clean")
        clean_environment
        ;;
    "help"|*)
        print_usage
        ;;
esac