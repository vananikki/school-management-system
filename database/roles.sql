-- database security and administrator
-- create roles
use schoolmanagement;

CREATE ROLE IF NOT EXISTS 'admin_role', 'coordinator_role', 'teacher_role';

-- Cấp quyền cơ bản (Ví dụ)
GRANT ALL PRIVILEGES ON SchoolManagement.* TO 'admin_role';
GRANT SELECT, INSERT, UPDATE ON SchoolManagement.* TO 'coordinator_role';
GRANT SELECT, INSERT, UPDATE ON SchoolManagement.Grades TO 'teacher_role';
-- database security and administrator
-- create user admin and coordinator

-- Admin: Vana, Pass: Vananikki1989
CREATE USER 'admin'@'localhost' IDENTIFIED BY 'Vananikki1989';
GRANT 'admin_role' TO 'admin'@'localhost';
SET DEFAULT ROLE 'admin_role' TO 'admin'@'localhost';

-- Coordinator: education_office, Pass: office
CREATE USER 'education_office'@'localhost' IDENTIFIED BY 'office';
GRANT 'coordinator_role' TO 'education_office'@'localhost';
SET DEFAULT ROLE 'coordinator_role' TO 'education_office'@'localhost';
-- database security and administrator
-- create user teachers

-- 1. Giáo viên Nguyễn Văn Hùng
CREATE USER 'teacher_nguyenvanhung'@'localhost' IDENTIFIED BY 'nguyenvanhung';
GRANT 'teacher_role' TO 'teacher_nguyenvanhung'@'localhost';
SET DEFAULT ROLE 'teacher_role' TO 'teacher_nguyenvanhung'@'localhost';

-- 2. Giáo viên Trần Minh Tâm
CREATE USER 'teacher_tranminhtam'@'localhost' IDENTIFIED BY 'tranminhtam';
GRANT 'teacher_role' TO 'teacher_tranminhtam'@'localhost';
SET DEFAULT ROLE 'teacher_role' TO 'teacher_tranminhtam'@'localhost';

-- 3. Giáo viên Lê Thị Hòa
CREATE USER 'teacher_lethihoa'@'localhost' IDENTIFIED BY 'lethihoa';
GRANT 'teacher_role' TO 'teacher_lethihoa'@'localhost';
SET DEFAULT ROLE 'teacher_role' TO 'teacher_lethihoa'@'localhost';

-- 4. Giáo viên Phạm Anh Tuấn
CREATE USER 'teacher_phamanhtuan'@'localhost' IDENTIFIED BY 'phamanhtuan';
GRANT 'teacher_role' TO 'teacher_phamanhtuan'@'localhost';
SET DEFAULT ROLE 'teacher_role' TO 'teacher_phamanhtuan'@'localhost';

-- 5. Giáo viên Hoàng Trung Kiên
CREATE USER 'teacher_hoangtrungkien'@'localhost' IDENTIFIED BY 'hoangtrungkien';
GRANT 'teacher_role' TO 'teacher_hoangtrungkien'@'localhost';
SET DEFAULT ROLE 'teacher_role' TO 'teacher_hoangtrungkien'@'localhost';

