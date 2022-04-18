import 'package:flutter/material.dart';
import 'package:test_project/screens/add_student.dart';
import 'package:test_project/screens/add_teacher.dart';
import 'package:test_project/screens/front_screen.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({Key? key}) : super(key: key);

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ADMIN"),
        centerTitle: true,
      ),
      body: Center(
          child: Text(
        'Admin Dashboard',
        style: TextStyle(fontSize: 20.0),
      )),
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text("Admin"),
              accountEmail: Text("admin@gmail.com"),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.blue,
                child: Text(
                  "A",
                  style: TextStyle(fontSize: 40.0),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.school),
              title: Text("Students"),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => AddStudentPage())));
              },
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text("Teachers"),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => AddTeacherPage())));
              },
            ),
            ListTile(
              leading: Icon(Icons.contacts),
              title: Text("Contact Us"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text("Log Out"),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: ((context) => LoginPage())));
              },
            ),
          ],
        ),
      ),
    );
  }
}
