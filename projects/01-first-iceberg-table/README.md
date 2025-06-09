# Project 1: Your First Iceberg Table

**Learning Objective**: Create, operate and query Iceberg tables using Docker + Spark

## 📋 Project Overview

In this project, you will:
1. Set up Spark + Iceberg environment with Docker
2. Create your first Iceberg table
3. Insert and query data
4. Understand table file organization structure

## 🐳 Quick Start with Docker

### Prerequisites

- Docker and Docker Compose installed
- Basic understanding of Spark SQL

### 1. Start Environment

```bash
# Start the Iceberg + Spark environment
./manage.sh start

# Check status
./manage.sh status
```

### 2. Run Quick Test

```bash
# Run the built-in test script
./manage.sh test
```

### 3. Interactive Options

**Option A: Jupyter Notebook (Recommended)**
```bash
# Start Jupyter Lab
./manage.sh jupyter
```

**Option B: Spark Shell**
```bash
# Start Spark Shell with Iceberg
./manage.sh spark
```

## 🚀 Hands-on Practice

### Step 1: Create Your First Table

**Using Jupyter Notebook (Recommended):**
1. Run `./manage.sh jupyter` to open Jupyter Lab
2. Open `notebooks/iceberg-tutorial.ipynb`
3. Follow the step-by-step tutorial

**Using Spark Shell:**

```scala
// Create database
spark.sql("CREATE DATABASE IF NOT EXISTS local.demo")

// Create table
spark.sql("""
  CREATE TABLE local.demo.user_events (
    user_id bigint,
    event_type string,
    event_time timestamp,
    page_url string,
    user_agent string
  ) USING ICEBERG
  PARTITIONED BY (days(event_time))
""")

// View table structure
spark.sql("DESCRIBE local.demo.user_events").show()
```

### Step 2: Insert Test Data

```scala
import java.sql.Timestamp

// Create test data
val testData = Seq(
  (1001L, "page_view", Timestamp.valueOf("2024-01-15 10:30:00"), "/home", "Mozilla/5.0"),
  (1001L, "click", Timestamp.valueOf("2024-01-15 10:35:00"), "/products", "Mozilla/5.0"),
  (1002L, "page_view", Timestamp.valueOf("2024-01-15 11:00:00"), "/home", "Chrome/98.0"),
  (1002L, "purchase", Timestamp.valueOf("2024-01-15 11:15:00"), "/checkout", "Chrome/98.0"),
  (1003L, "page_view", Timestamp.valueOf("2024-01-16 09:00:00"), "/home", "Safari/15.0")
)

// Convert to DataFrame
val df = testData.toDF("user_id", "event_type", "event_time", "page_url", "user_agent")

// Insert data
df.writeTo("local.demo.user_events").append()

// Verify data
spark.sql("SELECT COUNT(*) as total_events FROM local.demo.user_events").show()
```

### Step 3: Query and Analysis

```scala
// Basic query
spark.sql("SELECT * FROM local.demo.user_events ORDER BY event_time").show()

// Statistics by date
spark.sql("""
  SELECT DATE(event_time) as event_date,
         COUNT(*) as event_count
  FROM local.demo.user_events
  GROUP BY DATE(event_time)
  ORDER BY event_date
""").show()

// User behavior analysis
spark.sql("""
  SELECT user_id,
         event_type,
         COUNT(*) as count
  FROM local.demo.user_events
  GROUP BY user_id, event_type
  ORDER BY user_id, event_type
""").show()
```

### Step 4: Explore Table Metadata

```scala
// View table snapshots
spark.sql("SELECT * FROM local.demo.user_events.snapshots").show()

// View table files
spark.sql("SELECT * FROM local.demo.user_events.files").show()

// View table history
spark.sql("SELECT * FROM local.demo.user_events.history").show()
```

## 📁 Understanding File Organization

Exit Spark Shell and explore the generated files:

```bash
# Open shell in container
./manage.sh shell

# Inside container, explore warehouse structure
find /opt/warehouse -type f -name "*.parquet" -o -name "*.avro" -o -name "*.json" | head -20

# View metadata files
ls -la /opt/warehouse/demo/user_events/metadata/
```

## 🛠️ Management Commands

The `manage.sh` script provides comprehensive environment management:

```bash
# Environment management
./manage.sh start          # Start Docker environment
./manage.sh stop           # Stop Docker environment
./manage.sh restart        # Restart environment
./manage.sh status         # Check container status

# Interactive access
./manage.sh shell          # Open bash shell in container
./manage.sh spark          # Start Spark Shell with Iceberg

# Testing and debugging
./manage.sh test           # Run test script
./manage.sh logs           # View container logs

# Cleanup
./manage.sh clean          # Remove container and volumes
```

## 🎯 Learning Validation

Complete these tasks to validate your learning:

### Task 1: Data Operations
- [ ] Successfully create an Iceberg table
- [ ] Insert at least 100 test records
- [ ] Execute complex aggregation queries

### Task 2: Understanding Metadata
- [ ] Explain the snapshot concept
- [ ] Find and examine manifest files
- [ ] Understand partition file organization

### Task 3: Performance Observation
- [ ] Compare partitioned vs full table scan performance
- [ ] Observe partition pruning effects

## 🔧 Troubleshooting

### Common Issues

1. **Docker not running**
   ```bash
   # Check Docker status
   docker --version
   docker ps
   ```

2. **Container startup fails**
   ```bash
   # Check logs
   ./manage.sh logs

   # Clean and restart
   ./manage.sh clean
   ./manage.sh start
   ```

3. **Port conflicts**
   ```bash
   # Check if ports are in use
   lsof -i :4040
   lsof -i :8080
   ```

### Performance Tips

1. **Use appropriate partition strategy** - Partition by frequently queried columns
2. **Monitor file sizes** - Aim for 100MB-1GB parquet files
3. **Use projection pushdown** - Select only needed columns

## 📊 Project Structure

```
01-first-iceberg-table/
├── README.md                    # This documentation
├── docker-compose.yml           # Docker service configuration
├── manage.sh                    # Environment management script
├── scripts/
│   └── test-iceberg.scala      # Test script
└── warehouse/                   # Iceberg table storage
```

## 📝 Learning Notes

After completing the project, record:

1. **Problems encountered and solutions**
2. **Understanding of Iceberg table structure**
3. **Differences felt compared to traditional Hive tables**
4. **Next features you want to explore**

---

**Estimated completion time**: 2-3 hours
**Difficulty level**: Beginner
**Prerequisites**: Complete concepts theory learning

## 🌐 Accessing Services

- **Jupyter Lab**: http://localhost:8888 (no password required)
- **Spark UI**: http://localhost:4040 (when Spark is running)
- **Container Logs**: `./manage.sh logs`
- **Warehouse Data**: `./warehouse/` directory

## ❓ Common Questions

**"Are we using Spark or Iceberg?"**
👉 See [SPARK_VS_ICEBERG.md](./SPARK_VS_ICEBERG.md) for a detailed explanation of the relationship between Spark and Iceberg.

## 📖 Related Resources

- [Spark Getting Started](https://iceberg.apache.org/docs/latest/spark-getting-started/)
- [Spark DDL Syntax](https://iceberg.apache.org/docs/latest/spark-ddl/)
- [Spark Query Syntax](https://iceberg.apache.org/docs/latest/spark-queries/)

## 🔄 Next Steps

After completing this project:
1. Explore schema evolution in Project 2
2. Learn about time travel queries
3. Investigate table maintenance operations
4. Study integration with other engines (Flink, Trino)