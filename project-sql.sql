-- A list of SQL statements used to create our tables:

CREATE SCHEMA IF NOT EXISTS university_db;
USE university_db;

CREATE TABLE Student (
StudentID    	INT NOT NULL,
StudentName	VARCHAR(20),
Major   	 	VARCHAR(20) DEFAULT "Undeclared",
Minor   	 	VARCHAR(20),
GPA   	 	DOUBLE,
StudentYear 	VARCHAR(20)
   			CHECK(StudentYear IN ("Freshman", "Sophomore", "Junior", "Senior")),
CONSTRAINT student_pk PRIMARY KEY (StudentID)
);

CREATE TABLE Instructor (
InstructorID 		INT NOT NULL,
InstructorName  	VARCHAR(20),
InstructorDept   	VARCHAR(20),
OfficeHours		VARCHAR(20),
Degree    	 	VARCHAR(20),
OfficeLocation    	VARCHAR(20), -- building name
CONSTRAINT instr_pk PRIMARY KEY (InstructorID)
);

CREATE TABLE College (
CollegeID   		INT NOT NULL,
CollegeName		VARCHAR(50),
Dean       		VARCHAR(20),
BuildingLocation	VARCHAR(20), -- building name
CollegePhone		VARCHAR(15),
Budget       		INT,
CONSTRAINT college_pk PRIMARY KEY (CollegeID)
);


CREATE TABLE Department (
DepartmentID		INT NOT NULL,
DepartmentName 	VARCHAR(50),
DepartmentChair	VARCHAR(50),
DepartmentPhone  	VARCHAR(50),
NumOfStudents		INT,
OfficeLocation   	INT, -- room number
CollegeID   		INT NOT NULL,
CONSTRAINT dept_pk PRIMARY KEY (DepartmentID),
CONSTRAINT dept_fk FOREIGN KEY (CollegeID) REFERENCES College (CollegeID)
);

CREATE TABLE Course(
CourseID   		INT NOT NULL,
CourseName   		VARCHAR(50),
Unit   			INT,    
MaxStudents   		INT,
StudentsEnrolled	INT,
InstructorID    		INT NOT NULL,
CONSTRAINT course_pk PRIMARY KEY (CourseID),
CONSTRAINT course_fk FOREIGN KEY (InstructorID) REFERENCES Instructor(InstructorID)
);

CREATE TABLE Offer(
CourseID		INT NOT NULL,
DepartmentID    	INT NOT NULL,
FirstYearOffered     	YEAR, -- the year the course was first offered
Semesters_Offered	VARCHAR(6)
    				CHECK(Semesters_Offered IN ("Spring", "Summer", "Fall", "Winter")),
Sections_Offered    	INT,
CONSTRAINT offer_pk PRIMARY KEY (CourseID, DepartmentID),
CONSTRAINT offer_fk1 FOREIGN KEY (CourseID) REFERENCES Course (CourseID),
CONSTRAINT offer_fk2 FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID)
);

CREATE TABLE Registration (
	StudentID    		INT NOT NULL,
	CourseID    		INT NOT NULL,
	RegistrationDate	DATE,
	Semester    		VARCHAR(6)
   				CHECK(Semester IN ("Spring", "Summer", "Fall", "Winter")),
	FirstRegistrationDate     DATE,
	LastRegistrationDate     DATE,
    CONSTRAINT reg_pk PRIMARY KEY (StudentID, CourseID),
    CONSTRAINT reg_fk1 FOREIGN KEY (StudentID) REFERENCES Student (StudentID),
    CONSTRAINT reg_fk2 FOREIGN KEY (CourseID) REFERENCES Course (CourseID)
);

-- 6b. SQL statements used to load data into our tables

INSERT INTO Student (StudentID, StudentName, Major, Minor, GPA, StudentYear) VALUES
(900000001, "Jerry Seinfeld", "English", "History", 3.5, "Senior"),
(900000002,"George Costanza","Business", null, 2.5, "Senior"),
(900000003, "Rachel Green", "Film", null, 3.1, "Freshman"),
(900000004,"Stephen Yoon","Psychology", "Liberal Arts", 3.3, "Sophomore"),
(900000005,"Alex Martinez","Art","Theater", 3.6, "Junior"),
(900000006,"Mary Burrell","Biology","Psychology", 3.8, "Sophomore"),
(900000007, "Stu Dent", "Art", null, 3.0, "Senior"),
(900000008, "Mordecai Rigby", default, null, 2.0, "Senior");

