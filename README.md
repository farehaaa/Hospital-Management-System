 Hospital Management System (HMS) Database

A relational database schema for a Hospital Management System designed to handle patient records, doctor allocations, appointments, medical histories, billing, staff logs, room occupancy, and laboratory testing.

Features:
- **Patient & Doctor Management:** Track comprehensive profiles, blood groups, and specializations.
- **Appointment Scheduling:** Log schedules, times, and fulfillment statuses.
- **Medical Records & Prescriptions:** Maintain history logs of diagnoses paired with corresponding pharmacy dosages.
- **Invoicing & Billing:** Auto-calculate balances including integrated billing procedures.
- **Hospital Infrastructure:** Manage dynamic inventory for rooms (Wards, Private, ICU) and staff roles.
- **Lab Diagnostic Testing:** Track patient test records and transactional laboratory pricing.

 Database Schema

Here is the structured overview of the entities and relations within this system:
Patients ───< Appointments >─── Doctors >─── Departments
│                               │
├───< Medical_Records ──────────┘
│           │
│           └───< Prescriptions
│
├───< Invoices
└───< Patient_Tests >─── Lab_Tests
Prerequisites:
-Database Engine: PostgreSQL

Stored Procedures & Logic:
The database contains operational layer automations, such as the Generate_Bill routine which standardizes calculations by automatically incorporating a 5% service tax markup.

This project is open-source and available under the APACHE License 2.0.
