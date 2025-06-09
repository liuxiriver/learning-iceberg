# Apache Iceberg Quick Start Commands Reference

## 🐳 Docker-First Development Environment (Recommended)

### Quick Start Iceberg + Spark Environment
```bash
# Navigate to project directory
cd learning-iceberg/projects/01-first-iceberg-table

# One-click environment startup
./manage.sh start

# Check service status
./manage.sh status

# Access Jupyter Lab (open browser at http://localhost:8888)
# or enter Spark Shell
./manage.sh spark

# Stop environment
./manage.sh stop
```

### Docker Environment Configuration
```yaml
# docker-compose.yml reference configuration
version: '3.8'
services:
  jupyter:
    image: jupyter/pyspark-notebook:spark-3.5.0
    ports:
      - "8888:8888"
      - "4040:4040"  # Spark UI
    environment:
      # Resolve Python version conflicts
      - PYSPARK_PYTHON=/opt/conda/bin/python
      - PYSPARK_DRIVER_PYTHON=/opt/conda/bin/python
      # Spark configuration
      - SPARK_OPTS=--packages org.apache.iceberg:iceberg-spark-runtime-3.5_2.12:1.4.3
    volumes:
      - ./warehouse:/home/jovyan/warehouse:rw
      - ./notebooks:/home/jovyan/work:rw
    command: start-notebook.sh --NotebookApp.token=''
```

### Environment Management Script
```bash
# manage.sh usage
./manage.sh start      # Start all services
./manage.sh stop       # Stop all services
./manage.sh restart    # Restart services
./manage.sh shell      # Enter container bash
./manage.sh spark      # Start Spark Shell
./manage.sh logs       # View logs
./manage.sh status     # Check service status
./manage.sh clean      # Clean environment and data
```

## 🚀 Iceberg Basic Operations (Jupyter/PySpark)

### Environment Initialization
```python
# Initialization code in Jupyter Notebook
import os
from pyspark.sql import SparkSession

# Ensure consistent Python paths
os.environ['PYSPARK_PYTHON'] = '/opt/conda/bin/python'
os.environ['PYSPARK_DRIVER_PYTHON'] = '/opt/conda/bin/python'

# Create Spark Session with Iceberg support
spark = SparkSession.builder \
    .appName("IcebergTutorial") \
    .config("spark.jars.packages", "org.apache.iceberg:iceberg-spark-runtime-3.5_2.12:1.4.3") \
    .config("spark.sql.extensions", "org.apache.iceberg.spark.extensions.IcebergSparkSessionExtensions") \
    .config("spark.sql.catalog.local", "org.apache.iceberg.spark.SparkCatalog") \
    .config("spark.sql.catalog.local.type", "hadoop") \
    .config("spark.sql.catalog.local.warehouse", "/home/jovyan/warehouse") \
    .getOrCreate()

# Verify environment
print(f"Spark Version: {spark.version}")
print("Iceberg environment ready!")
```

### Basic Table Operations
```python
# Create database
spark.sql("CREATE NAMESPACE IF NOT EXISTS local.demo")

# Create Iceberg table
spark.sql("""
CREATE TABLE IF NOT EXISTS local.demo.user_events (
    user_id BIGINT,
    event_type STRING,
    event_time TIMESTAMP,
    page_url STRING,
    user_agent STRING
) USING ICEBERG
PARTITIONED BY (days(event_time))
""")

# Insert test data
spark.sql("""
INSERT INTO local.demo.user_events VALUES
    (1001, 'page_view', TIMESTAMP '2024-01-15 10:30:00', '/home', 'Chrome/96.0'),
    (1002, 'click', TIMESTAMP '2024-01-15 11:15:00', '/products', 'Firefox/95.0'),
    (1003, 'page_view', TIMESTAMP '2024-01-16 09:45:00', '/about', 'Safari/15.0')
""")

# Query data
result = spark.sql("SELECT * FROM local.demo.user_events ORDER BY event_time")
result.show()
```

### Metadata Queries
```python
# View table snapshots
snapshots = spark.sql("SELECT * FROM local.demo.user_events.snapshots")
snapshots.show(truncate=False)

# View files information
files = spark.sql("SELECT * FROM local.demo.user_events.files")
files.show(truncate=False)

# View table history
history = spark.sql("SELECT made_current_at, snapshot_id, parent_id, is_current_ancestor FROM local.demo.user_events.history")
history.show()

# View partition information
partitions = spark.sql("SHOW PARTITIONS local.demo.user_events")
partitions.show()
```

## 🔧 Fallback: Local Environment (Not Recommended)

### Java Environment Check
```bash
# Check Java version (requires 11/17/21)
java -version
javac -version

# Set JAVA_HOME (if needed)
export JAVA_HOME=/path/to/java
```

