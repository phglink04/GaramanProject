# Garaman - Appointment Booking System

A Java web application for managing appointments built with Java Servlets, JSP, and MySQL.

## Features

- User authentication (Customer/Manager login)
- Appointment booking system
- Customer and Manager dashboards
- Database integration with MySQL

## Tech Stack

- **Backend**: Java Servlets
- **Frontend**: JSP (JavaServer Pages)
- **Database**: MySQL
- **Build Tool**: Maven
- **Server**: Compatible with Tomcat

## Project Structure

```
src/
├── main/
│   ├── java/
│   │   └── exam/garaman/
│   │       ├── DAO/           # Data Access Objects
│   │       ├── Model/         # Entity models
│   │       └── Servlet/       # Servlet controllers
│   └── webapp/
│       ├── CustomerView/      # Customer UI pages
│       ├── ManagerView/       # Manager UI pages
│       └── WEB-INF/
└── test/
```

## Setup Instructions

1. **Prerequisites**
   - Java JDK 8 or higher
   - Apache Tomcat 9 or higher
   - MySQL Server
   - Maven

2. **Database Setup**
   - Create a MySQL database
   - Run the `database_setup.sql` script to create tables

3. **Configuration**
   - Update database connection settings in DAO classes
   - Configure your MySQL username/password

4. **Build and Deploy**
   ```bash
   mvn clean compile
   mvn package
   ```
   - Deploy the generated WAR file to Tomcat

## Usage

1. Start your MySQL server
2. Deploy the application to Tomcat
3. Access the application at `http://localhost:8080/Garaman-1.0-SNAPSHOT/`
4. Login as Customer or Manager to access respective features

## Contributors

- Your Name

## License

This project is for educational purposes.
