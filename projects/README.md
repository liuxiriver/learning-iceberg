# Projects Overview

This directory contains all hands-on projects for learning Apache Iceberg. Each project corresponds to a key learning phase and is designed to reinforce both theoretical knowledge and practical skills.

## Table of Contents

- [Phase 1: Core Concepts Mastery](#phase-1-core-concepts-mastery)
- [Phase 2: Hands-on Practice](#phase-2-hands-on-practice)
- [Phase 3: Architecture Deep Dive](#phase-3-architecture-deep-dive)
- [Phase 4: Production Applications](#phase-4-production-applications)
- [Project Workflow & Best Practices](#project-workflow--best-practices)

---

## Phase 1: Core Concepts Mastery
**Goal:** Understand the value, architecture, and basic features of Apache Iceberg.

**Project:** `01-core-concepts/`
- Explore open table format concepts
- Compare Iceberg with traditional Hive tables
- Study the evolution from data lakes to data warehouses
- Deep dive into core features:
  - Schema Evolution
  - Hidden Partitioning
  - Time Travel
  - ACID Transactions
  - Multi-engine Support

**Deliverables:**
- Summary notes (notebook or markdown)
- Key concept mindmap or diagram
- Q&A or FAQ for this phase

**Self-Check:**
- Can you explain Iceberg's core value and use cases?
- Can you describe the differences between Iceberg and Hive tables?

---

## Phase 2: Hands-on Practice
**Goal:** Set up and run Iceberg in a local environment, and master basic operations.

**Project:** `02-hands-on-practice/`
- Environment setup (Docker, Java, Spark)
- Spark + Iceberg integration
- Create your first Iceberg table
- Insert and query test data
- Practice schema evolution (add/modify/remove columns)
- Explore time travel features (snapshots, rollback)

**Deliverables:**
- Jupyter notebooks with step-by-step operations
- Screenshots or outputs of successful table creation and queries
- Troubleshooting notes for any issues encountered

**Self-Check:**
- Can you create and query an Iceberg table from scratch?
- Can you perform schema evolution and time travel queries?

---

## Phase 3: Architecture Deep Dive
**Goal:** Gain a deep understanding of Iceberg's internal architecture and advanced features.

**Project:** `03-architecture-deep-dive/`
- Analyze core modules: iceberg-api, iceberg-core, iceberg-data
- Study storage format support: Parquet, ORC
- Explore Java API for table operations
- Implement custom data read/write logic
- Investigate metadata management mechanisms
- Experiment with performance optimization:
  - File size tuning
  - Partition design
  - Compression algorithms
  - Query optimization

**Deliverables:**
- Technical analysis notes (notebook or markdown)
- Example code for Java API usage
- Performance test results and summary

**Self-Check:**
- Can you explain the role of each core module?
- Can you use the Java API for advanced table operations?
- Can you identify and apply performance optimization strategies?

---

## Phase 4: Production Applications
**Goal:** Master deployment, integration, and operations in production environments.

**Project:** `04-production-applications/`
- Cloud platform integration (AWS, Azure, GCP)
- S3/Glue/ADLS configuration
- Multi-engine support (Spark, Flink, Trino)
- Table maintenance (compaction, snapshot cleanup, stats update)
- Monitoring and debugging (metrics, logs, troubleshooting)

**Deliverables:**
- Cloud deployment scripts/configs
- Maintenance and monitoring guides
- Case studies or real-world integration examples

**Self-Check:**
- Can you deploy and operate Iceberg in a cloud environment?
- Can you perform table maintenance and monitor performance?
- Can you troubleshoot and resolve common production issues?

---

## Project Workflow & Best Practices

1. **Read the project README** to understand objectives and requirements.
2. **Prepare the environment** using provided scripts/configs.
3. **Follow the step-by-step notebooks or scripts** for each task.
4. **Document problems and solutions** in each project.
5. **Summarize key learnings** at the end of each phase.
6. **Review self-check questions** to ensure mastery before moving to the next phase.

---

This structure ensures a progressive, project-driven learning experience. Each phase builds on the previous one, helping you grow from beginner to production-ready Iceberg practitioner.

## 📂 Project Structure

```
projects/
├── 01-first-iceberg-table/         # ✅ Project 1: First Iceberg Table (Completed)
│   ├── docker-compose.yml          # Docker environment configuration
│   ├── manage.sh                   # Environment management script
│   ├── notebooks/                  # Jupyter tutorials and examples
│   │   └── iceberg-tutorial.ipynb  # Complete Iceberg tutorial
│   ├── scripts/                    # Test scripts
│   ├── warehouse/                  # Iceberg table storage location
│   ├── README.md                   # Detailed project documentation
│   └── SPARK_VS_ICEBERG.md        # Spark vs Iceberg relationship documentation
├── 02-schema-evolution/            # ✅ Project 2: Schema Evolution Experiments (Completed)
│   ├── docker-compose.yml          # Docker environment configuration
│   ├── manage.sh                   # Environment management script
│   ├── notebooks/                  # Schema evolution tutorials
│   │   └── schema-evolution-tutorial.ipynb  # Complete schema evolution tutorial
│   ├── scripts/                    # Demo and validation scripts
│   │   ├── schema-evolution-demo.py         # Interactive demo script
│   │   └── validation-tests.py             # Comprehensive validation tests
│   ├── test-data/                  # Sample data for testing
│   │   ├── users-v1.json           # Initial user data
│   │   └── users-v2.json           # Evolved user data
│   ├── warehouse/                  # Iceberg table storage location
│   └── README.md                   # Detailed project documentation
├── 03-time-travel/                 # Project 3: Time Travel Features (Planned)
│   ├── demo/                       # Demo code
│   └── README.md                   # Project documentation
├── 04-cloud-integration/           # Project 4: Cloud Platform Integration (Planned)
│   ├── aws/                        # AWS configuration
│   ├── azure/                      # Azure configuration
│   └── README.md                   # Project documentation
└── 05-production-pipeline/         # Project 5: Production Data Pipeline (Planned)
    ├── spark-jobs/                 # Spark jobs
    ├── monitoring/                 # Monitoring configuration
    └── README.md                   # Project documentation
```

## 🎯 Project Completion Status

### ✅ Project 1: First Iceberg Table (Completed)
- **Learning Goal**: Master basic Iceberg table creation and operations ✅
- **Tech Stack**: Docker, Spark, Iceberg, Jupyter Notebook ✅
- **Completion Time**: Completed
- **Main Achievements**:
  - ✅ Built complete Docker development environment
  - ✅ Successfully integrated Spark 3.5.0 + Iceberg 1.4.3
  - ✅ Created interactive Jupyter tutorial
  - ✅ Implemented data insertion, querying and metadata exploration
  - ✅ Resolved Python version conflicts and permission issues
  - ✅ Verified partitioning and ACID transaction features

### ✅ Project 2: Schema Evolution Experiments (Completed)
- **Learning Goal**: Master Iceberg's schema evolution capabilities ✅
- **Tech Stack**: Docker, Spark SQL, Schema management, Jupyter Notebook ✅
- **Completion Time**: Completed
- **Main Achievements**:
  - ✅ Built comprehensive schema evolution environment
  - ✅ Demonstrated safe column addition and type promotions
  - ✅ Implemented complex nested data structures (maps, arrays, structs)
  - ✅ Created interactive Jupyter tutorial with real-world scenarios
  - ✅ Developed validation framework for schema evolution testing
  - ✅ Verified backward and forward compatibility features
  - ✅ Performance analysis of schema changes

### 🔄 Project 3: Time Travel Features (Planned)
- **Learning Goal**: Master snapshot management and time travel queries
- **Tech Stack**: Spark SQL, Snapshot API
- **Estimated Time**: 2 days

### 🔄 Project 4: Cloud Platform Integration (Planned)
- **Learning Goal**: Deploy and use Iceberg in cloud environments
- **Tech Stack**: AWS S3/Glue, or Azure ADLS
- **Estimated Time**: 3-5 days

### 🔄 Project 5: Production Data Pipeline (Planned)
- **Learning Goal**: Build complete production-grade data pipeline
- **Tech Stack**: Spark, Cloud services, Monitoring
- **Estimated Time**: 1-2 weeks

## 📋 Project Completion Results

### Project 1: First Iceberg Table ✅

### 🛠️ Technical Environment
- **Dockerized Deployment**: One-click Spark + Iceberg environment
- **Jupyter Integration**: Interactive learning and experimentation platform
- **Permission Management**: Resolved container permissions and Python version issues

### 📊 Implemented Features
- **Table Creation**: Create partitioned tables using `USING ICEBERG` syntax
- **Data Operations**: Successfully inserted 8 user event records
- **Partitioning Strategy**: Automatic partitioning by date (`days(event_time)`)
- **Metadata Queries**:
  - `.snapshots` - View table snapshot history
  - `.files` - View physical file distribution
  - `.history` - View table change history

### 🎯 Verification Results
- ✅ Created `local.demo.user_events` table
- ✅ Data correctly partitioned to 2024-01-15 and 2024-01-16
- ✅ Generated 2 Parquet files (6+2 records)
- ✅ All metadata queries working normally
- ✅ ACID transaction features verified

### Project 2: Schema Evolution Experiments ✅

### 🛠️ Technical Environment
- **Dockerized Deployment**: Dedicated schema evolution environment (port 8889)
- **Jupyter Integration**: Interactive schema evolution tutorial and experiments
- **Validation Framework**: Comprehensive testing and validation scripts

### 📊 Implemented Features
- **Column Operations**: Safe addition, removal, and renaming of columns
- **Type Promotions**: int→bigint, float→double, decimal precision increases
- **Complex Types**: Maps, arrays, structs with nested data structures
- **Real-World Scenarios**: E-commerce, IoT, analytics table evolution patterns
- **Compatibility Testing**: Backward and forward compatibility validation

### 🎯 Verification Results
- ✅ Created multiple evolved tables (users, metrics, products)
- ✅ Successfully added nullable columns without data rewriting
- ✅ Performed safe type promotions maintaining data integrity
- ✅ Implemented complex nested structures with maps and arrays
- ✅ Validated historical data accessibility after schema changes
- ✅ Performance analysis showing minimal impact of schema evolution

## 📋 Project Completion Checklist

### Project 1 Checklist ✅
- [x] Code runs successfully
- [x] Detailed README documentation
- [x] Includes execution steps and result screenshots
- [x] Records problems encountered and solutions
- [x] Summarizes key concepts learned
- [x] Complete Docker environment configuration
- [x] Reproducible Jupyter tutorial execution

### Project 2 Checklist ✅
- [x] Code runs successfully
- [x] Detailed README documentation
- [x] Includes execution steps and result screenshots
- [x] Records problems encountered and solutions
- [x] Summarizes key concepts learned
- [x] Complete Docker environment configuration
- [x] Reproducible Jupyter tutorial execution
- [x] Comprehensive validation tests
- [x] Real-world scenario demonstrations

### Future Projects Checklist
- [ ] Code runs successfully
- [ ] Detailed README documentation
- [ ] Includes execution steps and result screenshots
- [ ] Records problems encountered and solutions
- [ ] Summarizes key concepts learned

## 🔧 Development Environment Requirements

### Basic Environment ✅
- Java 11/17/21
- Apache Spark 3.5.0 ✅
- Docker (for local testing) ✅
- Iceberg 1.4.3 ✅

### Cloud Environment (Optional)
- AWS Account (S3, Glue, EMR)
- Azure Account (ADLS, Synapse)
- GCP Account (GCS, Dataproc)

## 📖 Learning Process Summary

### Project 1 Learning Gains ✅
1. **Environment Setup** - Mastered Docker-based Iceberg development environment ✅
2. **Basic Concepts** - Understood Spark engine + Iceberg table format architecture ✅
3. **Practical Operations** - Completed table creation, data insertion, query analysis ✅
4. **Problem Solving** - Handled Python version conflicts, permission configuration issues ✅
5. **Feature Verification** - Verified partitioning, transactions, metadata core features ✅

### Future Project Workflow
1. **Read Project Documentation** - Understand goals and requirements
2. **Environment Preparation** - Set up necessary development environment
3. **Code Implementation** - Complete project code step by step
4. **Testing and Verification** - Run and verify results
5. **Documentation** - Update README and learning notes
6. **Problem Summary** - Record problems encountered and solutions

## 🎯 Current Learning Achievements

After completing Project 1, you can now:

- ✅ Independently set up Iceberg development environment
- ✅ Create and manage basic Iceberg tables
- ✅ Use partitioning strategies to optimize data storage
- ✅ Query and analyze Iceberg table metadata
- ✅ Understand Spark and Iceberg integration mechanisms
- ✅ Troubleshoot and resolve common environment issues

After completing Project 2, you can now:

- ✅ Safely evolve table schemas without breaking existing applications
- ✅ Add, remove, and rename columns while maintaining data integrity
- ✅ Perform safe data type promotions for growing data requirements
- ✅ Design complex nested data structures for flexible data modeling
- ✅ Validate schema compatibility across different time periods
- ✅ Analyze performance impact of schema evolution operations

## 🚀 Next Steps Recommendations

Based on Projects 1 & 2 successful completion, suggested continuation order:

1. **✅ Project 1 - Core Concepts**: Master basic Iceberg table operations ✅
2. **✅ Project 2 - Schema Evolution**: Master schema evolution capabilities ✅ 
3. **Project 3 - Time Travel**: Demonstrate time travel queries and snapshot management
4. **Project 4 - Cloud Integration**: Migrate environment to cloud platforms
5. **Project 5 - Production Pipeline**: Build complete production data flows

---

**Completed Projects**:
- [01-core-concepts - First Iceberg Table](01-core-concepts/README.md) ✅
- [02-schema-evolution - Schema Evolution Experiments](02-schema-evolution/README.md) ✅

**Start Next Project**: Time Travel Features (Coming Soon)