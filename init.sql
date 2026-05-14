
-- Database: visit_nest_db


CREATE DATABASE IF NOT EXISTS visit_nest_db;
USE visit_nest_db;

-- ── Table: users ──────────────────────────────────────────────
-- Stores system accounts for Security Guards and Admins
CREATE TABLE IF NOT EXISTS users (
  id            INT AUTO_INCREMENT PRIMARY KEY,
  username      VARCHAR(50)  NOT NULL UNIQUE,
  password_hash VARCHAR(255) NOT NULL,
  role          ENUM('SECURITY', 'ADMIN') NOT NULL DEFAULT 'SECURITY',
  full_name     VARCHAR(100) NOT NULL,
  created_at    DATETIME     DEFAULT CURRENT_TIMESTAMP
);

-- ── Table: residents ──────────────────────────────────────────
-- Stores registered student residents of the hostel
CREATE TABLE IF NOT EXISTS residents (
  id          INT AUTO_INCREMENT PRIMARY KEY,
  full_name   VARCHAR(100) NOT NULL,
  room_number VARCHAR(10)  NOT NULL,
  student_id  VARCHAR(20)  NOT NULL UNIQUE,
  created_at  DATETIME     DEFAULT CURRENT_TIMESTAMP
);

-- ── Table: visit_records ──────────────────────────────────────
-- Stores every visitor entry and exit
CREATE TABLE IF NOT EXISTS visit_records (
  id              INT AUTO_INCREMENT PRIMARY KEY,
  visitor_name    VARCHAR(100) NOT NULL,
  phone           VARCHAR(15)  NOT NULL,
  national_id     VARCHAR(20)  NOT NULL,
  resident_id     INT          NOT NULL,
  purpose         VARCHAR(100) NOT NULL DEFAULT 'Family Visit',
  time_in         DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  time_out        DATETIME     NULL,
  status          ENUM('INSIDE', 'EXITED') NOT NULL DEFAULT 'INSIDE',
  registered_by   INT          NOT NULL,
  FOREIGN KEY (resident_id)   REFERENCES residents(id),
  FOREIGN KEY (registered_by) REFERENCES users(id)
);

-- ── Table: reports ────────────────────────────────────────────
-- Stores generated report metadata
CREATE TABLE IF NOT EXISTS reports (
  id            INT AUTO_INCREMENT PRIMARY KEY,
  generated_by  INT          NOT NULL,
  report_type   ENUM('DAILY', 'WEEKLY', 'MONTHLY', 'CUSTOM') NOT NULL,
  date_from     DATE         NOT NULL,
  date_to       DATE         NOT NULL,
  generated_at  DATETIME     DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (generated_by) REFERENCES users(id)
);

-- ── Table: notifications ──────────────────────────────────────
-- Stores system alerts triggered by visit events
CREATE TABLE IF NOT EXISTS notifications (
  id             INT AUTO_INCREMENT PRIMARY KEY,
  visit_record_id INT         NOT NULL,
  message        VARCHAR(255) NOT NULL,
  recipient_id   INT          NOT NULL,
  sent_at        DATETIME     DEFAULT CURRENT_TIMESTAMP,
  is_read        TINYINT(1)   DEFAULT 0,
  FOREIGN KEY (visit_record_id) REFERENCES visit_records(id) ON DELETE CASCADE,
  FOREIGN KEY (recipient_id)    REFERENCES users(id)
);

-- ─────────────────────────────────────────────────────────────
-- Seed Data — initial records for demonstration
-- ─────────────────────────────────────────────────────────────

-- Seed users
INSERT INTO users (username, password_hash, role, full_name) VALUES
  ('security1', 'pass123', 'SECURITY', 'Jean-Paul Habimana'),
  ('admin',     'admin123', 'ADMIN',   'Dr. Marie Uwase');

-- Seed residents
INSERT INTO residents (full_name, room_number, student_id) VALUES
  ('Alice Mukamana',      'A-101', 'STU-2024-001'),
  ('Bernadette Ingabire', 'B-205', 'STU-2024-002'),
  ('Claire Nzeyimana',    'C-312', 'STU-2024-003'),
  ('Diane Ishimwe',       'A-104', 'STU-2024-004'),
  ('Esther Kayitesi',     'D-201', 'STU-2024-005');

-- Seed visit records
INSERT INTO visit_records (visitor_name, phone, national_id, resident_id, purpose, time_in, time_out, status, registered_by) VALUES
  ('John Mukamana',         '0781234567', '1199012345678', 1, 'Family Visit',   '2026-05-10 08:30:00', '2026-05-10 10:15:00', 'EXITED', 1),
  ('Patrick Habimana',      '0789876543', '1198511234567', 2, 'Friend Visit',   '2026-05-10 09:00:00', NULL,                  'INSIDE', 1),
  ('Grace Uwimana',         '0722345678', '1200112345678', 3, 'Guardian Visit', '2026-05-10 10:45:00', NULL,                  'INSIDE', 1),
  ('Emmanuel Nshimiyimana', '0731234567', '1997512345678', 4, 'Family Visit',   '2026-05-09 14:00:00', '2026-05-09 16:30:00', 'EXITED', 2),
  ('Solange Mukamurenzi',   '0783456789', '1201012345678', 5, 'Friend Visit',   '2026-05-09 15:20:00', '2026-05-09 17:00:00', 'EXITED', 1);
