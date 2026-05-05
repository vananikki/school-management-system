-- 1. Tạo Database
CREATE DATABASE SchoolManagement;
USE SchoolManagement;

-- 2. Bảng Giáo viên
CREATE TABLE Teachers (
    TeacherID INT PRIMARY KEY,
    TeacherName VARCHAR(100) NOT NULL,
    Subject VARCHAR(50),
    Email VARCHAR(100) UNIQUE
);

-- 3. Bảng Lớp học
CREATE TABLE Classes (
    ClassID INT PRIMARY KEY,
    ClassName VARCHAR(50) NOT NULL,
    TeacherID INT,
    FOREIGN KEY (TeacherID) REFERENCES Teachers(TeacherID)
);

-- 4. Bảng Học sinh
CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    StudentName VARCHAR(100) NOT NULL,
    BirthDate DATE,
    ClassID INT,
    Address VARCHAR(255),
    FOREIGN KEY (ClassID) REFERENCES Classes(ClassID)
);

-- 5. Bảng Môn học
CREATE TABLE Subjects (
    SubjectID INT PRIMARY KEY,
    SubjectName VARCHAR(100) NOT NULL
);

-- 6. Bảng Điểm số
CREATE TABLE Grades (
    GradeID INT PRIMARY KEY AUTO_INCREMENT,
    StudentID INT,
    SubjectID INT,
    Score DECIMAL(4, 2) CHECK (Score >= 0 AND Score <= 10),
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    FOREIGN KEY (SubjectID) REFERENCES Subjects(SubjectID)
);

-- Insert data into Teachers table
INSERT INTO Teachers (TeacherID, TeacherName, Subject, Email) VALUES 
(11204567, 'Nguyễn Văn Hùng', 'Introduction to Databases & Data Analysis with Python', 'nguyen_hung@st.neu.edu.vn'),
(11208912, 'Trần Minh Tâm', 'Information Security', 'tran_tam@st.neu.edu.vn'),
(11203344, 'Lê Thị Hòa', 'Mathematics for Data Science and AI', 'le_hoa@st.neu.edu.vn'),
(11205566, 'Phạm Anh Tuấn', 'Monetary and Financial Theory', 'pham_tuan@st.neu.edu.vn'),
(11207788, 'Hoàng Trung Kiên', 'Cloud Computing', 'hoang_kien@st.neu.edu.vn');

-- insert data into Subjects table
INSERT INTO Subjects (SubjectID, SubjectName) VALUES 
(1, 'Information Security'),
(2, 'Mathematics for Data Science and AI'),
(3, 'Data Analysis with Python'),
(4, 'Introduction to Databases'),
(5, 'Monetary and Financial Theory'),
(6, 'Cloud Computing');

-- insert data into Classes table
INSERT INTO Classes (ClassID, ClassName, TeacherID) VALUES 
(101, 'DS66A', 11204567), -- Giảng viên Hùng (Database/Data Analysis)
(102, 'DS66B', 11204567), -- Giảng viên Hùng (Database/Data Analysis)
(103, 'AI66A', 11208912), -- Giảng viên Tâm (Info Security)
(104, 'AI66B', 11203344), -- Giảng viên Hòa (Math for AI)
(105, 'DS67A', 11204567), -- Giảng viên Hùng (Database/Data Analysis)
(106, 'DS67B', 11207788), -- Giảng viên Kiên (Cloud Computing)
(107, 'DS67C', 11205566), -- Giảng viên Tuấn (Monetary Theory)
(108, 'AI67A', 11203344), -- Giảng viên Hòa (Math for AI)
(109, 'AI67B', 11208912), -- Giảng viên Tâm (Info Security)
(110, 'AI67C', 11207788); -- Giảng viên Kiên (Cloud Computing)


