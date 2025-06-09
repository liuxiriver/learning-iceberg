// Iceberg表创建和测试脚本
println("🧊 Testing Iceberg functionality...")

// 创建数据库
spark.sql("CREATE DATABASE IF NOT EXISTS local.demo")

// 创建表
spark.sql("""
  CREATE OR REPLACE TABLE local.demo.user_events (
    user_id bigint,
    event_type string,
    event_time timestamp,
    page_url string,
    user_agent string
  ) USING ICEBERG
  PARTITIONED BY (days(event_time))
""")

// 插入测试数据
import java.sql.Timestamp
val testData = Seq(
  (1001L, "page_view", Timestamp.valueOf("2024-01-15 10:30:00"), "/home", "Mozilla/5.0"),
  (1001L, "click", Timestamp.valueOf("2024-01-15 10:35:00"), "/products", "Mozilla/5.0"),
  (1002L, "page_view", Timestamp.valueOf("2024-01-15 11:00:00"), "/home", "Chrome/98.0"),
  (1002L, "purchase", Timestamp.valueOf("2024-01-15 11:15:00"), "/checkout", "Chrome/98.0"),
  (1003L, "page_view", Timestamp.valueOf("2024-01-16 09:00:00"), "/home", "Safari/15.0")
)

val df = testData.toDF("user_id", "event_type", "event_time", "page_url", "user_agent")
df.writeTo("local.demo.user_events").append()

// 验证数据
println("✅ Table created and data inserted successfully!")
spark.sql("SELECT * FROM local.demo.user_events ORDER BY event_time").show()

// 查看表的快照
println("📸 Table snapshots:")
spark.sql("SELECT snapshot_id, committed_at, operation FROM local.demo.user_events.snapshots").show()

// 查看表的文件
println("📁 Table files:")
spark.sql("SELECT file_path, file_format, record_count FROM local.demo.user_events.files").show(false)

println("🎉 Iceberg test completed successfully!")