INSERT INTO Instructor (InstructorID, InstructorName, InstructorDept, OfficeHours, Degree, OfficeLocation) Values
(100000001, "Tea Cher","Biology", null, "Biology","Sci"),
(100000002, "Eric Son","Computer Science ", Wednesday, noon, "Computer Science","Bus"),
(100000003, "Johnny Suh","Business Administration", null, "Business","Bus"),
(100000004, "Chase Cooper", "Science", "Monday, morning", "Biology", "Bio"),
(100000005, "Chris Bridgmen", "English", "Mondays, noon", "English", "Humanities");

INSERT INTO College (CollegeID, CollegeName, Dean, BuildingLocation, CollegePhone, Budget) VALUES
(98, "College of Science and Engineering", "Carmen Domingo", "TH", "415-338-1571", 6541234),
(45, "College of Liberal & Creative Arts", "Andrew Harris", "CA", "415-338-1471", 5555555),
(56, "College of Education", "Cynthia Grutzik", "BH", "415-338-2687", 2957111),
(34, "College of Health & Social Sciences", "Alvin Alvarez", "HSS", "415-338-3326", 3928545),
(64, "College of Business", "Eugene Sivadas", "BUS", "415-338-2138", 42764321),
(25, "College of Ethnic Studies", "Amy Sueyoshi", "EP", "415-338-1693",2363781 ) ;

INSERT INTO Department (DepartmentID, DepartmentName, DepartmentChair,
   					 DepartmentPhone, NumOfStudents, OfficeLocation, CollegeID) VALUES
( 987, "Biology", "Laura Burrus", "415-338-1548", 574, 538, 98),
( 456, "Information Systems", "Lutfus Sayeed", "415-338-2138", 1000, 310, 64),
( 295, "Counseling", "Rebecca Toporek", "415-338-2005", 516, 021, 34),
( 256, "Criminal Justice", "Elizabeth Brown", "415-405-4129", 980, 424, 34),
( 436, "Economics", "Anoshua Chaudhuri", "415-338-2108",786 ,215 , 64),
(460 , "Accounting", "Amy Chang", "415-338-1107",187 ,415 ,64) ;

INSERT INTO Course (CourseID, CourseName, Unit, MaxStudents, StudentsEnrolled, InstructorID) VALUES
( 7894, "Introductory Biology", 4, 25, 20, 100000001),
( 7109, "Introduction to Computer Science", 3, 30, 27, 100000002),
( 7124, "Introduction to Information Systems", 3, 28, 23, 100000002),
( 2432, "Microeconomics",3 ,30 ,28 , 100000003),
( 7562 , "Building Business Applications",3 ,30 ,25 ,100000002 ),
( 2932, "Managerial Accounting", 3, 50, 30, 100000005),
( 8765, "English Literature", 3, 20, 20, 100000005);

INSERT INTO Offer (CourseID, DepartmentID, FirstYearOffered, Semesters_Offered, Sections_offered) VALUES
( 7894, 987, 2009, "Spring", 1),
( 2432, 436, 2013, "Fall", 2),
( 7124, 456, 2019, "Spring", 4),
( 7562 , 456, 2017, "Fall",4 ),
( 2932, 460 ,2020 , "Fall", 5);

INSERT INTO Registration (StudentID, CourseID, RegistrationDate, Semester, FirstRegistrationDate, LastRegistrationDate) VALUES
( 900000001, 7894, "2021-05-15", "Fall", "2021-05-10", "2021-08-10"),
( 900000001, 7124, "2021-05-15", "Fall", "2021-05-10", "2021-08-10"),
( 900000002, 2432, "2021-05-10", "Fall", "2021-05-10", "2021-08-10"),
( 900000003, 7124, "2021-05-13", "Fall", "2021-05-10", "2021-08-10"),
( 900000004, 8765 ,"2021-11-29", "Spring","2021-11-25","2021-01-23"),
( 900000004, 7124 ,"2021-11-29", "Spring","2021-11-25","2021-01-23"),
( 900000005, 7894 , "2021-12-02", "Spring", "2021-11-25", "2022-01-23");
