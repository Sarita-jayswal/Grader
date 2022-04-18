import 'package:flutter/material.dart';
import 'package:test_project/screens/add_attendance.dart';
import 'package:test_project/screens/add_course.dart';
import 'package:test_project/screens/add_student.dart';
import 'package:test_project/screens/grades_calculation.dart';

import 'front_screen.dart';

class TeacherHomePage extends StatefulWidget {
  const TeacherHomePage({Key? key}) : super(key: key);

  @override
  State<TeacherHomePage> createState() => _TeacherHomePageState();
}

class _TeacherHomePageState extends State<TeacherHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        label: Text("Log Out"),
        icon: Icon(Icons.logout),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => LoginPage()));
        },
      ),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.green),
        title: Text("Teacher Dashboard"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage('assets/teacher.png')),
                Text(
                  "Welcome, Sujata Sapkota",
                  style: TextStyle(color: Colors.green),
                )
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Card(
                    color: Colors.green.withOpacity(0.5),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 20),
                      child: Column(
                        children: [
                          IconButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: ((context) =>
                                            AddStudentPage())));
                              },
                              icon: Icon(
                                Icons.school_outlined,
                                size: 40,
                              )),
                          Text(
                            "Students",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    )),
                SizedBox(width: 20),
                Card(
                    color: Colors.green.withOpacity(0.5),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 20),
                      child: Column(
                        children: [
                          IconButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: ((context) =>
                                            AddAttendancePage())));
                              },
                              icon: Icon(
                                Icons.calendar_month_outlined,
                                size: 40,
                              )),
                          Text(
                            "Attendance",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    )),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Card(
                    color: Colors.green.withOpacity(0.5),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 20),
                      child: Column(
                        children: [
                          IconButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: ((context) =>
                                            AddCoursePage())));
                              },
                              icon: Icon(
                                Icons.assignment_outlined,
                                size: 40,
                              )),
                          Text(
                            "Course",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    )),
                SizedBox(
                  width: 40,
                ),
                Card(
                    color: Colors.green.withOpacity(0.5),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 20),
                      child: Column(
                        children: [
                          IconButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: ((context) =>
                                            GradesCalculation())));
                              },
                              icon: Icon(
                                Icons.grade_outlined,
                                size: 40,
                              )),
                          Text(
                            "Grades",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
