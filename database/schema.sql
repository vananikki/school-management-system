-- 1. Tạo Database
CREATE DATABASE SchoolManagement;


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

USE SchoolManagement;
-- indexes
CREATE INDEX idx_StudentName ON Students(StudentName);
CREATE INDEX idx_TeacherName ON Teachers(TeacherName);
CREATE INDEX idx_GradeScore ON Grades(Score);
SHOW INDEX FROM Grades;

-- views 
-- class rosters
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


