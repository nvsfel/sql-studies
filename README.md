# Data Modeling Project: Vehicle Rental Company

This project focuses on relational database modeling for a vehicle rental company. The core goal is ERD optimization and enforcing data integrity using SQL (DDL/DML).


### Business Rules

* A client *cannot* rent more than one vehicle at a time, regardless of the type (car or motorcycle).


### Technical Implementation & Design Decisions (Decisões de Design)

* ERD Optimization: The model consolidates Car and Motorcycle entities into a single **Vehicle** entity for better scalability and simplified relationships.

* **Data Integrity:** The **ENUM** and **NOT NULL** clauses are used to enforce data integrity for static values like vehicle type ('carro' and 'moto') and fuel type.

### Technologies

SQL (DDL/DML)
