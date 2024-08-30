"""

@Author: TarunSai
@Date: 2024-07-29
@Last Modified by: 
@Last Modified time:
@Title : Program to perform CRUD operations using MS-SQL connections in python.

"""

import pyodbc

import os
from dotenv import load_dotenv

load_dotenv()
SERVER = os.getenv("SERVER_NAME")
DATABASE = os.getenv("DATABASE_NAME")
# print(SERVER)
# print(DATABASE)


def check_connection():

    """

    description:
        This function is used to check the connection with database

    parameters:
        None

    return:
        conn (object)

    """
    
    connection_string = f'DRIVER={{SQL Server}};SERVER={SERVER};DATABASE={DATABASE};Trusted_Connection=yes'
    conn = pyodbc.connect(connection_string)
    return conn

def conn_cursor(conn):
    
    """

    description:
        This function is used to create a table in database
    
    parameters:
        connection(which have the database details)
        
    return:
        None

    """
    
    cursor = conn.cursor()
    return cursor

def create_table(conn, cursor):

    """

    description:
        This function is used to create a table in database
    
    parameters:
        connection(which have the database details)
        
    return:
        None

    """

    cursor.execute('CREATE TABLE emp(Eid int PRIMARY KEY, Ename VARCHAR(200))')
    conn.commit()

def insert_details(conn, cursor):

    """

    description:
        This function is used to insert details into the table in the database
    
    parameters:
        connection(which have the database details)
        
    return:
        None

    """
        
    query = 'INSERT INTO emp (Eid, Ename) VALUES (?,?)'
    cursor.execute(query, (100, 'tarun'))
    conn.commit()

def update_detils(conn, cursor):

    """

    description:
        This function is used to update the details of the table
    
    parameters:
        connection(which have the database details)
        
    return:
        None

    """

    query = "UPDATE emp SET Ename = 'varun' WHERE Eid = 100"
    cursor.execute(query)
    conn.commit()

def delete_details(conn, cursor):

    """

    description:
        This function is used to delete the details from the table
    
    parameters:
        connection(which have the database details)
        
    return:
        None

    """

    cursor.execute('DELETE FROM emp WHERE Eid = 200')
    conn.commit()

def alter_add_col(conn, cursor):

    """

    description:
        This function is used to alter the table structure (adding a new column)
    
    parameters:
        connection(which have the database details)
        
    return:
        None

    """
        
    cursor.execute('ALTER TABLE emp ADD email VARCHAR(200)') 
    conn.commit()

def delete_table(conn, cursor):

    """

    description:
        This function is used to delete the entire table from the database
    
    parameters:
        connection(which have the database details)
        
    return:
        None

    """
        
    cursor.execute('DROP TABLE emp')
    conn.commit()


def main():

    connection = check_connection()
    print(connection)
    cursor = conn_cursor(connection)
    create_table(connection, cursor)
    # insert_details(connection, cursor)
    # alter_add_col(connection, cursor)
    # delete_table(connection, cursor)
    # update_detils(connection, cursor)
    # delete_table(connection, cursor)

    if connection:
        connection.close()

if __name__ == '__main__':
    main()