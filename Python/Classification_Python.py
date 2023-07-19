


import pandas as pd


file = pd.read_excel("C:/Users/alvar/Desktop/Ironhack/PROJECT_CLASS/Files/creditcardmarketing.xlsx")


# Create a list of column and dtype pairs
column_list = [(column, dtype) for column, dtype in zip(file.columns, file.dtypes)]

# Print the list
for column, dtype in column_list:
    print(column, dtype)

