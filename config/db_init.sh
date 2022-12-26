echo "Initializing the Property Analytics solution..."
echo "Creating database..."
echo "SELECT 'CREATE DATABASE propertydb' WHERE NOT EXISTS (SELECT FROM pg_database WHERE datname = 'propertydb')\gexec" \
| psql postgres
echo "Done."