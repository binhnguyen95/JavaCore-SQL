create database QLSV;

USE QLSV;

CREATE TABLE Class
(
    ClassID   INT         NOT NULL AUTO_INCREMENT PRIMARY KEY,
    ClassName VARCHAR(60) NOT NULL,
    StartDate DATETIME    NOT NULL,
    Status    BIT
);

CREATE TABLE Student
(
    StudentId   INT         NOT NULL AUTO_INCREMENT PRIMARY KEY,
    StudentName VARCHAR(30) NOT NULL,
    Address     VARCHAR(50),
    Phone       VARCHAR(20),
    Status      BIT,
    ClassId     INT         NOT NULL,
    FOREIGN KEY (ClassId) REFERENCES Class (ClassID)
);

CREATE TABLE Subject
(
    SubId   INT         NOT NULL AUTO_INCREMENT PRIMARY KEY,
    SubName VARCHAR(30) NOT NULL,
    Credit  TINYINT     NOT NULL DEFAULT 1 CHECK ( Credit >= 1 ),
    Status  BIT                  DEFAULT 1
);

CREATE TABLE Mark
(
    MarkId    INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    SubId     INT NOT NULL,
    StudentId INT NOT NULL,
    Mark      FLOAT   DEFAULT 0 CHECK ( Mark BETWEEN 0 AND 100),
    ExamTimes TINYINT DEFAULT 1,
    UNIQUE (SubId, StudentId),
    FOREIGN KEY (SubId) REFERENCES Subject (SubId),
    FOREIGN KEY (StudentId) REFERENCES Student (StudentId)
);

select * from QLSV.Class;
insert into Class
values (1, 'A1', '2008-12-20', 1),
	   (2, 'A2', '2008-12-22', 1),
       (3, 'B3', current_date, 0);

select * from QLSV.student;
INSERT INTO Student (StudentName, Address, Phone, Status, ClassId)
VALUES ('Hung', 'Ha Noi', '0912113113', 1, 1);
INSERT INTO Student (StudentName, Address, Status, ClassId)
VALUES ('Hoa', 'Hai phong', 1, 1);
INSERT INTO Student (StudentName, Address, Phone, Status, ClassId)
VALUES ('Manh', 'HCM', '0123123123', 0, 2);
       
select * from QLSV.subject;
INSERT INTO Subject
VALUES (1, 'CF', 5, 1),
       (2, 'C', 6, 1),
       (3, 'HDJ', 5, 1),
       (4, 'RDBMS', 10, 1);

select * from QLSV.mark;     
INSERT INTO Mark (SubId, StudentId, Mark, ExamTimes)
VALUES (1, 1, 8, 1),
       (1, 2, 10, 2),
       (2, 1, 12, 1);

SELECT S.StudentName, C.ClassName
FROM Student S join Class C on S.ClassId = C.ClassID
WHERE C.ClassName = 'A1';

SELECT S.StudentId, S.StudentName, Sub.SubName, M.Mark
FROM Student S 
join Mark M 
on S.StudentId = M.StudentId 
join Subject Sub on M.SubId = Sub.SubId;

SELECT S.StudentId, S.StudentName, Sub.SubName, M.Mark
FROM Student S 
join Mark M 
on S.StudentId = M.StudentId 
join Subject Sub on M.SubId = Sub.SubId
WHERE Sub.SubName = 'CF';

SELECT S.StudentId, S.StudentName, AVG(Mark)
FROM Student S 
join Mark M on S.StudentId = M.StudentId
GROUP BY S.StudentId, S.StudentName;

SELECT SubName, MAX(credit)
FROM subject;

SELECT ST.StudentId, ST.studentName, SJ.SubName, MAX(mark)
FROM student ST, subject SJ, mark;

select C.className, S.studentName
from Student S
join Class C on S.classId = C.classId;

alter table Mark drop foreign key mark_ibfk_1;

alter table Mark add foreign key (SubId) references QLSV.subject(SubId);





 