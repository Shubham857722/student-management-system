CREATE DATABASE StudentManagement;
USE StudentManagement;
-- Students table
CREATE TABLE students (
    student_id INT PRIMARY KEY,
    fname VARCHAR(50),
    lname VARCHAR(50),
    dob DATE,
    email VARCHAR(100)
);

-- Courses table
CREATE TABLE courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(100),
    credits INT
);

-- Instructors table
CREATE TABLE instructors (
    instructor_id INT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100)
);

-- Course-Instructors table (many-to-many relation)
CREATE TABLE course_instructors (
    course_id INT,
    instructor_id INT,
    PRIMARY KEY (course_id, instructor_id),
    FOREIGN KEY (course_id) REFERENCES courses(course_id),
    FOREIGN KEY (instructor_id) REFERENCES instructors(instructor_id)
);


-- Registrations table (students register for courses)
CREATE TABLE registrations (
    student_id INT,
    course_id INT,
    registration_date DATE,
     primary key (student_id,course_id) ,
     foreign key(student_id) REFERENCES   students(student_id),
     foreign key (course_id) references   courses(course_id)
     
);

## 📥 3. Insert Sample Data-- 
use StudentManagement;
 -- courses
insert into  courses (course_id,course_name,credits)
values(101,'Database Systems',4),(102,'Computer Networks',5),(103,'Operating Systems',6),(104,'Web programming',4);



-- Instructors


insert into Instructors(instructor_id,name,email)
values(201,'Anand Kumar','Anande@example.gmail.com'),(202,'Dr. Vikas Divyakriti','DivyakritiVikas@gmail.com'),(203,'Dr. Mehta','MehtaKumar@fgmail.com'),(204,'Prof. Nair', 'nair@example.com');


#----------------------------------
select * from courses;
select * from Instructors;
-- Course-Instructor Mapping

-- Course-Instructor Mapping
insert into course_instructors(course_id,instructor_id)
values(101,201),(102,202),(103,203),(104,204);

-- Registrations
select * from  students;
insert into Registrations(student_id,course_id,registration_date)
values(1,101,'2025-05-01'),(2,102,'2025-05-02'),(3,103,'2025-05-03'),(4,104,'2025-05-05');





#a. List all students with their registered courses:
select fname,course_name,registration_date from students
inner join registrations on  registrations.student_id=students.student_id

inner join  courses on courses.course_id=registrations.course_id;


  
select * from   courses;
#b. Show which instructor is teaching which course:
select courses.course_name,instructors.name   from courses
inner join course_instructors  on  courses.course_id =course_instructors.course_id
inner join  instructors on   course_instructors.instructor_id=instructors.instructor_id;


select courses.course_name,instructors.name   from courses
inner join  course_instructors on  course_instructors.course_id=courses.course_id
inner join   instructors  on  instructors.instructor_id=course_instructors.instructor_id;


--  c. Number of students registered per course:

select courses.course_name, count(registrations.student_id) from courses
left join  registrations on  registrations.course_id=courses.course_id
group by  courses.course_name;



select fname, lname from  students
where student_id not in (
  select student_id from  registrations
);