INSERT INTO Students (StudentID, StudentName, BirthDate, ClassID, Address) VALUES 
(11247118, 'Nguyễn Hoàng Thiên An', '2006-05-15', 101, 'Quận Hai Bà Trưng, Hà Nội'),
(11247121, 'Bùi Duy Anh', '2006-08-22', 102, 'Quận Đống Đa, Hà Nội'),
(11247125, 'Dương Minh Anh', '2006-01-10', 103, 'Quận Cầu Giấy, Hà Nội'),
(11247123, 'Đinh Vân Anh', '2006-11-30', 104, 'Quận Ba Đình, Hà Nội'),
(11247130, 'Nguyễn Hồng Anh', '2006-03-12', 105, 'Quận Thanh Xuân, Hà Nội'),
(11247137, 'Phạm Thùy Anh', '2006-07-19', 106, 'Quận Hoàn Kiếm, Hà Nội'),
(11247140, 'Trần Đinh Quang Anh', '2006-12-05', 107, 'Quận Long Biên, Hà Nội'),
(11247141, 'Vũ Thị Phương Anh', '2006-09-14', 108, 'Quận Tây Hồ, Hà Nội'),
(11247146, 'Nguyễn Minh Chiến', '2006-02-28', 109, 'Quận Nam Từ Liêm, Hà Nội'),
(11247147, 'Bùi Đăng Cường', '2006-04-20', 110, 'Quận Hà Đông, Hà Nội');


-- insert data into Grades table
INSERT INTO Grades (StudentID, SubjectID, Score) VALUES 
(11247118, 1, 8.5), (11247118, 2, 7.0), (11247118, 3, 9.2), (11247118, 4, 8.8), (11247118, 5, 7.5), (11247118, 6, 8.0),
(11247121, 1, 3.2), (11247121, 2, 5.0), (11247121, 3, 4.5), (11247121, 4, 2.8), (11247121, 5, 6.0), (11247121, 6, 5.2),
(11247125, 1, 9.5), (11247125, 2, 9.0), (11247125, 3, 9.5), (11247125, 4, 9.0), (11247125, 5, 9.8), (11247125, 6, 9.1),
(11247123, 1, 10.0), (11247123, 2, 9.8), (11247123, 3, 10.0), (11247123, 4, 10.0), (11247123, 5, 9.5), (11247123, 6, 10.0),
(11247130, 1, 7.0), (11247130, 2, 8.2), (11247130, 3, 6.8), (11247130, 4, 7.5), (11247130, 5, 6.0), (11247130, 6, 7.7),
(11247137, 1, 6.5), (11247137, 2, 4.2), (11247137, 3, 8.0), (11247137, 4, 7.2), (11247137, 5, 5.8), (11247137, 6, 7.5),
(11247140, 1, 8.2), (11247140, 2, 7.5), (11247140, 3, 6.2), (11247140, 4, 9.5), (11247140, 5, 8.8), (11247140, 6, 2.0),
(11247141, 1, 9.0), (11247141, 2, 6.5), (11247141, 3, 8.8), (11247141, 4, 7.5), (11247141, 5, 9.2), (11247141, 6, 9.5),
(11247146, 1, 5.5), (11247146, 2, 6.2), (11247146, 3, 7.0), (11247146, 4, 3.8), (11247146, 5, 5.5), (11247146, 6, 6.8),
(11247147, 1, 7.8), (11247147, 2, 8.5), (11247147, 3, 5.5), (11247147, 4, 8.0), (11247147, 5, 7.5), (11247147, 6, 8.2);

-- indexes
USE SchoolManagement;

CREATE INDEX idx_StudentName ON Students(StudentName);
CREATE INDEX idx_TeacherName ON Teachers(TeacherName);
CREATE INDEX idx_GradeScore ON Grades(Score);
SHOW INDEX FROM Grades;

-- views 
-- class rosters
use schoolmanagement;

CREATE VIEW v_ClassRosters AS
SELECT 
    c.ClassName, 
    s.StudentID, 
    s.StudentName, 
    s.BirthDate
FROM Students s
JOIN Classes c ON s.ClassID = c.ClassID;

-- use views
SELECT * FROM v_ClassRosters WHERE ClassName = 'DS66A';


-- views
-- top students
use schoolmanagement;

CREATE VIEW v_TopStudents AS
SELECT 
    s.StudentID, 
    s.StudentName, 
    ROUND(AVG(g.Score), 2) AS GPA
FROM Students s
JOIN Grades g ON s.StudentID = g.StudentID
GROUP BY s.StudentID, s.StudentName
HAVING GPA >= 8.0
ORDER BY GPA DESC;
SELECT * FROM v_TopStudents LIMIT 3;

