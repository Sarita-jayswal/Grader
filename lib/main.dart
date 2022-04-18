// main.dart

import 'package:flutter/material.dart';

import 'package:hive_flutter/hive_flutter.dart';

import 'package:test_project/screens/front_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  // await Hive.deleteBoxFromDisk('students_box');
  await Hive.openBox('students_box');
  await Hive.openBox('teachers_box');
  await Hive.openBox('course_box');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Students Information',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const LoginPage(),
    );
  }
}
