-- Create appointments table for the appointment booking system
CREATE TABLE IF NOT EXISTS appointments (
    appointmentId INT PRIMARY KEY AUTO_INCREMENT,
    customerId INT NOT NULL,
    appointmentDate DATE NOT NULL,
    appointmentTime TIME NOT NULL,
    customerName VARCHAR(100) NOT NULL,
    customerPhone VARCHAR(20) NOT NULL,
    customerEmail VARCHAR(100),
    status VARCHAR(20) DEFAULT 'pending',
    notes TEXT,
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (customerId) REFERENCES customers(id),
    UNIQUE KEY unique_appointment (appointmentDate, appointmentTime)
);

-- Create customers table if it doesn't exist
CREATE TABLE IF NOT EXISTS customers (
    id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) NOT NULL,
    password VARCHAR(255),
    dob DATE,
    address VARCHAR(255),
    phoneNum VARCHAR(20),
    idCustomer VARCHAR(50) UNIQUE,
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insert some sample data for testing (optional)
-- INSERT INTO customers (username, password, dob, address, phoneNum, idCustomer)
-- VALUES ('Test User', 'password123', '1990-01-01', '123 Test Street', '0123456789', 'CUST001');

