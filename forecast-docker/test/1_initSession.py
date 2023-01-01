
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

spark.stop()


