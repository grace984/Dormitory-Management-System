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
