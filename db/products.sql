-- Storage Rental Service Database Schema
-- Storage Rental Platform (like Airbnb for storage)

-- Drop tables in correct order (child tables first due to foreign keys)
DROP TABLE IF EXISTS rentals;
DROP TABLE IF EXISTS storage_units;

-- Storage Units Table
CREATE TABLE storage_units (
    id CHAR(36) PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    size ENUM('small', 'medium', 'large', 'extra_large') NOT NULL,
    unit_type ENUM('indoor', 'outdoor', 'climate_controlled', 'vehicle', 'warehouse') NOT NULL,
    dimensions VARCHAR(50),
    location_id CHAR(36) NOT NULL COMMENT 'Reference to addresses.id in location service',
    owner_user_id INT NOT NULL COMMENT 'Reference to users.user_id in users service',
    price_amount DECIMAL(10, 2) NOT NULL,
    price_currency VARCHAR(3) DEFAULT 'USD',
    available BOOLEAN DEFAULT TRUE,
    features JSON COMMENT 'Array of features like ["24/7 access", "security cameras", "climate controlled"]',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_owner_user_id (owner_user_id),
    INDEX idx_location_id (location_id),
    INDEX idx_size (size),
    INDEX idx_unit_type (unit_type),
    INDEX idx_available (available),
    INDEX idx_price_amount (price_amount),
    CHECK (price_amount >= 0)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Rentals Table (Bookings)
CREATE TABLE rentals (
    id CHAR(36) PRIMARY KEY,
    storage_unit_id CHAR(36) NOT NULL,
    renter_user_id INT NOT NULL COMMENT 'Reference to users.user_id (person renting)',
    owner_user_id INT NOT NULL COMMENT 'Reference to users.user_id (denormalized for queries)',
    start_date DATETIME NOT NULL,
    end_date DATETIME COMMENT 'NULL for ongoing rentals',
    monthly_rate_amount DECIMAL(10, 2) NOT NULL,
    monthly_rate_currency VARCHAR(3) DEFAULT 'USD',
    total_paid_amount DECIMAL(10, 2) DEFAULT 0.00,
    total_paid_currency VARCHAR(3) DEFAULT 'USD',
    status ENUM('pending', 'confirmed', 'active', 'completed', 'cancelled') DEFAULT 'pending',
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (storage_unit_id) REFERENCES storage_units(id) ON DELETE RESTRICT,
    INDEX idx_storage_unit_id (storage_unit_id),
    INDEX idx_renter_user_id (renter_user_id),
    INDEX idx_owner_user_id (owner_user_id),
    INDEX idx_status (status),
    INDEX idx_start_date (start_date),
    INDEX idx_end_date (end_date),
    CHECK (monthly_rate_amount >= 0),
    CHECK (total_paid_amount >= 0),
    CHECK (end_date IS NULL OR end_date >= start_date)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
