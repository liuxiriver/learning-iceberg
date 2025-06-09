# Schema Evolution - 无痛schema变更

**提问时间**: 2024-01-01
**学习阶段**: 第一阶段 - 核心概念掌握
**难度级别**: 初级

## 🤔 问题

Schema Evolution是什么？它解决了什么问题？有哪些实际应用场景？

## 💡 答案

### Schema Evolution的含义

**Schema Evolution** 是指数据表的结构（schema）可以随时间安全地演变和更新，而不会破坏现有数据或影响正在运行的应用程序。

### 传统方案的痛点

#### 1. **传统数据仓库的问题**
```sql
-- 传统数据库添加列
ALTER TABLE users ADD COLUMN email VARCHAR(255);
-- 问题：需要锁表，影响生产系统
-- 历史数据的新列值为NULL，可能破坏业务逻辑
```

#### 2. **Hive表的问题**
```sql
-- Hive添加列
ALTER TABLE users ADD COLUMNS (email string, phone string);
-- 问题：
-- 1. 可能需要重新分区
-- 2. 旧数据文件缺少新列信息
-- 3. 查询时可能出现类型不匹配
```

#### 3. **数据湖文件的问题**
```
问题场景：
day1/users.parquet  → columns: [id, name, age]
day2/users.parquet  → columns: [id, name, age, email]  // 添加了email

查询挑战：
- 如何统一处理不同schema的文件？
- 如何保证数据类型一致性？
- 如何处理列的重命名和删除？
```

### Iceberg Schema Evolution的解决方案

#### 1. **列级别的操作支持**

**添加列 (Add Column)**
```sql
-- 安全添加新列
ALTER TABLE users ADD COLUMN email string;
ALTER TABLE users ADD COLUMN phone string AFTER name;

-- 特点：
-- ✅ 不需要重写历史数据
-- ✅ 旧文件读取时自动填充null
-- ✅ 新文件包含新列数据
```

**删除列 (Drop Column)**
```sql
-- 安全删除列
ALTER TABLE users DROP COLUMN phone;

-- 特点：
-- ✅ 历史数据保持不变
-- ✅ 查询时自动忽略已删除的列
-- ✅ 可以恢复已删除的列（如果数据还在）
```

**重命名列 (Rename Column)**
```sql
-- 重命名列
ALTER TABLE users RENAME COLUMN user_name TO full_name;

-- 特点：
-- ✅ 保持向后兼容性
-- ✅ 旧查询仍然有效
-- ✅ 新查询使用新名称
```

**修改列类型 (Type Promotion)**
```sql
-- 安全的类型提升
ALTER TABLE users ALTER COLUMN age TYPE bigint;  -- int → bigint
ALTER TABLE users ALTER COLUMN score TYPE double; -- float → double

-- 支持的类型提升：
-- int → bigint
-- float → double
-- decimal(P,S) → decimal(P',S) where P' > P
```

#### 2. **Schema版本管理**

Iceberg维护完整的schema历史：

```json
// Schema历史示例
{
  "schema-id": 1,
  "fields": [
    {"id": 1, "name": "id", "type": "long", "required": true},
    {"id": 2, "name": "name", "type": "string", "required": false}
  ]
}

{
  "schema-id": 2,
  "fields": [
    {"id": 1, "name": "id", "type": "long", "required": true},
    {"id": 2, "name": "name", "type": "string", "required": false},
    {"id": 3, "name": "email", "type": "string", "required": false}
  ]
}
```

#### 3. **数据兼容性保证**

**读取兼容性**
```
文件A (Schema v1): [id: 1, name: "Alice"]
文件B (Schema v2): [id: 2, name: "Bob", email: "bob@example.com"]

查询: SELECT id, name, email FROM users

结果:
1, "Alice", null      // 来自文件A，email自动补null
2, "Bob", "bob@..."   // 来自文件B，正常读取
```

**写入兼容性**
```
新数据总是使用最新schema写入
旧数据保持原有schema不变
查询引擎自动处理schema差异
```

