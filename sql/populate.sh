#!/bin/bash

# Function to generate a random string of characters
function random_string_linux {
  local length=$1
  cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w "$length" | head -n 1
}

function random_string {
  local length=$1
  LC_ALL=C tr -dc 'a-zA-Z0-9' < /dev/urandom | head -c "$length"
}

# PostgreSQL database connection settings
DB_USER="postgres"
DB_PASSWORD="postgres"
DB_NAME="default"
DB_HOST="localhost"

# This isnt going to work if its launched from the current path
cat sql/create.sql | psql "postgresql://${DB_USER}:${DB_PASSWORD}@${DB_HOST}/"

# Initialize a variable to store the SQL INSERT query
sql_insert="INSERT INTO \"default\".users (username, email, password_hash, first_name, last_name, date_of_birth) VALUES"

echo "Preparing bulk insert"
# Generate and insert 1000 random users
for ((i=1; i<=1000; i++)); do
  username="user$i"
  email="user$i@example.com"
  password_hash="hashed_password$i"
  first_name=$(random_string 5)
  last_name=$(random_string 7)
  # date_of_birth=$(date -d "$((RANDOM % 10000)) days ago" +%Y-%m-%d) for linux
  date_of_birth=$(date -v -"$((RANDOM % 10000))d" "+%Y-%m-%d")

  # Append the SQL command for each user to the SQL variable
  sql_insert+=" ('$username', '$email', '$password_hash', '$first_name', '$last_name', '$date_of_birth'),"

  # Show progress
  if ((i % 50 == 0)); then
    echo -ne "Processed $i out of 1000\r"
  fi
done

# Remove the trailing comma from the last INSERT statement
sql_insert="${sql_insert%,}"

# Perform bulk insert using psql
echo "$sql_insert" | psql "postgresql://${DB_USER}:${DB_PASSWORD}@${DB_HOST}/"
echo "Data insertion completed."
