import 'dart:developer';

import 'package:daily_diary/service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool status = false;
  bool obscureStatus = true;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 237, 236, 231),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(0, deviceHeight/6, 0, 0),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 25, horizontal: 25),
                  decoration: BoxDecoration(
                      color: Colors.white, borderRadius: BorderRadius.circular(25)),
                  height: MediaQuery.of(context).size.height*2/3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Register',
                        style: TextStyle(fontSize: 20),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'E-mail',
                            style: TextStyle(fontSize: 20),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextField(
                            keyboardType: TextInputType.emailAddress,
                            controller: emailController,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                hintText: 'Enter your e-mail'),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Password',
                            style: TextStyle(fontSize: 20),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextField(
                            controller: passwordController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              hintText: 'Enter your password',
                            ),
                            obscureText: obscureStatus,
                          ),
                          const SizedBox(height: 10,),
                          const Text(
                            'Confirm Password',
                            style: TextStyle(fontSize: 20),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextField(
                            controller: confirmPasswordController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              hintText: 'Confirm password',
                            ),
                            obscureText: obscureStatus,
                          ),
                          const SizedBox(height: 10,),
                          Row(
                            children: [
                              FlutterSwitch(
                                  width: 50,
                                  height: 25,
                                  value: status,
                                  onToggle: (val) {
                                    setState(() {
                                      status = val;
                                      obscureStatus = !val;
                                    });
                                  }),
                              const SizedBox(
                                width: 15,
                              ),
                              const Text('Show Password')
                            ],
                          ),
                        ],
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(minimumSize: Size(250, 35)),
                          onPressed: () async {
                            bool isEmail = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(emailController.text);
                            if(!isEmail){
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Enter valid email')));
                            }
                            else{
                              if(passwordController.text == confirmPasswordController.text){
                                if(passwordController.text.length >=6){
                                    await context.read<AuthenticationService>().signUp(
                                    email: emailController.text,
                                    password: passwordController.text
                                  );
                                  Navigator.pushNamed(context, '/authentication_wrapper');
                                }
                                else{
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Password must be of minimum 6 digits')));
                                }
                              }
                              else{
                                final snackBar = SnackBar(content: const Text('Enter same password in Confirm Password field'));
                                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                              }
                            }
                            
                            
                          },
                          child: Text('Register')),
                    ],
                  ),
                ),
              ),
              Padding(
                padding:  EdgeInsets.fromLTRB(0, (deviceHeight/6)-50, 0, 0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Already have an account'),
                    const SizedBox(width: 10,),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Text('Login',style: TextStyle(color: Colors.blue,fontSize: 16),)
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
