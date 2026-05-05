use schoolmamagement;

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
