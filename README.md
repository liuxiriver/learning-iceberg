# Apache Iceberg Learning Repository

## Project Overview
This repository is designed for systematic learning and hands-on practice with Apache Iceberg. It is structured to be beginner-friendly, easy to maintain, and suitable for both self-study and onboarding new data engineers.

## Directory Structure

```
learning-iceberg/
  README.md            # Project overview and learning roadmap
  docs/                # Documentation: concepts, Q&A, notes, best practices
    concepts/          # Core concepts and theory (e.g., Table Format, Schema Evolution)
    faq.md             # Frequently asked questions and troubleshooting
    notes/             # Personal or team learning notes (by date or topic)
  notebooks/           # All Jupyter/Zeppelin notebooks, organized by topic or date
  projects/            # Hands-on projects, each in a separate subdirectory
    01-first-iceberg-table/
      notebooks/
      scripts/
      README.md
      ...
  data/                # Sample and experiment datasets for notebooks/scripts
  env/                 # Environment configuration (docker-compose, manage.sh, etc.)
  resources/           # Reference materials, quick start guides, external links
```

## Directory Descriptions

- **docs/**: Centralized documentation for theory, Q&A, and learning notes. Includes core concepts, best practices, and troubleshooting.
- **notebooks/**: All learning and experiment notebooks. Each notebook is self-contained and references data from the `data/` directory.
- **projects/**: Practical projects, each with its own code, notebooks, and documentation. Projects are numbered and themed for progressive learning.
- **data/**: Datasets used for experiments and notebook demonstrations. Ensures reproducibility and easy data access.
- **env/**: Environment setup files, such as Docker Compose, shell scripts, and configuration templates for quick environment provisioning.
- **resources/**: Additional reference materials, quick start command guides, and useful external resources.

## Getting Started
1. Set up your environment using files in the `env/` directory (e.g., `docker-compose.yml`, `manage.sh`).
2. Explore theoretical knowledge and Q&A in the `docs/` directory.
3. Run and experiment with notebooks in the `notebooks/` directory.
4. Dive into hands-on projects in the `projects/` directory for practical experience.
5. Use datasets from the `data/` directory for all experiments and notebooks.

## Contribution Guide
- Add new concepts, notes, or Q&A to the `docs/` directory.
- Place new notebooks in the `notebooks/` directory, using clear and descriptive names.
- For new projects, create a subdirectory under `projects/` with its own `README.md`.
- Store all sample data in the `data/` directory.
- Update the `README.md` to reflect any major structural or learning path changes.

---

This structure ensures clarity, ease of use, and scalability for both individual learners and teams. Happy learning with Apache Iceberg!

## 🎯 Learning Objectives

- Understand the core concepts and architecture of Apache Iceberg, including its advantages over traditional table formats.
- Gain hands-on experience with Iceberg table creation, data insertion, querying, schema evolution, and time travel features.
- Learn to set up and configure Iceberg environments locally (via Docker) and on cloud platforms.
- Master best practices for partitioning, file layout, metadata management, and table maintenance.
- Develop troubleshooting skills for common issues encountered in Iceberg usage.
- Integrate Iceberg with major compute engines (Spark, Flink, Trino) and cloud storage solutions.
- Achieve the ability to design, deploy, and operate Iceberg-based data lakes in production environments.
- Build a reusable knowledge base and practical project portfolio for future reference and team onboarding.

## 📚 Learning Path

### Phase 1: Core Concepts Mastery (Week 1-2)
**Goal**: Understand Iceberg's core value and basic concepts

#### 📖 Theoretical Learning
- [ ] **What is Apache Iceberg?**
  - Open table format concepts
  - Differences from traditional Hive tables
  - Evolution from data lakes to data warehouses

- [ ] **Deep dive into core features**
  - [ ] Schema Evolution - Painless schema changes
  - [ ] Hidden Partitioning - Automatic partition management
  - [ ] Time Travel - Time travel queries
  - [ ] ACID Transactions - Data consistency guarantees
  - [ ] Multi-engine Support - Spark/Flink/Trino etc.

#### 🔍 Recommended Reading
- [ ] Official homepage: https://iceberg.apache.org/
- [ ] Iceberg specification: https://iceberg.apache.org/spec/
- [ ] `docs/docs/index.md` - Project overview
- [ ] `docs/docs/reliability.md` - Reliability features
- [ ] `docs/docs/performance.md` - Performance features

**Completion Criteria**: Able to explain Iceberg's core value and use cases to colleagues

---

### Phase 2: Hands-on Practice (Week 3-5)
**Goal**: Set up and run Iceberg in local environment

#### 🛠️ Environment Setup
- [ ] **Local Development Environment**
  - [ ] Install Java 11/17/21
  - [ ] Clone and build project: `./gradlew build`
  - [ ] Configure IDE (IntelliJ IDEA recommended)

- [ ] **Spark Integration Practice**
  - [ ] Read: `docs/docs/spark-getting-started.md`
  - [ ] Set up Spark + Iceberg environment
  - [ ] Run first example

#### 💡 Core Practice Projects
- [ ] **Project 1: Create First Iceberg Table**
  - Create table using Spark
  - Insert test data
  - Query and verify

- [ ] **Project 2: Schema Evolution Experiments**
  - Add new columns
  - Modify column types
  - Remove columns and verify data integrity

- [ ] **Project 3: Time Travel Features**
  - Create multiple snapshots
  - Query historical data
  - Version rollback operations

#### 📋 Learning Checkpoints
- [ ] Successfully create and query Iceberg tables
- [ ] Understand table file organization structure
- [ ] Master basic DDL and DML operations

---

### Phase 3: Architecture Deep Dive (Week 6-8)
**Goal**: Deep understanding of Iceberg internal architecture and design principles

#### 🏗️ Architecture Learning
- [ ] **Core Module Analysis**
  - [ ] `iceberg-api` - Public interface design
  - [ ] `iceberg-core` - Core implementation logic
  - [ ] `iceberg-data` - Data access layer

- [ ] **Storage Format Support**
  - [ ] `iceberg-parquet` - Parquet integration
  - [ ] `iceberg-orc` - ORC integration
  - [ ] Format selection and optimization strategies

#### 🔧 Java API Deep Dive
- [ ] Read: `docs/docs/java-api-quickstart.md`
- [ ] Understand table operation APIs
- [ ] Custom data read/write logic
- [ ] Metadata management mechanisms

#### 📊 Performance Optimization Learning
- [ ] File size tuning strategies
- [ ] Partition design best practices
- [ ] Compression algorithm selection
- [ ] Query optimization techniques

---

### Phase 4: Production Applications (Week 9-12)
**Goal**: Master production environment deployment and operations

#### ☁️ Cloud Platform Integration
- [ ] **AWS Integration**
  - [ ] Read: `docs/docs/aws.md`
  - [ ] S3 storage configuration
  - [ ] Glue Catalog integration
  - [ ] IAM permission configuration

- [ ] **Multi-engine Support**
  - [ ] Spark integration optimization
  - [ ] Flink streaming integration
  - [ ] Trino query engine configuration

#### 🔧 Operations Practice
- [ ] **Table Maintenance Operations**
  - [ ] Read: `docs/docs/maintenance.md`
  - [ ] File compaction strategies
  - [ ] Snapshot cleanup
  - [ ] Statistics updates

- [ ] **Monitoring and Debugging**
  - [ ] Performance monitoring metrics
  - [ ] Common issue troubleshooting
  - [ ] Log analysis techniques

---

## 📈 Learning Progress Tracking

### Weekly Learning Plan
| Week | Main Tasks | Status | Notes |
|------|------------|---------|-------|
| Week 1 | Core concepts learning | ✅ Completed | Basic concepts learning done |
| Week 2 | Theory consolidation | ⏳ In Progress | Started environment setup and practice |
| Week 3 | Environment setup | ⭕ Not Started | |
| Week 4-5 | Spark integration practice | ⭕ Not Started | |
| Week 6-7 | Architecture deep learning | ⭕ Not Started | |
| Week 8 | Java API mastery | ⭕ Not Started | |
| Week 9-10 | Cloud platform integration | ⭕ Not Started | |
| Week 11-12 | Production operations practice | ⭕ Not Started | |

### Key Milestones
- [ ] **Milestone 1**: Complete creation and querying of first Iceberg table
- [ ] **Milestone 2**: Successfully demonstrate Schema Evolution functionality
- [ ] **Milestone 3**: Deploy Iceberg production tables in cloud environment
- [ ] **Milestone 4**: Integrate into existing data pipeline

---

## 📝 Learning Notes Template

### Daily Learning Records
Create format: `notes/YYYY-MM-DD.md`
- Today's learning content
- Key concept understanding
- Practice operation records
- Problems encountered and solutions
- Tomorrow's plan

### Practice Project Records
- `projects/` - Actual code and configurations
- `examples/` - Example code during learning
- `troubleshooting/` - Problem troubleshooting records

---

## 🎯 Learning Achievement Validation

### Theoretical Mastery Self-Assessment
- [ ] Can explain Iceberg's advantages over traditional table formats
- [ ] Understand the importance of ACID transactions in data lakes
- [ ] Master partition strategy design principles
- [ ] Understand multi-engine concurrent access mechanisms

### Practical Capability Verification
- [ ] Independently set up Iceberg development environment
- [ ] Design and implement data migration solutions
- [ ] Solve production environment performance issues
- [ ] Provide technical training for the team

---

## 📚 Reference Resources

### Official Resources
- [Apache Iceberg Official Website](https://iceberg.apache.org/)
- [Iceberg GitHub Repository](https://github.com/apache/iceberg)
- [Official Documentation](https://iceberg.apache.org/docs/latest/)

### Community Resources
- [Iceberg Slack Community](https://apache-iceberg.slack.com/)
- [Mailing List](mailto:dev@iceberg.apache.org)
- [Technical Blogs and Case Studies]

### Related Technology Stack
- Apache Spark
- Apache Flink
- Trino/Presto
- Cloud Storage Services (S3/ADLS/GCS)

---

**Last Updated**: 2025-06-09
**Learner**: [Your Name]
**Current Progress**: Phase 1 - Core concepts learning in progress