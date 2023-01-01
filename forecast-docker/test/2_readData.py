
import findspark
findspark.init()

from pyspark.sql import SparkSession

spark = (SparkSession
         .builder
         .appName("pyspark-rf-benchmark")
         .master("spark://10.50.0.164:7077")
#         .master("spark://ecs-python2:7077")
         .config('spark.executor.memory', '16G')
#         .config('spark.executor.memory', '512M')
         .config('spark.driver.memory', '16G')
         .config('spark.driver.maxResultSize', '16G')
#            .config("spark.driver.extraClassPath","/tmp/lib/cudf-22.06.0-cuda11.jar:/tmp/lib/rapids-4-spark_2.12-22.06.0.jar:/tmp/lib/rapids-4-spark-ml_2.12-22.08.0-SNAPSHOT.jar") 
#            .config("spark.executor.extraClassPath","/tmp/lib/cudf-22.06.0-cuda11.jar:/tmp/lib/rapids-4-spark_2.12-22.06.0.jar:/tmp/lib/rapids-4-spark-ml_2.12-22.08.0-SNAPSHOT.jar")         
#            .config('spark.plugins','com.nvidia.spark.SQLPlugin')
         .config("spark.driver.extraClassPath","/home/forecast/lib/spark/cudf-22.06.0-cuda11.jar:/home/forecast/lib/spark/rapids-4-spark_2.12-22.06.0.jar:/home/forecast/lib/spark/rapids-4-spark-ml_2.12-22.08.0-SNAPSHOT.jar") 
         .config("spark.executor.extraClassPath","/home/forecast/lib/spark/cudf-22.06.0-cuda11.jar:/home/forecast/lib/spark/rapids-4-spark_2.12-22.06.0.jar:/home/forecast/lib/spark/rapids-4-spark-ml_2.12-22.08.0-SNAPSHOT.jar")                  
         .config('spark.plugins','com.nvidia.spark.SQLPlugin')
         .getOrCreate())

spark.conf.set('spark.rapids.sql.enabled','true')

print(spark)


import functools
from pyspark.sql.types import *
import pyspark.sql.functions as F
from pyspark.sql import DataFrame


# manually specify schema because inferSchema in read.csv is quite slow
schema = StructType([
    StructField('VendorID', DoubleType()),
    StructField('tpep_pickup_datetime', TimestampType()),
    StructField('tpep_dropoff_datetime', TimestampType()),
    StructField('passenger_count', DoubleType()),
    StructField('trip_distance', DoubleType()),
    StructField('RateCodeID', DoubleType()),
    StructField('store_and_fwd_flag', StringType()),
    #StructField('PULocationID', DoubleType()),
    #StructField('DOLocationID', DoubleType()),
    StructField('pickup_longitude', DoubleType()),
    StructField('pickup_latitude', DoubleType()), 
    StructField('dropoff_longitude', DoubleType()), 
    StructField('dropoff_latitude', DoubleType()),
    StructField('payment_type', DoubleType()),
    StructField('fare_amount', DoubleType()),
    StructField('extra', DoubleType()),
    StructField('mta_tax', DoubleType()),
    StructField('tip_amount', DoubleType()),
    StructField('tolls_amount', DoubleType()),
    StructField('improvement_surcharge', DoubleType()),
    StructField('total_amount', DoubleType()),
    StructField('congestion_surcharge', DoubleType()),
])

path = "/home/forecast/dataset/nyc-taxi/yellow_tripdata_2015.parquet"
df = spark.read.parquet(path)

taxi=df
print(f"{taxi.count(): }")


spark.stop()


