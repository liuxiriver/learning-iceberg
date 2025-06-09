# 实践项目目录

这个目录用于存放学习过程中的实际项目代码和配置文件。

## 📂 项目结构

```
projects/
├── 01-first-iceberg-table/         # ✅ 项目1：创建第一个Iceberg表 (已完成)
│   ├── docker-compose.yml          # Docker环境配置
│   ├── manage.sh                   # 环境管理脚本
│   ├── notebooks/                  # Jupyter教程和示例
│   │   └── iceberg-tutorial.ipynb  # 完整的Iceberg教程
│   ├── scripts/                    # 测试脚本
│   ├── warehouse/                  # Iceberg表存储位置
│   ├── README.md                   # 项目详细说明
│   └── SPARK_VS_ICEBERG.md        # Spark与Iceberg关系说明
├── 02-schema-evolution/            # 项目2：Schema演进实验 (规划中)
│   ├── scripts/                    # 演示脚本
│   ├── test-data/                  # 测试数据
│   └── README.md                   # 项目说明
├── 03-time-travel/                 # 项目3：时间旅行功能 (规划中)
│   ├── demo/                       # 演示代码
│   └── README.md                   # 项目说明
├── 04-cloud-integration/           # 项目4：云平台集成 (规划中)
│   ├── aws/                        # AWS配置
│   ├── azure/                      # Azure配置
│   └── README.md                   # 项目说明
└── 05-production-pipeline/         # 项目5：生产数据管道 (规划中)
    ├── spark-jobs/                 # Spark作业
    ├── monitoring/                 # 监控配置
    └── README.md                   # 项目说明
```

## 🎯 项目完成状态

### ✅ Project 1: 创建第一个Iceberg表 (已完成)
- **学习目标**: 掌握Iceberg表的基本创建和操作 ✅
- **技术栈**: Docker, Spark, Iceberg, Jupyter Notebook ✅
- **完成时间**: 已完成
- **主要成果**:
  - ✅ 搭建了完整的Docker开发环境
  - ✅ 成功集成Spark 3.5.0 + Iceberg 1.4.3
  - ✅ 创建了交互式Jupyter教程
  - ✅ 实现了数据插入、查询和metadata探索
  - ✅ 解决了Python版本冲突和权限问题
  - ✅ 验证了分区功能和ACID事务特性

### 🔄 Project 2: Schema Evolution实验 (规划中)
- **学习目标**: 理解并实践schema演进功能
- **技术栈**: Spark SQL, Schema管理
- **预计时间**: 2-3天

### 🔄 Project 3: Time Travel功能 (规划中)
- **学习目标**: 掌握快照管理和时间旅行查询
- **技术栈**: Spark SQL, 快照API
- **预计时间**: 2天

### 🔄 Project 4: 云平台集成 (规划中)
- **学习目标**: 在云环境中部署和使用Iceberg
- **技术栈**: AWS S3/Glue, 或 Azure ADLS
- **预计时间**: 3-5天

### 🔄 Project 5: 生产数据管道 (规划中)
- **学习目标**: 构建完整的生产级数据管道
- **技术栈**: Spark, 云服务, 监控
- **预计时间**: 1-2周

## 📋 项目1完成成果 ✅

### 🛠️ 技术环境
- **Docker化部署**: 一键启动的Spark + Iceberg环境
- **Jupyter集成**: 交互式学习和实验平台
- **权限管理**: 解决了容器权限和Python版本问题

### 📊 实现功能
- **表创建**: 使用`USING ICEBERG`语法创建分区表
- **数据操作**: 成功插入8条用户事件数据
- **分区策略**: 按日期(`days(event_time)`)自动分区
- **元数据查询**:
  - `.snapshots` - 查看表快照历史
  - `.files` - 查看物理文件分布
  - `.history` - 查看表变更历史

### 🎯 验证结果
- ✅ 创建了`local.demo.user_events`表
- ✅ 数据正确分区到2024-01-15和2024-01-16
- ✅ 生成了2个Parquet文件（6+2条记录）
- ✅ Metadata查询全部正常工作
- ✅ ACID事务特性得到验证

## 📋 项目完成检查清单

### Project 1 检查清单 ✅
- [x] 代码可以成功运行
- [x] 有详细的README说明
- [x] 包含执行步骤和结果截图
- [x] 记录遇到的问题和解决方案
- [x] 总结学到的关键概念
- [x] Docker环境配置完整
- [x] Jupyter教程可重现执行

### 后续项目检查清单
- [ ] 代码可以成功运行
- [ ] 有详细的README说明
- [ ] 包含执行步骤和结果截图
- [ ] 记录遇到的问题和解决方案
- [ ] 总结学到的关键概念

## 🔧 开发环境要求

### 基础环境 ✅
- Java 11/17/21
- Apache Spark 3.5.0 ✅
- Docker (用于本地测试) ✅
- Iceberg 1.4.3 ✅

### 云环境 (可选)
- AWS账户 (S3, Glue, EMR)
- Azure账户 (ADLS, Synapse)
- GCP账户 (GCS, Dataproc)

## 📖 学习流程总结

### Project 1 学习收获 ✅
1. **环境搭建** - 掌握了Docker化Iceberg开发环境 ✅
2. **基础概念** - 理解了Spark引擎 + Iceberg表格式的架构 ✅
3. **实际操作** - 完成了表创建、数据插入、查询分析 ✅
4. **问题解决** - 处理了Python版本冲突、权限配置等实际问题 ✅
5. **特性验证** - 验证了分区、事务、元数据等核心特性 ✅

### 后续项目流程
1. **阅读项目说明** - 理解目标和要求
2. **环境准备** - 搭建必要的开发环境
3. **代码实现** - 按步骤完成项目代码
4. **测试验证** - 运行并验证结果
5. **文档记录** - 更新README和学习笔记
6. **问题总结** - 记录遇到的问题和解决方案

## 🎯 当前学习成果

完成Project 1后，你现在已经能够：

- ✅ 独立搭建Iceberg开发环境
- ✅ 创建和管理基础Iceberg表
- ✅ 使用分区策略优化数据存储
- ✅ 查询和分析Iceberg表元数据
- ✅ 理解Spark与Iceberg的集成机制
- ✅ 排查和解决常见环境问题

## 🚀 下一步建议

基于Project 1的成功完成，建议按以下顺序继续：

1. **Project 2 - Schema Evolution**: 基于现有表实验添加列、修改类型
2. **Project 3 - Time Travel**: 利用现有快照演示时间旅行查询
3. **Project 4 - Cloud Integration**: 将环境迁移到云平台
4. **Project 5 - Production Pipeline**: 构建完整的生产数据流

---

**查看已完成项目**: [01-first-iceberg-table - 创建第一个Iceberg表](01-first-iceberg-table/README.md) ✅

**开始下一个项目**: Schema Evolution实验 (即将开始)