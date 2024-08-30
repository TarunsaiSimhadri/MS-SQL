"""

@Author: TarunSai
@Date: 2024-07-29
@Last Modified by: 
@Last Modified time:
@Title : Program to export data from the database.

"""

import pandas as pd
import pyodbc

import os
from dotenv import load_dotenv

load_dotenv()
SERVER = os.getenv("SERVER_NAME")
DATABASE = os.getenv("DATABASE_NAME")
# print(SERVER)
# print(DATABASE)

conn_str = f'DRIVER={{SQL Server}};SERVER={SERVER};DATABASE={DATABASE};Tested_Connection=yes;'

conn = pyodbc.connect(conn_str)

query = 'SELECT * FROM EMP'

data = pd.read_sql_query(query, conn)

df = pd.DataFrame(data)

df.to_csv("exported_data.csv", index = False)
print(df)