-- views
-- subject-wise performance
use schoolmanagement;

CREATE VIEW v_SubjectPerformance AS
SELECT 
    sub.SubjectName, 
    ROUND(AVG(g.Score), 2) AS AverageScore,
    MIN(g.Score) AS LowestScore,
    MAX(g.Score) AS HighestScore
FROM Subjects sub
JOIN Grades g ON sub.SubjectID = g.SubjectID
GROUP BY sub.SubjectID, sub.SubjectName;


-- stored procedure 
-- grade update

use schoolmanagement;

DELIMITER //

CREATE PROCEDURE sp_UpdateStudentGrade(
    IN p_StudentID INT, 
    IN p_SubjectID INT, 
    IN p_NewScore DECIMAL(4,2)
)
BEGIN
    UPDATE Grades 
    SET Score = p_NewScore 
    WHERE StudentID = p_StudentID AND SubjectID = p_SubjectID;
    
    SELECT CONCAT('Success: Grade updated for Student ID ', p_StudentID) AS Message;
END //

DELIMITER ;


-- stored procedure
-- Class Assignment
use schoolmanagement;

DELIMITER //

CREATE PROCEDURE sp_TransferStudent(
    IN p_StudentID INT, 
    IN p_NewClassID INT
)
BEGIN
    UPDATE Students 
    SET ClassID = p_NewClassID 
    WHERE StudentID = p_StudentID;
    
    SELECT CONCAT('Success: Student ', p_StudentID, ' has been transferred to Class ', p_NewClassID) AS Status;
END //

DELIMITER ;


-- user defined functions
-- calculate gpa
use schoolmanagement;

DELIMITER //

CREATE FUNCTION fn_CalculateGPA(p_StudentID INT) 
RETURNS DECIMAL(4,2)
DETERMINISTIC
BEGIN
    DECLARE v_gpa DECIMAL(4,2);
    
    SELECT AVG(Score) INTO v_gpa 
    FROM Grades 
    WHERE StudentID = p_StudentID;
    
    RETURN v_gpa;
END //

DELIMITER ;


-- user defined functions
-- average subject score
use schoolmanagement;

DELIMITER //

CREATE FUNCTION fn_AvgSubjectScore(p_SubjectID INT) 
RETURNS DECIMAL(4,2)
DETERMINISTIC
BEGIN
    DECLARE v_avg_score DECIMAL(4,2);
    
    SELECT AVG(Score) INTO v_avg_score 
    FROM Grades 
    WHERE SubjectID = p_SubjectID;
    
    RETURN IFNULL(v_avg_score, 0.00);
END //

DELIMITER ;


-- triggers
-- create class statistics table
CREATE TABLE ClassStats (
    ClassID INT PRIMARY KEY,
    AverageGPA DECIMAL(4,2) DEFAULT 0,
    TotalRecords INT DEFAULT 0,
    FOREIGN KEY (ClassID) REFERENCES Classes(ClassID)
);

INSERT INTO ClassStats (ClassID) 
SELECT ClassID FROM Classes;


-- triggers
-- create triggers automatically update when inserting new data
DELIMITER //

CREATE TRIGGER trg_UpdateClassPerformance
AFTER INSERT ON Grades
FOR EACH ROW
BEGIN
    -- Lấy ClassID của sinh viên vừa được nhập điểm
    DECLARE v_ClassID INT;
    SELECT ClassID INTO v_ClassID FROM Students WHERE StudentID = NEW.StudentID;

    -- Tự động cập nhật lại điểm trung bình và số lượng đầu điểm của lớp đó
    UPDATE ClassStats
    SET AverageGPA = (
        SELECT AVG(g.Score) 
        FROM Grades g 
        JOIN Students s ON g.StudentID = s.StudentID 
        WHERE s.ClassID = v_ClassID
    ),
    TotalRecords = (
        SELECT COUNT(*) 
        FROM Grades g 
        JOIN Students s ON g.StudentID = s.StudentID 
        WHERE s.ClassID = v_ClassID
    )
    WHERE ClassID = v_ClassID;
END //

DELIMITER ;


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

