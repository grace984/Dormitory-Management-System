
-- GROUP 4 FINAL PROJ

-- SECTION 1: DATABASE

DROP DATABASE IF EXISTS dormitory_management;
CREATE DATABASE dormitory_management;
USE dormitory_management;

-- SECTION 2: TABLES

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

-- SECTION 3: INSERT

INSERT INTO Tenant (first_name, last_name, gender, contact_number, email, status)
VALUES
('Juan', 'Dela Cruz', 'Male', '09171234567', 'juan@gmail.com', 'Active'),
('Maria', 'Santos', 'Female', '09181234567', 'maria@gmail.com', 'Active'),
('Jose', 'Reyes', 'Male', '09192345678', 'jose@gmail.com', 'Active'),
('Ana', 'Cruz', 'Female', '09201234567', 'ana@gmail.com', 'Inactive'),
('Paolo', 'Garcia', 'Male', '09211234567', 'paolo@gmail.com', 'Active');

INSERT INTO Room (room_number, capacity, room_type, status)
VALUES
('R101', 4, 'Shared', 'Available'),
('R102', 2, 'Shared', 'Occupied'),
('R201', 1, 'Solo', 'Available'),
('R202', 4, 'Shared', 'Occupied');

INSERT INTO Admin (admin_name, role, contact_number)
VALUES
('Maria Santos', 'Manager', '09181234567'),
('Carlo Reyes', 'Staff', '09192345678');

INSERT INTO Room_Assignment (tenant_id, room_id, admin_id, assigned_date, check_out_date)
VALUES
(1, 1, 1, '2026-06-20', NULL),
(2, 2, 1, '2026-06-18', NULL),
(3, 2, 2, '2026-06-17', NULL),
(4, 3, 1, '2026-06-10', '2026-06-25'),
(5, 4, 2, '2026-06-15', NULL);

-- SECTION 4: UPDATE / DELETE

UPDATE Tenant
SET status = 'Inactive'
WHERE tenant_id = 3;

DELETE FROM Room_Assignment
WHERE assignment_id = 4;


-- SECTION 5: SELECT / JOIN / AGGREGATE

SELECT * FROM Tenant;
SELECT * FROM Room;

SELECT * 
FROM Tenant
WHERE status = 'Active';

SELECT *
FROM Room
WHERE status = 'Available';

SELECT 
    t.first_name,
    t.last_name,
    r.room_number
FROM Room_Assignment ra
JOIN Tenant t ON ra.tenant_id = t.tenant_id
JOIN Room r ON ra.room_id = r.room_id;

SELECT 
    t.first_name,
    t.last_name,
    r.room_number,
    a.admin_name,
    ra.assigned_date,
    ra.check_out_date
FROM Room_Assignment ra
JOIN Tenant t ON ra.tenant_id = t.tenant_id
JOIN Room r ON ra.room_id = r.room_id
JOIN Admin a ON ra.admin_id = a.admin_id;

SELECT COUNT(*) AS total_tenants
FROM Tenant;

SELECT COUNT(*) AS total_rooms
FROM Room;

SELECT 
    r.room_number,
    COUNT(*) AS tenant_count
FROM Room_Assignment ra
JOIN Room r ON ra.room_id = r.room_id
GROUP BY r.room_number;


-- SECTION 6: VIEW
CREATE OR REPLACE VIEW tenant_room_summary AS
SELECT 
    t.tenant_id,
    t.first_name,
    t.last_name,
    r.room_number,
    a.admin_name,
    ra.assigned_date,
    ra.check_out_date
FROM Room_Assignment ra
JOIN Tenant t ON ra.tenant_id = t.tenant_id
JOIN Room r ON ra.room_id = r.room_id
JOIN Admin a ON ra.admin_id = a.admin_id;


-- SECTION 7: STORED PROCEDURE

DROP PROCEDURE IF EXISTS AddTenant;
DELIMITER //

CREATE PROCEDURE AddTenant(
    IN p_first_name VARCHAR(50),
    IN p_last_name VARCHAR(50),
    IN p_gender VARCHAR(10),
    IN p_contact_number VARCHAR(20),
    IN p_email VARCHAR(100)
)
BEGIN
    INSERT INTO Tenant (
        first_name,
        last_name,
        gender,
        contact_number,
        email
    )
    VALUES (
        p_first_name,
        p_last_name,
        p_gender,
        p_contact_number,
        p_email
    );
END //

DELIMITER ;


-- SECTION 8: TRIGGER

DROP TRIGGER IF EXISTS update_room_status;
DELIMITER //

CREATE TRIGGER update_room_status
AFTER INSERT ON Room_Assignment
FOR EACH ROW
BEGIN
    UPDATE Room
    SET status = 'Occupied'
    WHERE room_id = NEW.room_id;
END //

DELIMITER ;


