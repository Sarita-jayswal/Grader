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
  getContainer({String? name, IconData? icon, Function()? ontap}) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
          alignment: Alignment.center,
          height: 100,
          width: 100,
          color: Colors.green.withOpacity(0.7),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Icon(
                    icon,
                    size: 40,
                  ),
                ),
                Center(
                  child: Text(
                    name!,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        label: Text("Log Out"),
        icon: Icon(Icons.logout),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => LoginPage()));
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
                CircleAvatar(radius: 30, backgroundImage: AssetImage('assets/teacher.png')),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "Welcome, Sujata Sapkota",
                  style: TextStyle(color: Colors.green),
                )
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                getContainer(
                  icon: Icons.school_outlined,
                  name: "Students",
                  ontap: () {
                    Navigator.push(context, MaterialPageRoute(builder: ((context) => AddStudentPage())));
                  },
                ),
                SizedBox(width: 20),
                getContainer(
                  icon: Icons.calendar_month_outlined,
                  name: "Attendance",
                  ontap: () {
                    Navigator.push(context, MaterialPageRoute(builder: ((context) => AddAttendancePage())));
                  },
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                getContainer(
                  icon: Icons.assignment_outlined,
                  name: "Course",
                  ontap: () {
                    Navigator.push(context, MaterialPageRoute(builder: ((context) => AddCoursePage())));
                  },
                ),
                SizedBox(
                  width: 20,
                ),
                getContainer(
                  icon: Icons.grade_outlined,
                  name: "Grades",
                  ontap: () {
                    Navigator.push(context, MaterialPageRoute(builder: ((context) => GradesCalculation())));
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
