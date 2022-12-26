from sqlalchemy import create_engine
from config.db_utils import config


def connect():
    """
    Connect to the PostgreSQL database
    Returns a SQLAlchemy connection passed to config()
    """

    try:
        print("Connecting to the database...")

        # Read connection parameters
        db_params = config()

        conn_string = \
            f"postgresql://{db_params['user']}@{db_params['host']}:{db_params['port']}" \
            f"/{db_params['database']}"

        # Connect to the PostgreSQL server
        engine = create_engine(conn_string)

        connection = engine.connect()

        print(f"Successfully connected to {db_params['database']}.")

        return connection

    except:
        print("Connection failed.")


if __name__ == '__main__':
    connection = connect()
    result = connection.execute("select version();")
    for row in result:
        print(row)
    connection.close()
