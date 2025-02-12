# Car Rental System

Simple car rental system built using **Svelte** for the frontend, **PHP** for backend processing, and a **MySQL database** for storing user data, reservations, and car listings. The application is served via **Apache**.

## Features
### Public Users (Non-Logged In)
- **User Registration**: 
  - Passwords are securely encrypted in the database.
  - Accounts require activation by an administrator.
- **User Login**: 
  - Only logged-in users can make a reservation.
- **Car Listings with Filtering**: 
  - Search and filter cars by brand, transmission type, engine type, and air conditioning.
- **Terms & Conditions Page**

### Logged-In Users
- **Make Car Reservations**: 
  - Users can book a car for a specified period.
- **Reservation Management**:
  - View active reservations.
  - Access reservation history.

### Admin & Moderator Roles
- **Administrator Panel**:
  - Manages user accounts.
  - Activates new user registrations.
- **Moderator Panel**:
  - Approves user reservations.
  - Accesses reservation history.

## Installation
### Requirements
- Apache Server (e.g., XAMPP, LAMP, MAMP, or Docker)
- MySQL/MariaDB
- PHP
- Node.js & npm (for Svelte frontend)

### Setup Instructions
#### 1. Start Apache & MySQL
Ensure that your Apache and MySQL services are running.

#### 2. Database Setup
- Import the SQL schema from `projekt_wypozyczalnia.sql` into your MySQL database.
- Update the database credentials in `backend/config.php`.

To import the database using phpMyAdmin:
1. Open `http://localhost/phpmyadmin/`
2. Select your database or create a new one
3. Go to the **Import** tab
4. Upload `projekt_wypozyczalnia.sql`
5. Click **Go**

#### 3. Backend Setup (PHP)
Place the projects folder in your Apache server directory (`htdocs/` for XAMPP, `/var/www/html/` for LAMP).

#### 4. Frontend Setup (Svelte)
Navigate to the projects folder and install dependencies:
```sh
npm install
```
Run the development server:
```sh
npm run dev
```

## Usage
- Open `http://localhost/projekt_wypozyczalnia/` in a web browser to access the project.

## Security Measures
- Passwords are hashed before storing in the database.
- Users must be activated by an administrator before logging in.
- Only authorized users can make and manage reservations.
