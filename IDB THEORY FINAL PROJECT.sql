CREATE TABLE Patients (
    PatientID INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    DOB DATE,
    Contact VARCHAR(15),
    BloodGroup VARCHAR(5)
);
CREATE TABLE Departments (
    DeptID INT PRIMARY KEY,
    DeptName VARCHAR(100) NOT NULL,
    Floor INT
);
CREATE TABLE Doctors (
    DoctorID INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Specialization VARCHAR(100),
    DeptID INT,
    FOREIGN KEY (DeptID) REFERENCES Departments(DeptID)
);

CREATE TABLE Appointments (
    ApplID INT PRIMARY KEY,
    PatientID INT,
    DoctorID INT,
    Date DATE,
    Time TIME,
    Status VARCHAR(20),
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID),
    FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID)
);

CREATE TABLE Medical_Records (
    RecordID INT PRIMARY KEY,
    PatientID INT,
    DoctorID INT,
    Diagnosis VARCHAR(100),
    Date DATE,
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID),
    FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID)
);
CREATE TABLE Prescriptions (
    PrescID INT PRIMARY KEY,
    RecordID INT,
    MedicineName VARCHAR(100),
    Dosage VARCHAR(50),
    FOREIGN KEY (RecordID) REFERENCES Medical_Records(RecordID)
);

CREATE TABLE Invoices(
    InvoiceID SERIAL PRIMARY KEY,
    PatientID INT,
    TotalAmount DECIMAL(10,2),
    Date DATE,
    Status VARCHAR(20),
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID)
); 

CREATE TABLE Staff (
    StaffID INT PRIMARY KEY,
    Name VARCHAR(100),
    Role VARCHAR(50),
    Contact VARCHAR(15)
);

CREATE TABLE Rooms (
    RoomID INT PRIMARY KEY,
    RoomType VARCHAR(50), 
    Status VARCHAR(20) DEFAULT 'Available',
    PricePerDay DECIMAL(10,2)
);

CREATE TABLE Lab_Tests (
    TestID INT PRIMARY KEY,
    TestName VARCHAR(100),
    Cost DECIMAL(10,2)
);

CREATE TABLE Patient_Tests (
    PatientTestID INT PRIMARY KEY,
    PatientID INT,
    TestID INT,
    Result VARCHAR(255),
    TestDate DATE,
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID),
    FOREIGN KEY (TestID) REFERENCES Lab_Tests(TestID)
);

INSERT INTO Patients (PatientID, Name, DOB, Contact, BloodGroup) VALUES
(1, 'Ali Khan', '1985-07-12', '03001234567', 'A+'),
(2, 'Sara Ahmed', '1990-03-21', '03007654321', 'B+');
SELECT * FROM Patients;

INSERT INTO Departments (DeptID, DeptName, Floor) VALUES
(1, 'Cardiology', 2),
(2, 'Neurology', 3);
SELECT * FROM Departments ;

INSERT INTO Doctors (DoctorID, Name, Specialization, DeptID) VALUES
(1, 'Dr. Ayesha Malik', 'Cardiologist', 1),
(2, 'Dr. Imran Qureshi', 'Neurologist', 2);
SELECT * FROM Doctors;

INSERT INTO Appointments (ApplID, PatientID, DoctorID, Date, Time, Status) VALUES
(1, 1, 1, '2026-04-01', '10:00:00', 'Scheduled'),
(2, 2, 2, '2026-04-02', '11:30:00', 'Completed');
SELECT * FROM Appointments;

INSERT INTO Medical_Records (RecordID, PatientID, DoctorID, Diagnosis, Date) VALUES
(1, 1, 1, 'Hypertension', '2026-04-01'),
(2, 2, 2, 'Migraine', '2026-04-02');
SELECT * FROM Medical_Records ;

INSERT INTO Prescriptions(PrescID, RecordID, MedicineName, Dosage) VALUES
(1, 1, 'Amlodipine', '5mg once daily'),
(2, 2, 'Paracetamol', '500mg every 6 hours');
SELECT * FROM Prescriptions;

INSERT INTO Invoices(InvoiceID, PatientID, TotalAmount, Date, Status) VALUES
(1, 1, 1500.00, '2026-04-01', 'Paid'),
(2, 2, 2000.00, '2026-04-02', 'Pending');
SELECT * FROM Invoices;

INSERT INTO Staff(StaffID, Name, Role, Contact) VALUES
(1, 'Fatima Noor', 'Nurse', '03001112233'),
(2, 'Ahmed Raza', 'Receptionist', '03002223344');
SELECT * FROM Staff;

INSERT INTO Rooms (RoomID, RoomType, Status, PricePerDay) VALUES
(101, 'General Ward', 'Available', 1500.00),
(102, 'Private Room', 'Available', 5000.00),
(103, 'ICU', 'Occupied', 15000.00);
SELECT * FROM Rooms;

INSERT INTO Lab_Tests (TestID, TestName, Cost) VALUES
(1, 'Complete Blood Count (CBC)', 800.00),
(2, 'Blood Sugar Test', 300.00),
(3, 'Chest X-Ray', 2500.00),
(4, 'MRI Scan', 12000.00);
SELECT * FROM Lab_Tests;

INSERT INTO Patient_Tests (PatientTestID, PatientID, TestID, Result, TestDate) VALUES
(1, 1, 1, 'Hemoglobin: 14.5 g/dL', '2026-04-01'),
(2, 2, 3, 'Clear - No congestion', '2026-04-02');
SELECT * FROM Patient_Tests;

CREATE PROCEDURE Generate_Bill(IN p_PatientID INT, IN p_Fee DECIMAL(10,2))
LANGUAGE plpgsql
AS $$
BEGIN
   
    INSERT INTO Invoices (PatientID, TotalAmount, Date, Status)
    VALUES (p_PatientID, p_Fee * 1.05, CURRENT_DATE, 'Pending');

END;
$$;
CALL GENERATE_BILL(1,2000);
select * from invoices;