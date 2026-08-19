
# Generate fake data

import pandas as pd
from faker import Faker
import random

fkr = Faker()

departments = ['HR', 'Finance', 'Marketing', 'Sales', 'IT', '', 'na', None]



# Function to randomly introduce None or empty values
def random_val(value):
    flt = random.random()
    if 0<=flt<= 0.1: return None  # Insert None (null in PySpark)
    elif 0.1<= flt <= 0.2: return ""
    elif 0.2<= flt <= 0.3: return "na"
    else: return value

import datetime
import random



employees = {
    "employee_id": [x for x in range(1, 30 + 1)],
    "first_name": [
        random_val(fkr.first_name()) for _ in range(30)
    ],  # Generate first name
    "last_name": [random_val(fkr.last_name()) for _ in range(30)],  # Generate last name
    "department": [
        fkr.random_element(departments) for _ in range(30)
    ],  # Generate random department
    "salary": [random_val(fkr.random_int(min=40000, max=150000)) for _ in range(30)],
    "joining_date": [
        random_val(fkr.past_date().strftime("%m-%d-%Y")) for _ in range(30)
    ],  # Generate 'datetime.date' object
    "email": [random_val(fkr.email()) for _ in range(30)],
}

# ============================================================================

# print(employees['joining_date'])
# print([item for item in dir(fkr) if 'date' in item])

