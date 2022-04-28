-- 6c. Retrieve information from our tables

-- 1. We want to know the GPAs of all senior students. List all senior students in descending GPA order.

SELECT * FROM Student
WHERE StudentYear = "Senior"
ORDER BY GPA DESC;


-- 2. We want to know the ID and name of all students who have registered for an introductory (or introduction) course. Do not show duplicates. 

SELECT Student.StudentID, StudentName
FROM Student, Registration
WHERE Student.StudentID = Registration.StudentID
AND Registration.CourseID IN
(SELECT CourseID FROM Course WHERE CourseName LIKE "Intro%" )
GROUP BY Student.StudentID;

-- 3. We want to know the number of students taught by each professor, including professors that are not currently teaching.

SELECT InstructorName, COUNT(Registration.StudentID) AS "# Students Taught"
FROM
(Instructor LEFT OUTER JOIN Course ON Instructor.InstructorID = Course.InstructorID)
   	 LEFT OUTER JOIN Registration ON Course.CourseID = Registration.CourseID
GROUP BY InstructorName;



-- 4. We want to know the name, ID, and number of courses of instructors that are teaching more than 1 class.

SELECT InstructorName, Instructor.InstructorID, COUNT(CourseID) AS Courses_Taught
FROM Instructor, Course
WHERE Course.InstructorID = Instructor.InstructorID
GROUP BY InstructorID
HAVING Courses_Taught > 1;


-- 5. We want to know the ID, name, and GPA of all senior students with GPAs greater than 3.0, using a view. Sort by descending GPA order.

CREATE VIEW SeniorStudents_V
AS
SELECT * FROM Student
WHERE StudentYear = "Senior";

SELECT StudentID, StudentName, GPA FROM SeniorStudents_V
WHERE GPA >= 3.0
ORDER BY GPA DESC;





-- 6. Display the number of departments in each college. EXCLUDE colleges that do not have departments.

SELECT College.CollegeName, COUNT(DepartmentID)
FROM College RIGHT OUTER JOIN Department
ON College.CollegeID = Department.CollegeID
GROUP BY College.CollegeID;



-- 7. Display course name and course ID of all courses offered in the fall.

SELECT Course.CourseID, Course.CourseName FROM Course, Offer
WHERE Course.CourseID = Offer.CourseID
AND Semesters_Offered = "Fall";



-- 8. We want to know what courses Jerry Seinfeld has registered for using a subquery. 

SELECT CourseID, CourseName FROM Course
WHERE CourseID IN
(SELECT CourseID FROM Registration
WHERE StudentID = 900000001);




-- 9. We want to know the number of students enrolled in Introductory Biology.

SELECT StudentsEnrolled FROM Course
WHERE CourseName = "Introductory Biology";







