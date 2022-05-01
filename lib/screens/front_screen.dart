import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:test_project/screens/adminhomepage.dart';
import 'package:test_project/screens/teacherhomepage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
 final TextEditingController _emailController = TextEditingController();
 final TextEditingController _passwordController = TextEditingController();

  String? validatePassword(String value) {
    if (value.isEmpty) {
      return "* Required";
    } else if (value.length < 6) {
      return "Password should be atleast 6 characters";
    } else if (value.length > 15) {
      return "Password should not be greater than 15 characters";
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Form(
          autovalidateMode: AutovalidateMode.always,
          key: formkey,
          child: Column(
            children: <Widget>[
              const SizedBox(height: 30),
              const Text('LOGIN',
                  style: TextStyle(
                      color: Colors.green,
                      fontSize: 25,
                      fontWeight: FontWeight.bold)),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Center(
                  child: Container(
                      width: 200,
                      height: 150,
                      child: Image.asset('assets/admin.png')),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Email',
                        hintText: 'Enter valid email id as abc@gmail.com',
                        hintStyle: TextStyle(fontSize: 10)),
                    validator: MultiValidator([
                      RequiredValidator(errorText: "* Required"),
                      EmailValidator(errorText: "Enter valid email id"),
                    ])),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 15, bottom: 0),
                child: TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                        errorStyle: TextStyle(fontSize: 8),
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                        hintText: 'Enter secure password',
                        hintStyle: TextStyle(fontSize: 10)),
                    validator: MultiValidator([
                      RequiredValidator(errorText: "* Required"),
                      MinLengthValidator(
                        6,
                        errorText: "Password should be atleast 6 characters",
                      ),
                      // MaxLengthValidator(15,
                      //     errorText:
                      //         "Password should not be greater than 15 characters")
                    ])
                    //validatePassword,        //Function to check validation
                    ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 50,
                width: 100,
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(20)),
                child: TextButton(
                  onPressed: () async {
                     Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => TeacherHomePage()));
                    // if (formkey.currentState!.validate()) {
                    //   if (_emailController.text == "sarita@gmail.com" &&
                    //       _passwordController.text == "12345678") {
                    //     Navigator.push(context,
                    //         MaterialPageRoute(builder: (_) => AdminHomePage()));
                    //   }
                    //   if (_emailController.text == "sujata@gmail.com" &&
                    //       _passwordController.text == "sujata123") {
                    //     Navigator.push(
                    //         context,
                    //         MaterialPageRoute(
                    //             builder: (_) => TeacherHomePage()));
                    //   } 
                    //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    //         content: Text("Gmail/Password did not match")));
                      
                    // } 
                  },
                  child: Text(
                    'Login',
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
