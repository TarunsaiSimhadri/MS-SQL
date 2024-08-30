import pandas as pd
import pyodbc

import os
from dotenv import load_dotenv

load_dotenv()
SERVER = os.getenv("SERVER_NAME")
DATABASE = os.getenv("DATABASE_NAME")
# print(SERVER)
# print(DATABASE)

# Import CSV
df = pd.read_csv("exported_data.csv")

# Connect to SQL Server
conn_str = f'DRIVER={{SQL Server}};SERVER={SERVER};DATABASE={DATABASE};Tested_Connection=yes;'
conn = pyodbc.connect(conn_str)
cursor = conn.cursor()

cursor.execute(
    """
    CREATE TABLE products (
    EID int primary key,
    ENAME nvarchar(50),
    SAL int
    )
    """
)


# for row in df.iterrows():
#     print(row)

query = 'INSERT INTO products (EID, ENAME, SAL) VALUES(?,?,?)'
for row in df.itertuples():
    cursor.execute(
        query,
        row.EID,
        row.ENAME,
        row.SAL,
    )
conn.commit()
conn.close()