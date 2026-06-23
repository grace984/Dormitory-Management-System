--this is for submission, 
--compilation of all files
-- do not touch me until submission
-- sorry for touching - cyp
CREATE DATABASE dormitory_management;
USE dormitory_management;
CREATE TABLE Tenant (
    tenant_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    gender VARCHAR(10) NOT NULL,
    contact_number VARCHAR(20) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    status VARCHAR(20) DEFAULT 'Active'
);


CREATE TABLE Room (
    room_id INT AUTO_INCREMENT PRIMARY KEY,
    room_number VARCHAR(10) UNIQUE NOT NULL,
    capacity INT NOT NULL,
    room_type VARCHAR(20) NOT NULL,
    status VARCHAR(20) DEFAULT 'Available',
    CHECK (capacity > 0)
);

CREATE TABLE Admin (
    admin_id INT AUTO_INCREMENT PRIMARY KEY,
    admin_name VARCHAR(100) NOT NULL,
    role VARCHAR(50) NOT NULL,
    contact_number VARCHAR(20) NOT NULL
);

CREATE TABLE Room_Assignment (
    assignment_id INT AUTO_INCREMENT PRIMARY KEY,
    tenant_id INT NOT NULL,
    room_id INT NOT NULL,
    admin_id INT NOT NULL,
    assigned_date DATE NOT NULL,
    check_out_date DATE,

    FOREIGN KEY (tenant_id) REFERENCES Tenant(tenant_id),
    FOREIGN KEY (room_id) REFERENCES Room(room_id),
    FOREIGN KEY (admin_id) REFERENCES Admin(admin_id)
);
