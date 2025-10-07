from pyspark.sql import SparkSession

# 1️⃣ Create a SparkSession
spark = SparkSession.builder.appName("MySparkApp").master("local[1]").getOrCreate()

# 2️⃣ (Optional) Check Spark version
print("Spark Version:", spark.version)

# 3️⃣ Create a simple DataFrame
data = [("Alice", 34), ("Bob", 45), ("Cathy", 29)]
columns = ["Name", "Age"]

df = spark.createDataFrame(data, columns)

# 4️⃣ Show DataFrame
df.show()

# 5️⃣ Stop the session
spark.stop()
