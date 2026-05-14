# 🛡️ VisitNest — Smart Hostel Visitor Management System

> **Course:** SENG 8240 – Best Programming Practices and Design Patterns  
> **Institution:** Adventist University of Central Africa  
> **Academic Year:** 2025/2026, Semester II  
> **Case Study:** GreenView Girls Hostel, Kigali, Rwanda  

---

## 📌 Project Overview

VisitNest is a digital visitor management system designed to replace the manual notebook-based visitor logging system at GreenView Girls Hostel. The system allows security personnel to register visitors electronically, track entry and exit times, search visitor records, and generate management reports.

---

## 🧩 System Architecture

The application is divided into three components:

| Component | Technology | Port |
|-----------|-----------|------|
| Frontend  | React.js  | 3000 |
| Backend   | Node.js / Express | 5000 |
| Database  | MySQL 8.0 | 3306 |

---

## 📁 Project Structure

```
visitnest/
├── frontend/               # React web application
│   ├── src/
│   │   ├── App.jsx         # Main application component
│   │   └── ...
│   └── Dockerfile
├── backend/                # Node.js Express API
│   ├── controllers/        # Auth, Visitor, Report controllers
│   ├── services/           # Business logic layer
│   ├── server.js           # Entry point
│   └── Dockerfile
├── database/
│   └── init.sql            # MySQL schema and seed data
├── docker-compose.yml      # Orchestrates all three services
├── .env.example            # Environment variable template
├── .gitignore              # Files excluded from version control
└── README.md               # This file
```

---

## 🚀 How to Run with Docker

### Prerequisites
- [Docker Desktop](https://www.docker.com/products/docker-desktop/) installed

### Steps

**1. Clone the repository**
```bash
git clone https://github.com/your-username/visitnest.git
cd visitnest
```

**2. Set up environment variables**
```bash
# Copy the example file and rename it
cp .env.example .env
```

**3. Start all services with Docker Compose**
```bash
docker-compose up --build
```

**4. Open the application**
- Frontend: http://localhost:3000
- Backend API: http://localhost:5000

**5. Stop the application**
```bash
docker-compose down
```

---

## 🖥️ How to Run Without Docker

### Prerequisites
- Node.js v18+
- MySQL 8.0

### Steps

**1. Set up the database**
```bash
# Log into MySQL and run the init script
mysql -u root -p < database/init.sql
```

**2. Start the backend**
```bash
cd backend
npm install
npm start
```

**3. Start the frontend**
```bash
cd frontend
npm install
npm start
```

---

## 🔐 Demo Login Credentials

| Role | Username | Password |
|------|----------|----------|
| Security Guard | `security1` | `pass123` |
| Admin / Manager | `admin` | `admin123` |

---

## 🗄️ Database Tables

| Table | Description |
|-------|-------------|
| `users` | System accounts (Security Guards and Admins) |
| `residents` | Registered student residents |
| `visit_records` | All visitor check-in and check-out records |
| `reports` | Generated report metadata |
| `notifications` | System alerts triggered by visit events |

---

## 🎨 Design Patterns Used

| Pattern | Type | Where Applied |
|---------|------|--------------|
| MVC | Architectural | Controllers → Services → DB |
| Singleton | Creational | Database connection, Logger |
| Observer | Behavioral | Notifications on visit events |

---

## 🐳 Docker Configuration

- **Dockerfile** — Multi-stage build for the Node.js backend. Uses `node:18-alpine` to minimize image size.
- **docker-compose.yml** — Orchestrates frontend, backend, and MySQL database containers on a shared private network (`visitnest_network`).
- **Named Volume** — `visitnest_db` persists MySQL data across container restarts.
- **Port Mapping** — Host ports 3000, 5000, and 3306 mapped to respective container ports.

---

## 📋 Git Branching Strategy

| Branch | Purpose |
|--------|---------|
| `main` | Stable production-ready code |
| `develop` | Active development |
| `feature/visitor-registration` | Visitor registration feature |
| `feature/reports` | Reports and analytics feature |
| `feature/auth` | Login and authentication feature |

---

## ✅ Commit Message Convention

This project follows the **Conventional Commits** standard:

```
feat: add visitor registration form
fix: resolve check-out timestamp bug
docs: update README with Docker instructions
chore: add .gitignore and .env.example
test: add test cases for login validation
```
