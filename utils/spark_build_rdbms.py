from pyspark.sql import SparkSession
from pyspark.context import SparkContext
from pyspark import SparkConf
from pyspark.sql.functions import (udf,col,when,asc,desc,lit,coalesce,mean,sum,avg,rand,stddev,count,countDistinct,format_number,isnan,asc,desc,mean,rank,lag,lead,
)
from pyspark.sql.window import Window

from pyspark.sql.types import (StructField,StructType,LongType,TimestampType,StringType,IntegerType,FloatType,BooleanType,DateType,
)

import pyspark, datetime, os
import numpy as np, pandas as pd, matplotlib.pyplot as plt

from sparking import *
from sparking import employees_df, bonus_df

###############################################################################
my_conf = (
    SparkConf()
    .setAppName("My_Spark_App")
    .set("spark.sql.shuffle.partitions", "2")
    .set("spark.driver.memory", "4g")
    .set("spark.executor.memory", "2g")
    .set("spark.sql.autoBroadcastJoinThreshold", 10_000_000)
    .set("spar.sql.adaptive.enabled", False)
)

spark = (SparkSession.builder.appName("Build-MySQL-DB").config(conf=my_conf).getOrCreate())

sc = spark.sparkContext
spark.sparkContext.setLogLevel("ERROR")
###############################################################################

# JDBC URL format: jdbc:mysql://<host>:<port>/<db-name>
# jdbc_url = "jdbc:mysql://localhost:3306/interview_questions"
jdbc_url = "jdbc:mysql://localhost:3306"
mysql_driver = f"{os.environ['SPARK_HOME']}/jars/mysql-connector-j-8.0.32.jar"

# Connection properties
connection_properties = {
    "user": os.environ["MYSQL_USERNAME"],
    "password": os.environ["MYSQL_PASSWORD"],
    "driver": "com.mysql.cj.jdbc.Driver",
}
###############################################################################

# SQL statement with additional constraints
create_emp_sql = """CREATE TABLE employee (
	EMPLOYEE_ID INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	FIRST_NAME CHAR(25),
	LAST_NAME CHAR(25),
	DEPARTMENT CHAR(25),
	SALARY INT(15),
	JOINING_DATE CHAR(25),
	EMAIL CHAR(100),
    DOB TIMESTAMP,
);
"""

# SQL statement with additional constraints
create_bns_sql = """CREATE TABLE Bonus IF NOT EXISTS (
	EMPLOYEE_REF_ID INT,
	BONUS_AMOUNT INT(10),
	BONUS_DATE DATETIME,
	FOREIGN KEY (EMPLOYEE_REF_ID) REFERENCES Employee(EMPLOYEE_ID) ON DELETE CASCADE
);
"""

# JDBC options with the preactions to create the table with constraints
jdbc_options = {
    "url": jdbc_url + "/IQ",
    "dbtable": "Employee",
    "user": connection_properties["user"],
    "password": connection_properties["password"],
    "driver": connection_properties["driver"],
}

emp_pddf = employees_df(30)

emp_df = spark.createDataFrame(emp_pddf)
jdbc_options["preactions"] = create_emp_sql
###############################################################################
###############################################################################

## Write OPTION 2
# To append into an existing table, data must be validated in accordance with table constraints.
emp_df.write.format("jdbc").options(**jdbc_options).mode("overwrite").save()