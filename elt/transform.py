import psycopg2
from config.db_utils import config


def create_marts(ddl_scripts):
    """
    Create data marts (tables, views or MVs) in the database
    """

    connection = None

    try:
        print("Creating data marts...")

        # Read connection parameters
        db_conn_params = config()

        # Connect to the PostgreSQL server
        connection = psycopg2.connect(**db_conn_params)

        # Create marts
        with connection.cursor() as cursor_ddl:
            for script in ddl_scripts:
                cursor_ddl.execute(open(script, 'r').read())
                connection.commit()

        print("Done.")

    except (Exception, psycopg2.DatabaseError) as error:
        print(error)

    finally:
        if connection is not None:
            connection.close()
