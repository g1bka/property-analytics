import psycopg2
from config.db_utils import config


def create_schema(schema_name):
    """
    Create a schema in the PostgreSQL database
    """

    ddl_script = f'elt/ddl/schema__{schema_name}.sql'

    try:
        print(f"Creating schema `{schema_name}`...")

        # Read connection parameters
        db_conn_params = config()

        # Connect to the PostgreSQL server
        connection = psycopg2.connect(**db_conn_params)

        # Create schema in the database
        with connection.cursor() as cursor:
            cursor.execute(open(ddl_script, "r").read())

        connection.commit()

        print("Done.")

    except (Exception, psycopg2.DatabaseError) as error:
        print(error)


def create_tables(ddl_scripts):
    """
    Create tables in the PostgreSQL database
    """

    connection = None

    try:
        print("Creating tables...")

        # Read connection parameters
        db_conn_params = config()

        # Connect to the PostgreSQL server
        connection = psycopg2.connect(**db_conn_params)

        cursor = connection.cursor()

        # Create tables one by one
        for script in ddl_scripts:
            cursor.execute(open(script, 'r').read())

        # Close communication with the database server
        cursor.close()
        connection.commit()

        print("Done.")

    except (Exception, psycopg2.DatabaseError) as error:
        print(error)

    finally:
        if connection is not None:
            connection.close()
