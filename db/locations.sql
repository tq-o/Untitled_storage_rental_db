-- Location's schema definition
DROP TABLE IF EXISTS addresses;

CREATE TABLE addresses (
    id CHAR(36) PRIMARY KEY,
    name VARCHAR(255),
    street VARCHAR(255),
    unit VARCHAR(50),
    city VARCHAR(100),
    state VARCHAR(50),
    postal_code VARCHAR(20),
    country VARCHAR(100)
);