import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class GradesCalculation extends StatefulWidget {
  final TextEditingController? controller;

  const GradesCalculation({Key? key, this.controller}) : super(key: key);

  @override
  State<GradesCalculation> createState() => _GradesCalculationState();
}

class _GradesCalculationState extends State<GradesCalculation> {
  @override
  void initState() {
    super.initState();
    _getStudent();
  }

  bool _isLoading = true;

  List student = [];
  final studentbox = Hive.box('students_box');

  void _getStudent() {
    setState(() {
      _isLoading = true;
    });
    final data = studentbox.keys.map((key) {
      final value = studentbox.get(key);
      return {
        "key": key,
        "name": value["name"],
        "rollno": value['rollno'],
        "email": value['email'],
        "grade": value['grade'] ?? "",
      };
    }).toList();

    setState(() {
      var _items = data.reversed.toList();
      if (_items.isNotEmpty) {
        student.addAll(_items);
        selectedStudent = student[0];
      }
      print(_items);
      _isLoading = false;
    });
  }

  Future<void> _updateItem(int itemKey, Map<String, dynamic> item) async {
    await studentbox.put(itemKey, item);
  }

  Map<String, dynamic>? selectedStudent;

  @override
  Widget build(BuildContext context) {
    final marks1 = TextEditingController();
    final marks2 = TextEditingController();
    final marks3 = TextEditingController();
    final marks4 = TextEditingController();
    final tot = TextEditingController();

    final avg = TextEditingController();
    final grade = TextEditingController();

  

    int result;
    double average;

    int sum;

    return Scaffold(
      appBar: AppBar(title: Text("Grades")),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : student.length == 0
              ? Center(
                  child: Text("No Student found"),
                )
              : SingleChildScrollView(
                child: Column(
                    children: [
                      SizedBox(
                        height: 40,
                      ),
                      Center(child: Text("Please select the student"),),
                      Container(
                        padding: const EdgeInsets.all(8.0),margin: EdgeInsets.symmetric(horizontal: 50),
                        child: DropdownButtonFormField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                  const Radius.circular(10.0),
                                ),
                              ),
                              filled: true,
                              hintStyle: TextStyle(color: Colors.grey[800]),
                              hintText: "Name",
                              fillColor: Colors.white),
                          hint: Text('Please choose a Student'),
                          style: TextStyle(color: Colors.black),
                          value: selectedStudent,
                          onChanged: (newValue) {
                            setState(() {
                              selectedStudent = newValue as Map<String, dynamic>;
                              print(selectedStudent);
                            });
                          },
                          items: student.map((std) {
                            return DropdownMenuItem(
                              child: new Text(std['name']),
                              value: std,
                            );
                          }).toList(),
                        ),
                      ),
              
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        margin: EdgeInsets.all(15),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.6),
                              spreadRadius: 8,
                              blurRadius: 6,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Column(
                            children: [
                              Text(
                                "Enter Marks",
                                style: TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.bold),
                              ),
                              Column(
                                children: [
                                  Container(
                                    height: 30,
                                    width: MediaQuery.of(context).size.width * .6,
                                    margin: EdgeInsets.all(8),
                                    child: TextField(
                                      keyboardType: TextInputType.number,
                                      controller: marks1,
                                      
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.all(8),
                                          labelText: "Enter the obtained Maths marks",
                                          labelStyle: TextStyle(fontSize: 10, color: Colors.grey),
                                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.all(8),
                                    height: 30,
                                    width: MediaQuery.of(context).size.width * .6,
                                    child: TextField(
                                      keyboardType: TextInputType.number,
                                      controller: marks2,
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.all(8),
              
                                          labelText: "Enter the obtained Nepali marks",
                                          labelStyle: TextStyle(fontSize: 10, color: Colors.grey),
                                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.all(8),
                                    height: 30,
                                    width: MediaQuery.of(context).size.width * .6,
                                    child: TextField(
                                      keyboardType: TextInputType.number,
                                      controller: marks3,
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.all(8),
              
                                          labelText: "Enter the obtained Science marks",
                                          labelStyle: TextStyle(fontSize: 10, color: Colors.grey),
                                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.all(8),
                                    height: 40,
                                    width: MediaQuery.of(context).size.width * .6,
                                    child: TextField(
                                      keyboardType: TextInputType.number,
                                      controller: marks4,
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.all(8),
              
                                          hintText: "Enter the total Present Days",
                                          hintMaxLines: 2,
                                          hintStyle: TextStyle(fontSize: 10, color: Colors.grey),
                                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Total:",
                                        style: TextStyle(color: Colors.grey, fontSize: 14, fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      SizedBox(
                                        height: 40,
                                        width: 80,
                                        child: TextField(
                                          controller: tot,
                                          decoration: InputDecoration(
                                              labelText: "Total",
                                              labelStyle: TextStyle(fontSize: 10, color: Colors.grey.shade400),
                                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "Average:",
                                        style: TextStyle(color: Colors.grey, fontSize: 14, fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      SizedBox(
                                        height: 40,
                                        width: 80,
                                        child: TextField(
                                          controller: avg,
                                          decoration: InputDecoration(
                                              labelText: "Average",
                                              labelStyle: TextStyle(fontSize: 10, color: Colors.grey.shade400),
                                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () async {
                          sum = int.parse(marks1.text) + int.parse(marks2.text) + int.parse(marks3.text) + int.parse(marks4.text);
                          result = sum;
                          tot.text = result.toString();
              
                          average = result / 4;
              
                          avg.text = average.toString();
              
                          if (average > 90 || average == 90) {
                            grade.text = "A+ (Congratulations!! Your Grade is 4.0) Student Performance: Outstanding";
                          } else if (average > 80 || average == 80 && average < 90) {
                            grade.text = "A (Congratulations!! Your Grade is 3.6) Student Performance: Excellent";
                          } else if (average > 70 || average == 70 && average < 80) {
                            grade.text = "B+ (Congratulations!! Your Grade is 3.2) Student Performance: Very Good";
                          } else if (average > 60 || average == 60 && average < 70) {
                            grade.text = "B (Congratulations!! Your Grade is 2.8) Student Performance:  Good";
                          } else if (average > 50 || average == 50 && average < 60) {
                            grade.text = "C+ (Your Grade is 2.4. Improve More) Student Performance: Satisfactory";
                          } else if (average > 40 || average == 40 && average < 50) {
                            grade.text = "C ( Your Grade is 2.0, Improve) Student Performance: Acceptable";
                          } else if (average > 35 || average == 35 && average < 40) {
                            grade.text = "D (Your Grade is 1.6) Student Performance: Poor";
                          } else if (average < 35) {
                            grade.text = "NG (Fail) Student Performance: Unacceptable";
                          }
              
                          print(selectedStudent!["key"]);
                          print(grade.text);
              
                          await _updateItem(selectedStudent!["key"], {
                            'name': selectedStudent!["name"].trim(),
                            'rollno': selectedStudent!["rollno"].trim(),
                            'email': selectedStudent!["email"].trim(),
                            'grade': grade.text.trim(),
                          });
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 40,
                          width: 150,
                          decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(20)),
                          child: Text(
                            "Calculate Grade",
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(20),
                        child: TextField(
                          controller: grade,
                          decoration: InputDecoration(
                            labelText: "Grade",
                            labelStyle: TextStyle(fontSize: 15, color: Colors.grey.shade400),
                            // border: OutlineInputBorder(
                            //     borderRadius: BorderRadius.circular(10))
                          ),
                        ),
                      ),
                      // DropdownButton(items: dropdownitems, onChanged:(){}
                    ],
                  ),
              ),
    );
  }
}
