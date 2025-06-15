# Understanding Spark vs Iceberg: What Are We Actually Using?

## 🤔 The Common Question

When you see commands like `spark.sql("CREATE TABLE ... USING ICEBERG")`, you might wonder:

> **"Are we using Spark or Iceberg? It looks like everything is done by Spark!"**

This is an excellent question that many beginners ask. Let's clarify this step by step.

## 🎯 The Simple Answer

**We are using BOTH:**
- **Spark** = The compute engine (like a chef)
- **Iceberg** = The table format (like an advanced recipe)

## 🔧 Detailed Explanation

### Spark's Role: The Compute Engine

Spark is the **execution engine** that:
- Parses your SQL commands
- Executes data processing operations
- Handles distributed computing
- Manages memory and CPU resources

Think of Spark as a **skilled chef** who can cook anything you ask.

### Iceberg's Role: The Table Format

Iceberg is the **data organization format** that:
- Defines how data files are structured
- Manages metadata and versioning
- Provides ACID transactions
- Enables time travel and schema evolution

Think of Iceberg as a **sophisticated recipe book** that tells the chef how to organize ingredients and cooking processes.

## 🔍 Proof: How to Tell You're Using Iceberg

### 1. The Magic Keyword: `USING ICEBERG`

```sql
CREATE TABLE local.demo.user_events (
    user_id bigint,
    event_type string,
    event_time timestamp
) USING ICEBERG  -- ⭐ This is the key!
```

Without this keyword, you'd create a regular Spark table:
```sql
CREATE TABLE regular_table (...) USING PARQUET  -- Regular Spark table
```

### 2. Unique Directory Structure

**Iceberg Table Structure:**
```
warehouse/demo/user_events/
├── data/                          # Data files
│   ├── event_time_day=2024-01-15/
│   └── event_time_day=2024-01-16/
└── metadata/                      # ⭐ Iceberg-specific!
    ├── v4.metadata.json           # Table metadata
    ├── v3.metadata.json           # Previous version
    ├── manifest files (.avro)     # File tracking
    └── snapshot files             # Version snapshots
```

**Regular Spark Table Structure:**
```
regular_table/
├── partition1/
│   └── data.parquet
└── partition2/
    └── data.parquet
# ❌ No metadata directory!
```

### 3. Iceberg-Specific Metadata Files

Let's examine a real Iceberg metadata file:

```bash
cat warehouse/demo/user_events/metadata/v4.metadata.json | head -20
```

Output:
```json
{
  "format-version" : 2,           // Iceberg format version
  "table-uuid" : "0c1b76d8...",  // Unique table identifier
  "location" : "/opt/warehouse/demo/user_events",
  "last-sequence-number" : 2,
  "schemas" : [ ... ],            // Schema evolution history
  "snapshots" : [ ... ]          // Time travel snapshots
}
```

This JSON file is **pure Iceberg** - regular Spark tables don't have this!

### 4. Iceberg-Only Queries

These queries ONLY work with Iceberg tables:

```sql
-- Time travel: View table snapshots
SELECT * FROM local.demo.user_events.snapshots;

-- Metadata queries: View files
SELECT * FROM local.demo.user_events.files;

-- History tracking
SELECT * FROM local.demo.user_events.history;
```

Try these with a regular Spark table - they'll fail!

## 🆚 Side-by-Side Comparison

| Feature | Regular Spark Table | Iceberg Table |
|---------|-------------------|---------------|
| **Creation** | `USING PARQUET` | `USING ICEBERG` |
| **Metadata** | Basic partitioning | Rich metadata with versioning |
| **ACID** | ❌ No transactions | ✅ Full ACID compliance |
| **Time Travel** | ❌ Not supported | ✅ Query any version |
| **Schema Evolution** | ❌ Limited | ✅ Safe schema changes |
| **File Organization** | Simple partitions | Advanced file tracking |
| **Metadata Queries** | ❌ Not available | ✅ `.snapshots`, `.files`, etc. |

## 🎪 Perfect Analogy

### Cooking Scenario

**Scenario 1: Regular Spark Table**
- **Chef (Spark)**: "I'll cook whatever you want"
- **Recipe (Parquet)**: "Just throw ingredients in a pot"
- **Result**: Basic meal, no quality control

**Scenario 2: Iceberg Table**
- **Chef (Spark)**: "I'll cook whatever you want"
- **Recipe (Iceberg)**: "Follow these precise steps for ingredient prep, cooking order, temperature control, and presentation"
- **Result**: Gourmet meal with full provenance tracking

The same chef, different recipes, completely different outcomes!

## 🚀 Practical Demonstration

### Test 1: Create an Iceberg Table

```sql
spark.sql("""
  CREATE TABLE local.demo.iceberg_test (
    id bigint,
    name string
  ) USING ICEBERG
""")
```

### Test 2: Create a Regular Spark Table

```sql
spark.sql("""
  CREATE TABLE local.demo.regular_test (
    id bigint,
    name string
  ) USING PARQUET
""")
```

### Test 3: Compare the Results

```bash
# Iceberg table structure
find warehouse/demo/iceberg_test -type f

# Regular table structure
find warehouse/demo/regular_test -type f
```

**Iceberg will have:**
- `metadata/` directory with JSON and AVRO files
- Version tracking files
- Advanced organization

**Regular table will have:**
- Just data files
- No metadata directory
- Basic structure

## 🎯 Key Takeaways

1. **You ARE using Iceberg** - The `USING ICEBERG` keyword makes it an Iceberg table
2. **Spark is the engine** - It executes your commands but stores data in Iceberg format
3. **The magic is in the format** - Iceberg provides advanced features that regular Spark tables cannot
4. **File structure proves it** - The `metadata/` directory is the smoking gun
5. **Special queries work** - `.snapshots`, `.files` queries only work with Iceberg

## 💡 Why This Matters

Understanding this distinction helps you:
- Appreciate Iceberg's advanced capabilities
- Debug issues more effectively
- Make informed decisions about table formats
- Leverage Iceberg-specific features confidently

## 🔗 Next Steps

Now that you understand the relationship:
1. Explore time travel queries
2. Test schema evolution
3. Compare performance with regular tables
4. Learn about table maintenance operations

---

**Remember**: When you use Spark with Iceberg, you get the best of both worlds - Spark's powerful compute engine with Iceberg's advanced table management!