### Local Spark Shell (if needed)
```bash
# Start Spark Shell with Iceberg (local approach)
spark-shell \
  --packages org.apache.iceberg:iceberg-spark-runtime-3.5_2.12:1.4.3 \
  --conf spark.sql.extensions=org.apache.iceberg.spark.extensions.IcebergSparkSessionExtensions \
  --conf spark.sql.catalog.local=org.apache.iceberg.spark.SparkCatalog \
  --conf spark.sql.catalog.local.type=hadoop \
  --conf spark.sql.catalog.local.warehouse=/tmp/warehouse
```

## 📊 Advanced Operations Examples

### Schema Evolution
```python
# Add new column
spark.sql("ALTER TABLE local.demo.user_events ADD COLUMN session_id STRING")

# View schema changes
spark.sql("DESCRIBE local.demo.user_events").show()

# Insert data with new column
spark.sql("""
INSERT INTO local.demo.user_events VALUES
    (1004, 'login', TIMESTAMP '2024-01-16 14:20:00', '/login', 'Chrome/96.0', 'sess_12345')
""")
```

### Time Travel
```python
# Get table snapshot IDs
snapshots = spark.sql("SELECT snapshot_id, committed_at FROM local.demo.user_events.snapshots ORDER BY committed_at")
snapshots.show()

# Query historical data by snapshot ID
snapshot_id = "your_snapshot_id_here"
historical_data = spark.sql(f"""
SELECT * FROM local.demo.user_events VERSION AS OF {snapshot_id}
""")
historical_data.show()

# Query historical data by timestamp (if supported)
historical_data_time = spark.sql("""
SELECT * FROM local.demo.user_events TIMESTAMP AS OF '2024-01-15 12:00:00'
""")
```

### Partitioning and Performance Optimization
```python
# View partition distribution
partition_info = spark.sql("""
SELECT
    partition,
    record_count,
    file_count
FROM local.demo.user_events.partitions
""")
partition_info.show()

# Table maintenance - compact small files
spark.sql("CALL local.system.rewrite_data_files('local.demo.user_events')")

# Expire old snapshots (keep last 7 days)
spark.sql("CALL local.system.expire_snapshots('local.demo.user_events', TIMESTAMP '2024-01-10 00:00:00')")
```

## 🔍 Debugging and Troubleshooting

### Docker Environment Debugging
```bash
# View container logs
docker-compose logs jupyter

# Enter container for debugging
docker exec -it <container_name> bash

# Check Spark UI
# Browser access: http://localhost:4040

# Check mounted directory permissions
ls -la warehouse/
```

### Common Issue Solutions
```bash
# Fix permission issues
chmod -R 777 warehouse/

# Resolve Python version conflicts
# Set environment variables in docker-compose.yml:
# PYSPARK_PYTHON=/opt/conda/bin/python
# PYSPARK_DRIVER_PYTHON=/opt/conda/bin/python

# Clean and reset environment
./manage.sh clean
./manage.sh start
```

### Jupyter Notebook Debugging
```python
# Check Spark configuration
print("Spark Configuration:")
for item in spark.sparkContext.getConf().getAll():
    print(f"{item[0]} = {item[1]}")

# Check if Iceberg packages are loaded
spark.sql("SHOW JARS").filter("col like '%iceberg%'").show(truncate=False)

# Check warehouse directory
import os
warehouse_path = "/home/jovyan/warehouse"
if os.path.exists(warehouse_path):
    print(f"Warehouse directory exists: {warehouse_path}")
    print(f"Contents: {os.listdir(warehouse_path)}")
else:
    print(f"Warehouse directory not found: {warehouse_path}")
```

## 📁 Recommended Project Structure

### Dockerized Project Structure
```
01-first-iceberg-table/
├── docker-compose.yml          # Docker environment configuration
├── manage.sh                   # Environment management script
├── notebooks/                  # Jupyter tutorials
│   └── iceberg-tutorial.ipynb  # Complete tutorial
├── scripts/                    # Test scripts
├── warehouse/                  # Iceberg table storage
│   └── demo/                   # Database directory
├── README.md                   # Project documentation
└── SPARK_VS_ICEBERG.md        # Technical documentation
```

## 🎯 Learning Checkpoints

### Docker Environment Verification
- [ ] Docker Compose starts successfully
- [ ] Jupyter Lab accessible (localhost:8888)
- [ ] Spark configuration loads correctly
- [ ] Iceberg packages integrated properly

### Basic Operations Verification
- [ ] Iceberg table creation successful
- [ ] Data insertion and querying normal
- [ ] Partitioning functions correctly
- [ ] Metadata queries successful

### Advanced Features Verification
- [ ] Schema Evolution successful
- [ ] Snapshot management normal
- [ ] Time Travel queries available
- [ ] Table maintenance operations successful

---

**Environment Versions**:
- Docker: Latest stable version recommended
- Spark: 3.5.0
- Iceberg: 1.4.3
- Python: 3.11 (within container)

**Last Updated**: 2024-01-XX
**Based on**: Successful Docker + Jupyter environment practice