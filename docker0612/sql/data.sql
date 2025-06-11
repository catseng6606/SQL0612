-- 3. 建立 Books 表格
CREATE TABLE IF NOT EXISTS Books (
    BookID INT AUTO_INCREMENT PRIMARY KEY,
    Title VARCHAR(255) NOT NULL,
    Author VARCHAR(100) NOT NULL,
    ISBN VARCHAR(20) UNIQUE,
    PublicationYear INT,
    Category VARCHAR(50),
    StockQuantity INT NOT NULL DEFAULT 0, -- 庫存數量
    Price DECIMAL(10, 2)
);

-- 插入範例資料到 Books 表格
INSERT INTO Books (Title, Author, ISBN, PublicationYear, Category, StockQuantity, Price) VALUES
('資料庫系統概論', '王大明', '978-986-XXXXXX1', 2020, '電腦科學', 5, 550.00),
('Python程式設計入門', '陳小華', '978-986-XXXXXX2', 2021, '電腦科學', 3, 480.00),
('世界歷史精華', '林美玲', '978-986-XXXXXX3', 2018, '歷史', 7, 620.00),
('管理學原理', '張志明', '978-986-XXXXXX4', 2019, '商業', 4, 580.00),
('深入淺出MySQL', '李文傑', '978-986-XXXXXX5', 2022, '電腦科學', 2, 650.00),
('軟體工程實踐', '黃家豪', '978-986-XXXXXX6', 2023, '電腦科學', 6, 700.00);

-- 4. 建立 Borrowers 表格
CREATE TABLE IF NOT EXISTS Borrowers (
    BorrowerID INT AUTO_INCREMENT PRIMARY KEY,
    BorrowerName VARCHAR(100) NOT NULL,
    BorrowerPhone VARCHAR(20) UNIQUE,
    BorrowerEmail VARCHAR(100) UNIQUE
);

-- 插入範例資料到 Borrowers 表格
INSERT INTO Borrowers (BorrowerName, BorrowerPhone, BorrowerEmail) VALUES
('李四', '0912345678', 'lisi@example.com'),
('王小明', '0922334455', 'wangxm@example.com'),
('陳大華', '0933445566', 'chenhd@example.com');

-- 5. 建立 BorrowRecords 表格
CREATE TABLE IF NOT EXISTS BorrowRecords (
    RecordID INT AUTO_INCREMENT PRIMARY KEY,
    BookID INT NOT NULL,
    BorrowerID INT NOT NULL,
    BorrowDate DATE NOT NULL,
    ReturnDate DATE, -- 歸還日期，可為空（表示未歸還）
    DueDate DATE NOT NULL, -- 應歸還日期
    FOREIGN KEY (BookID) REFERENCES Books(BookID) ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (BorrowerID) REFERENCES Borrowers(BorrowerID) ON DELETE RESTRICT ON UPDATE CASCADE
);

-- 插入範例資料到 BorrowRecords 表格
INSERT INTO BorrowRecords (BookID, BorrowerID, BorrowDate, DueDate, ReturnDate) VALUES
(1, 1, '2025-05-20', '2025-06-03', '2025-05-28'), -- 李四借閱了 '資料庫系統概論' 並已歸還
(2, 2, '2025-06-01', '2025-06-15', NULL), -- 王小明借閱了 'Python程式設計入門' 尚未歸還
(3, 1, '2025-06-05', '2025-06-19', NULL), -- 李四借閱了 '世界歷史精華' 尚未歸還
(4, 3, '2025-06-08', '2025-06-22', NULL); -- 陳大華借閱了 '管理學原理' 尚未歸還

-- 6. 建立 Courses 表格
CREATE TABLE IF NOT EXISTS Courses (
    CourseID VARCHAR(10) PRIMARY KEY,
    CourseName VARCHAR(100) NOT NULL,
    Credits INT NOT NULL,
    Department VARCHAR(50)
);

-- 插入範例資料到 Courses 表格
INSERT INTO Courses (CourseID, CourseName, Credits, Department) VALUES
('CS101', '資料庫系統', 3, '資訊工程'),
('CS102', '資料結構', 3, '資訊工程'),
('MA201', '微積分', 4, '數學'),
('EN101', '英文寫作', 3, '外文');

-- 7. 建立 Enrollments 表格
CREATE TABLE IF NOT EXISTS Enrollments (
    EnrollmentID INT AUTO_INCREMENT PRIMARY KEY,
    StudentID INT NOT NULL, -- 假設這裡的 StudentID 實際上就是 Borrowers.BorrowerID (為了簡化課程練習)
    CourseID VARCHAR(10) NOT NULL,
    EnrollmentDate DATE NOT NULL,
    Grade CHAR(1) NULL, -- 成績，可為空
    FOREIGN KEY (StudentID) REFERENCES Borrowers(BorrowerID) ON DELETE RESTRICT ON UPDATE CASCADE, -- 這裡假設學生ID與讀者ID為同一組
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID) ON DELETE RESTRICT ON UPDATE CASCADE,
    UNIQUE (StudentID, CourseID) -- 確保一個學生不能重複選同一門課
);

-- 插入範例資料到 Enrollments 表格
INSERT INTO Enrollments (StudentID, CourseID, EnrollmentDate, Grade) VALUES
(1, 'CS101', '2025-02-15', 'A'), -- 李四選了資料庫系統
(1, 'MA201', '2025-02-15', 'B'), -- 李四選了微積分
(2, 'CS101', '2025-02-16', NULL), -- 王小明選了資料庫系統 (成績未出)
(3, 'CS102', '2025-02-17', 'A'); -- 陳大華選了資料結構

-- 8. 建立 Students 表格
CREATE TABLE IF NOT EXISTS Students (
    StudentID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Major VARCHAR(50),
    EnrollmentYear INT
);

-- 插入範例資料到 Students 表格
INSERT INTO Students (Name, Major, EnrollmentYear) VALUES
('李小龍', '資訊工程', 2023),
('王美麗', '電子電機', 2024),
('陳建國', '數學', 2023),
('林依依', '外文', 2024);