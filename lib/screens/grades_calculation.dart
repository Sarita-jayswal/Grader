import 'dart:ui';

import 'package:flutter/material.dart';

class GradesCalculation extends StatelessWidget {
  final TextEditingController? controller;

  const GradesCalculation({Key? key, this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final name = TextEditingController();
    final marks1 = TextEditingController();
    final marks2 = TextEditingController();
    final marks3 = TextEditingController();
    final marks4 = TextEditingController();
    final tot = TextEditingController();

    final avg = TextEditingController();
    final grade = TextEditingController();

    // getItemAndNavigate(BuildContext context) {
    //   Navigator.push(
    //       context,
    //       MaterialPageRoute(
    //           builder: (context) => SecondScreen(
    //               nameHolder: name.text,
    //               marks1Holder: marks1.text,
    //               marks2Holder: marks2.text,
    //               marks3Holder: marks3.text,
    //               marks4Holder: marks4.text,
    //               totHolder: tot.text,
    //               avgHolder: avg.text,
    //               gradeHolder: grade.text)));
    // }

    int result;
    double average;

    int sum;

    return Scaffold(
      appBar: AppBar(title: Text("Grades")),
      body: Column(
        children: [
          Row(
            children: [
              Text(
                "Select Student",
                style:
                    TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
              ),
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.arrow_drop_down_circle,
                    color: Colors.green,
                  ))
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            height: 150,
            color: Color.fromARGB(255, 155, 221, 157),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Column(
                children: [
                  Text(
                    "Enter Marks",
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        height: 30,
                        width: 80,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          controller: marks1,
                          decoration: InputDecoration(
                              labelText: "Math",
                              labelStyle:
                                  TextStyle(fontSize: 10, color: Colors.grey),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20))),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                        width: 80,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          controller: marks2,
                          decoration: InputDecoration(
                              labelText: "Nepali",
                              labelStyle:
                                  TextStyle(fontSize: 10, color: Colors.grey),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20))),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                        width: 80,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          controller: marks3,
                          decoration: InputDecoration(
                              labelText: "science",
                              labelStyle:
                                  TextStyle(fontSize: 10, color: Colors.grey),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20))),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                        width: 80,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          controller: marks4,
                          decoration: InputDecoration(
                              hintText: "Attendance",
                              hintMaxLines: 2,
                              hintStyle:
                                  TextStyle(fontSize: 10, color: Colors.grey),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20))),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text(
                        "Total:",
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
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
                              labelStyle: TextStyle(
                                  fontSize: 10, color: Colors.grey.shade400),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10))),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Average:",
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
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
                              labelStyle: TextStyle(
                                  fontSize: 10, color: Colors.grey.shade400),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10))),
                        ),
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
            onTap: () {
              sum = int.parse(marks1.text) +
                  int.parse(marks2.text) +
                  int.parse(marks3.text) +
                  int.parse(marks4.text);
              result = sum;
              tot.text = result.toString();

              average = result / 4;

              avg.text = average.toString();

              if (average > 90 || average == 90) {
                grade.text =
                    "A+ (Congratulations!! Your Grade is 4.0) Student Performance: Outstanding";
              } else if (average > 80 || average == 80 && average < 90) {
                grade.text =
                    "A (Congratulations!! Your Grade is 3.6) Student Performance: Excellent";
              } else if (average > 70 || average == 70 && average < 80) {
                grade.text =
                    "B+ (Congratulations!! Your Grade is 3.2) Student Performance: Very Good";
              } else if (average > 60 || average == 60 && average < 70) {
                grade.text =
                    "B (Congratulations!! Your Grade is 2.8) Student Performance:  Good";
              } else if (average > 50 || average == 50 && average < 60) {
                grade.text =
                    "C+ (Your Grade is 2.4. Improve More) Student Performance: Satisfactory";
              } else if (average > 40 || average == 40 && average < 50) {
                grade.text =
                    "C ( Your Grade is 2.0, Improve) Student Performance: Acceptable";
              } else if (average > 35 || average == 35 && average < 40) {
                grade.text = "D (Your Grade is 1.6) Student Performance: Poor";
              } else if (average < 35) {
                grade.text = "NG (Fail) Student Performance: Unacceptable";
              }
            },
            child: Container(
              alignment: Alignment.center,
              height: 40,
              width: 150,
              decoration: BoxDecoration(
                  color: Colors.green, borderRadius: BorderRadius.circular(20)),
              child: Text(
                "Calculate Grade",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12),
              ),
            ),
          ),
          TextField(
            controller: grade,
            decoration: InputDecoration(
              labelText: "Grade",
              labelStyle: TextStyle(fontSize: 15, color: Colors.grey.shade400),
              // border: OutlineInputBorder(
              //     borderRadius: BorderRadius.circular(10))
            ),
          ),
          // DropdownButton(items: dropdownitems, onChanged:(){}
        ],
      ),
    );
  }
}
