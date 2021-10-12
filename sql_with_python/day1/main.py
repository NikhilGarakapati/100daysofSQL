from logging import root
import os
import pandas as pd
import mysql.connector
from query import Query

class findDifferenceBetweenSalaries:

    def __init__(self):

        self.mydb = mysql.connector.connect(
            host="xxxxxxxxxx",
            user="xxxxx",
            password="xxxxx",
            port="xxxx",
            database="xxxxx"
        )

    def execute(self):
        employee_df = pd.read_sql(Query.EMPLOYEE_TABLE, self.mydb)
        departments_df = pd.read_sql(Query.DEPARTMENTS_TABLE, self.mydb)

        departments_df = departments_df.rename(columns={"id": "department_id"})

        df = pd.merge(employee_df, departments_df, on='department_id', how='inner')

        df = df['salary'].where(df['department'].str.contains('marketing|engineering')).groupby(df['department']).max()
        
        df = df.dropna()

        df.loc['salary_difference'] = df.loc['marketing'] - df.loc['engineering']

        print(df.loc['salary_difference'])

if __name__ == "__main__":

    p = findDifferenceBetweenSalaries()
    p.execute()
