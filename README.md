
# Clinic Booking System – Database Management System (DBMS)

## Project Overview

This project is a **relational database management system** designed to simulate a real-world **Clinic Booking System**. It supports functionalities like patient registration, doctor assignments, appointment scheduling, billing, medical records, and role-based access control. The database is built using **SQL** with properly defined relationships, constraints, stored procedures, views, triggers, and sample data.

---

## Core Features

- **Patient Management:** Register and manage patient details and their insurance information.
- **Doctor Management:** Assign doctors to departments and manage their specializations.
- **Appointments:** Schedule and track appointments between doctors and patients.
- **Billing System:** Manage invoices, payments, and billing status.
- **Medical Records:** Store and retrieve diagnoses, treatments, and visit summaries.
- **Prescriptions:** Maintain medication details for appointments.
- **Role-Based Access:** Includes roles for Admins, Doctors, and Receptionists.
- **Data Integrity:** Enforced with primary keys, foreign keys, and triggers.

---

## Database Structure

### Tables

- `Patients`
- `Doctors`
- `Departments`
- `Appointments`
- `Prescriptions`
- `Billing`
- `Medical_Records`
- `Insurance`
- `Users`
- `Roles`
- `UserRoles`
- `Doctor_Patient`

### Relationships

- **1-to-Many:** One patient can have many appointments, bills, and medical records.
- **Many-to-One:** Many appointments/prescriptions link to a single patient and doctor.
- **Many-to-Many:** Doctors and Patients (via `Doctor_Patient` table).

---

## SQL Components

- ✅ Tables with constraints (`PK`, `FK`, `NOT NULL`, `UNIQUE`)
- ✅ Views for simplified data access
- ✅ Stored procedures for encapsulated logic
- ✅ Triggers for automatic data validation
- ✅ Role-based permissions
- ✅ Sample data for testing

---

## How to Use

1. **Create Database**:  
   ```sql
   CREATE DATABASE ClinicDB;
   USE ClinicDB;
   ```

2. **Run SQL Scripts**:  
   Execute the file:
   - `ClinicDB.sql`

3. **Query the System**:  
   Use views and stored procedures to retrieve or modify data as needed.

---

## Sample Files Included

- `clinic_schema.sql` – All table definitions, Sample data for core tables, Sample data for appointments, billing, etc., Defined views and stored procedures, User roles and test users and Data integrity triggers

---

## Roles in the System

| Role         | Permissions                                  |
|--------------|----------------------------------------------|
| Admin        | Full access (create, update, delete records) |
| Doctor       | View patient info, write prescriptions       |
| Receptionist | Schedule appointments, manage billing        |

---

## Notes

- Designed to be scalable and adaptable to real-world clinic operations.
- Written entirely in SQL with MySQL compatibility.
- Sample data helps demonstrate how relationships and logic work together.

---

## Author

**[Charles Mori]**  
*Network Engineer & Database Developer*  
charlesmori12@gmail.com  
LinkedIn: [https://www.linkedin.com/in/charles-mori/]
GitHub: [https://github.com/charles-mori]

---

