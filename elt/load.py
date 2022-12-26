from db import connect
import pandas as pd


def file_to_table(file_path, schema, table, chunk):
    """
    Load data from a file into a database table
    """

    sql_table_cols = f'SELECT * FROM {schema}.{table} LIMIT 0;'

    connection = connect()

    # Get a list of target table columns for mapping
    columns_list = pd.read_sql(sql_table_cols, connection).columns.tolist()

    print(f"Loading batch to table {schema}.{table}...")

    # Read chunks and insert into the table
    for df in pd.read_csv(file_path, chunksize=chunk):
        df.columns = columns_list
        df.to_sql(
            con=connection,
            schema=schema,
            name=table,
            if_exists='append',  # table already exists, appending data
            index=False
        )

    connection.close()

    print("Done.")
