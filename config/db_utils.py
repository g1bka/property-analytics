from configparser import ConfigParser
import psycopg2


def config(filename='config/database.ini', section='pg_dev'):
    """
    Get database connection parameters
    Returns a dictionary based on the section in database.ini
    File database.ini is not committed to the repo for security reasons
    """

    parser = ConfigParser()
    parser.read(filename)

    # Get section and update dictionary with connection string key:value pairs
    # Each section represents an environment (pg_dev or pg_prod)
    db_conn_params = {}
    if section in parser:
        for key in parser[section]:
            db_conn_params[key] = parser[section][key]
    else:
        raise Exception(
            'Section {0} not found in file {1}'.format(section, filename)
        )

    return db_conn_params


def test_connection(env='pg_dev'):
    """
    Connect to the database server, return version, and close connection
    """

    conn = None

    try:
        # Read connection parameters
        db_conn_params = config(section=env)

        # Connect to the PostgreSQL server
        print('Connecting to the PostgreSQL database...')
        conn = psycopg2.connect(**db_conn_params)

        cur = conn.cursor()

        print('PostgreSQL database version:')
        cur.execute('SELECT version()')

        # Display the PostgreSQL database server version
        db_version = cur.fetchone()
        print(db_version)

        # Close communication with the database server
        cur.close()

    except (Exception, psycopg2.DatabaseError) as error:
        print(error)

    finally:
        if conn is not None:
            conn.close()
            print('Closing database connection... \nDone.')
