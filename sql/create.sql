-- Create the "default" schema if it doesn't exist
CREATE SCHEMA IF NOT EXISTS "default";

-- Create the "users" table if it doesn't exist within the "default" schema
DROP TABLE IF EXISTS "default".users;
CREATE TABLE "default".users (
    user_id SERIAL PRIMARY KEY,
    username VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    date_of_birth DATE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