### 实际应用场景

#### 1. **用户行为分析表演进**

**初始版本**
```sql
CREATE TABLE user_events (
    user_id bigint,
    event_type string,
    timestamp timestamp
) USING ICEBERG;
```

**业务发展 - 添加设备信息**
```sql
ALTER TABLE user_events ADD COLUMN device_type string;
ALTER TABLE user_events ADD COLUMN ip_address string;
```

**功能扩展 - 添加地理位置**
```sql
ALTER TABLE user_events ADD COLUMN country string;
ALTER TABLE user_events ADD COLUMN city string;
ALTER TABLE user_events ADD COLUMN coordinates struct<lat:double,lng:double>;
```

**隐私合规 - 删除敏感信息**
```sql
ALTER TABLE user_events DROP COLUMN ip_address;
```

#### 2. **订单系统表演进**

**电商平台演进示例**
```sql
-- 初始订单表
CREATE TABLE orders (
    order_id bigint,
    user_id bigint,
    amount decimal(10,2),
    status string
) USING ICEBERG;

-- 添加支付方式
ALTER TABLE orders ADD COLUMN payment_method string;

-- 支持多币种
ALTER TABLE orders ADD COLUMN currency string DEFAULT 'USD';

-- 添加优惠券信息
ALTER TABLE orders ADD COLUMN coupon_code string;
ALTER TABLE orders ADD COLUMN discount_amount decimal(10,2);

-- 重命名以提高语义清晰度
ALTER TABLE orders RENAME COLUMN amount TO total_amount;
```

#### 3. **IoT数据表演进**

**传感器数据演进**
```sql
-- 初始传感器表
CREATE TABLE sensor_data (
    sensor_id string,
    timestamp timestamp,
    temperature double
) USING ICEBERG;

-- 添加新传感器类型
ALTER TABLE sensor_data ADD COLUMN humidity double;
ALTER TABLE sensor_data ADD COLUMN pressure double;

-- 添加设备元数据
ALTER TABLE sensor_data ADD COLUMN device_model string;
ALTER TABLE sensor_data ADD COLUMN firmware_version string;

-- 支持复杂数据类型
ALTER TABLE sensor_data ADD COLUMN readings map<string,double>;
```

### Schema Evolution的最佳实践

#### 1. **安全的操作**
- ✅ 添加可选列（nullable）
- ✅ 删除不重要的列
- ✅ 重命名列（保持语义）
- ✅ 类型提升（int→bigint）

#### 2. **需要谨慎的操作**
- ⚠️ 删除必需的列
- ⚠️ 修改列的语义
- ⚠️ 类型降级（可能丢失精度）

#### 3. **不推荐的操作**
- ❌ 频繁的schema变更
- ❌ 破坏性的类型转换
- ❌ 删除业务关键列

### 与其他系统的对比

| 特性 | Iceberg | Delta Lake | Hudi | 传统Hive |
|------|---------|------------|------|----------|
| **添加列** | ✅ 无需重写 | ✅ 无需重写 | ✅ 无需重写 | ❌ 需要重新处理 |
| **删除列** | ✅ 逻辑删除 | ✅ 逻辑删除 | ✅ 逻辑删除 | ❌ 破坏性操作 |
| **重命名列** | ✅ 完全支持 | ✅ 完全支持 | ❌ 不支持 | ❌ 不支持 |
| **类型演进** | ✅ 安全提升 | ✅ 安全提升 | ✅ 有限支持 | ❌ 不支持 |
| **向后兼容** | ✅ 完全兼容 | ✅ 完全兼容 | ✅ 部分兼容 | ❌ 经常破坏 |

## 🔗 相关资源

- [Iceberg Schema Evolution文档](https://iceberg.apache.org/docs/latest/evolution/)
- [Schema Evolution最佳实践](https://iceberg.apache.org/docs/latest/evolution/#best-practices)
- [Spark DDL操作指南](../../docs/docs/spark-ddl.md)

## 🏷️ 标签

#概念理解 #schema演进 #数据兼容性 #最佳实践