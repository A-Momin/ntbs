from pyspark.sql import SparkSession
from pyspark.sql import DataFrame
import pandas as pd
from pyspark.sql.types import StructType, StructField, StringType, IntegerType


import pandas as pd
from faker import Faker
from random import randint, randrange, sample, choice, choices
import random
from utils import generate_random_datetime

fkr = Faker()

departments = [('HR', 3), ('Finance', 3), ('Marketing', 3), ('Sales', 3), ('IT', 3), ('Accounting', 3)]
salary = [30_000, 40_000, 50_000, 60_000, 70_000, 90_000, 100_000]

# Function to randomly introduce None or empty values
def random_str_val(value, str_only=False, none_only=False):
    flt = random.random()
    if not none_only and 0<=flt<= 0.1: 
        return None  # Insert None (null in PySpark)
    elif not str_only and 0.1<= flt <= 0.2: 
        return ""
    else: 
        return value

def employees_df(num_row: int = 30) -> DataFrame:
    employees = {
        "employee_id": [x for x in range(1, num_row + 1)],
        "first_name": [fkr.first_name() for _ in range(num_row)],  # Generate first name
        "last_name": [fkr.last_name() for _ in range(num_row)],  # Generate last name
        "department": [
            fkr.random_element(departments)[0] for _ in range(num_row)
        ],  # Generate random department
        "salary": [fkr.random_element(salary) for _ in range(num_row)],
        "joining_date": [
            generate_random_datetime(
                "2018-01-01 00:00:00", "2022-01-01 00:00:00"
            ).strftime("%Y-%m-%d")
            for _ in range(num_row)
        ],  # Generate 'datetime.date' object
        "email": [fkr.email() for _ in range(num_row)],
        "dob": [generate_random_datetime() for _ in range(num_row)],
    }

    return pd.DataFrame(employees)

def departments_df(num_row: int = 30) -> DataFrame:
    d = [fkr.random_element(departments) for _ in range(num_row)]

    departments = {
        "department_id": [item[1] for item in d],  # Generate department ID
        "department_name": [item[0] for item in d],  # Generate department name
    }

    return pd.DataFrame(departments)

def bonus_df(num_row: int = 30) -> DataFrame:
    bonus = {
        "employee_ref_id": [randint(1, num_row) for x in range(1, num_row + 1)],
        "bonus_amount": [
            fkr.random_element([3000, 5000, 2000, 1000, None]) for _ in range(num_row)
        ],
        "bonus_date": [
            generate_random_datetime("2022-01-01 00:00:00", "2025-01-01 00:00:00")
            for _ in range(num_row)
        ],  # Generate 'datetime.date' object
    }

    # # Initialize Spark session
    # spark = SparkSession.builder \
    #     .appName("DictToDataFrame") \
    #     .getOrCreate()

    # # # Convert the dictionary to a list of rows (each row is a dictionary itself)
    # # rows = [dict(zip(data.keys(), row)) for row in zip(*data.values())]
    # rows = [row for row in zip(*bonus.values())]
    
    # # Create DataFrame from list of rows
    # df = spark.createDataFrame(rows)

    # for idx, new_name in enumerate(bonus.keys(), 1):
    #     df = df.withColumnRenamed(f"_{idx}", new_name)

    return pd.DataFrame(bonus)


def student_df(num_row: int = 30) -> DataFrame:
    bonus = {
        'student_id': [randint(1, num_row) for x in range(1, num_row+1)],
        'first_name': [random_str_val(fkr.first_name()) for _ in range(num_row)], # Generate first name
        'last_name': [random_str_val(fkr.last_name()) for _ in range(num_row)],   # Generate last name
    }

    # # Initialize Spark session
    # spark = SparkSession.builder \
    #     .appName("DictToDataFrame") \
    #     .getOrCreate()

    # # # Convert the dictionary to a list of rows (each row is a dictionary itself)
    # # rows = [dict(zip(data.keys(), row)) for row in zip(*data.values())]
    # rows = [row for row in zip(*bonus.values())]
    
    # # Create DataFrame from list of rows
    # df = spark.createDataFrame(rows)

    # for idx, new_name in enumerate(bonus.keys(), 1):
    #     df = df.withColumnRenamed(f"_{idx}", new_name)

    return pd.DataFrame(bonus)


def dict_to_spark_df(data: dict) -> DataFrame:
    """
    Convert a dictionary into a PySpark DataFrame.
    
    Parameters:
    data (dict): Dictionary where each key is a column name, and each value is a list of column values.
    
    Returns:
    DataFrame: PySpark DataFrame created from the dictionary.
    """

    # Initialize Spark session
    spark = SparkSession.builder \
        .appName("DictToDataFrame") \
        .getOrCreate()

    # # Convert the dictionary to a list of rows (each row is a dictionary itself)
    # rows = [dict(zip(data.keys(), row)) for row in zip(*data.values())]
    rows = [row for row in zip(*data.values())]
    
    # Create DataFrame from list of rows
    df = spark.createDataFrame(rows)

    for idx, new_name in enumerate(data.keys(), 1):
        df = df.withColumnRenamed(f"_{idx}", new_name)

    return df


df = employees_df(30)
print(df)

