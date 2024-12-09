// ignore_for_file: use_build_context_synchronously

import 'package:blood_donation_app/Firebase_DB/auth.dart';
import 'package:blood_donation_app/Utilities/Alerdialogues/login_alert.dart';
import 'package:blood_donation_app/Utilities/Enums/login_enum.dart';
import 'package:blood_donation_app/Utilities/routes.dart';
import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool isLoading = false;
  bool obsureValue = true;
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    RegExp emailReg = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return Scaffold(
        body: Container(
      height: double.infinity,
      width: double.infinity,
      color: Colors.white,
      child: Stack(
        children: [
          Positioned(
            top: 140,
            child: Container(width: 400, height: 200, color: Colors.black),
          ),
          Positioned(
            top: 260,
            right: 0.2,
            child: Container(
              width: 400,
              height: 700,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.only(topRight: Radius.circular(80))),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const SizedBox(
                      height: 80,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 30.0, right: 22.0),
                      child: TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        cursorColor: const Color.fromARGB(255, 44, 44, 44),
                        style: const TextStyle(
                            color: Color.fromARGB(255, 44, 44, 44)),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Email is required";
                          }
                          if (!emailReg.hasMatch(value)) {
                            return "Invalid email format";
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                            labelText: "Email",
                            labelStyle: TextStyle(
                                color: Color.fromARGB(255, 44, 44, 44)),
                            hintText: "Enter your email",
                            hintStyle: TextStyle(
                                color: Color.fromARGB(255, 44, 44, 44)),
                            errorStyle: TextStyle(color: Colors.red),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 44, 44, 44))),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 44, 44, 44)))),
                      ),
                    ),
                    
                    const SizedBox(
                      height: 50,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 30, right: 22),
                      child: TextFormField(
                        obscureText: obsureValue,
                        controller: passwordController,
                        keyboardType: TextInputType.emailAddress,
                        cursorColor: Colors.black,
                        style: const TextStyle(
                            color: Color.fromARGB(255, 44, 44, 44)),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "password is required";
                          }

                          return null;
                        },
                        decoration: InputDecoration(
                            suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    obsureValue = !obsureValue;
                                  });
                                },
                                icon: obsureValue != false
                                    ? const Icon(Icons.visibility_rounded)
                                    : const Icon(
                                        Icons.visibility_off_outlined)),
                            suffixIconColor: Colors.black,
                            labelText: "Password",
                            labelStyle: const TextStyle(
                                color: Color.fromARGB(255, 44, 44, 44)),
                            hintText: "Enter your password",
                            hintStyle: const TextStyle(
                                color: Color.fromARGB(255, 44, 44, 44)),
                            errorStyle: const TextStyle(color: Colors.red),
                            border: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 44, 44, 44))),
                            focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 44, 44, 44)))),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 19.0, top: 8.0),
                        child: TextButton(
                            onPressed: () {},
                            child: const Text(
                              "Forgot password ?",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 44, 44, 44),
                                  fontSize: 15),
                            )),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 50.0),
                      child: MaterialButton(
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              setState(() {
                                isLoading = true;
                              });
                              Authentication.loginError(
                                      emailController.text.trim(),
                                      passwordController.text.trim())
                                  .then((error) {
                                if (error == LoginEnum.userNotFound) {
                                  loginAlert(
                                      title: "Invalid Inputs",
                                      content:
                                          "The given email or password is invalid",
                                      context: context);
                                } else {
                                  Navigator.pushNamed(context, Routes.homeview);
                                }
                                setState(() {
                                  isLoading = false;
                                });
                              });
                            }
                          },
                          color: const Color.fromARGB(255, 44, 44, 44),
                          minWidth: 200,
                          height: 50,
                          textColor: Colors.white,
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(25),
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10))),
                          child: isLoading == false
                              ? const Text(
                                  "Sign in",
                                  style: TextStyle(fontSize: 20),
                                )
                              : const CircularProgressIndicator(
                                  color: Colors.white,
                                )),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            right: 13.0,
            top: 510.0,
            child: TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, Routes.signupview);
                },
                child: const Text(
                  "Create an account",
                  style: TextStyle(
                      color: Color.fromARGB(255, 44, 44, 44), fontSize: 15),
                )),
          ),
          const Positioned(
              right: 40,
              top: 65,
              child: CircleAvatar(
                backgroundImage: AssetImage("assets/images/blood_icon.png"),
                radius: 70,
                backgroundColor: Colors.red,
              )),
          const Positioned(
              top: 90,
              left: 30,
              child: Text(
                "Blood",
                style: TextStyle(
                    color: Color.fromARGB(255, 44, 44, 44),
                    fontSize: 40,
                    fontWeight: FontWeight.bold),
              )),
          const Positioned(
              top: 140,
              left: 30,
              child: Text(
                "flow",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              )),
        ],
      ),
    ));
  }
}
