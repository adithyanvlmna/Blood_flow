// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:blood_donation_app/Firebase_DB/auth.dart';
import 'package:blood_donation_app/Firebase_DB/crud.dart';
import 'package:blood_donation_app/Model/logined_user.dart';
import 'package:blood_donation_app/Utilities/Alerdialogues/signup_alert.dart';
import 'package:blood_donation_app/Utilities/Enums/signup_enum.dart';
import 'package:blood_donation_app/Utilities/routes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  bool obsureValue = true;
  bool isLoading = false;
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    RegExp emailReg = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return Scaffold(
      backgroundColor: Colors.black,
      body: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: 700,
          width: double.infinity,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(80))),
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                const SizedBox(
                  height: 25,
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    IconButton(
                        onPressed: () {
                          Navigator.pushNamed(context, Routes.loginview);
                        },
                        color: Colors.black,
                        icon: const Icon(Icons.arrow_back)),
                    const SizedBox(
                      width: 85,
                    ),
                    const Text(
                      "Sign Up",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: TextFormField(
                    controller: nameController,
                    keyboardType: TextInputType.emailAddress,
                    cursorColor: Colors.black,
                    style: const TextStyle(color: Colors.black),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Name is required";
                      }

                      return null;
                    },
                    decoration: const InputDecoration(
                        labelText: "Name",
                        labelStyle: TextStyle(color: Colors.black),
                        hintText: "Enter your name",
                        hintStyle: TextStyle(color: Colors.black),
                        errorStyle: TextStyle(color: Colors.red),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: TextFormField(
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    cursorColor: Colors.black,
                    style: const TextStyle(color: Colors.black),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Phone number is required";
                      }

                      return null;
                    },
                    decoration: const InputDecoration(
                        labelText: "Phone",
                        labelStyle: TextStyle(color: Colors.black),
                        hintText: "Enter your number",
                        hintStyle: TextStyle(color: Colors.black),
                        errorStyle: TextStyle(color: Colors.red),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    cursorColor: Colors.black,
                    style: const TextStyle(color: Colors.black),
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
                        labelStyle: TextStyle(color: Colors.black),
                        hintText: "Enter your email",
                        hintStyle: TextStyle(color: Colors.black),
                        errorStyle: TextStyle(color: Colors.red),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: TextFormField(
                    obscureText: obsureValue,
                    controller: passwordController,
                    keyboardType: TextInputType.emailAddress,
                    cursorColor: Colors.black,
                    style: const TextStyle(color: Colors.black),
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
                                : const Icon(Icons.visibility_off_outlined)),
                        suffixIconColor: Colors.black,
                        labelText: "Password",
                        labelStyle: const TextStyle(color: Colors.black),
                        hintText: "Enter your password",
                        hintStyle: const TextStyle(color: Colors.black),
                        errorStyle: const TextStyle(color: Colors.red),
                        border: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
                        focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black))),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 100, right: 100, top: 50),
                  child: MaterialButton(
                    onPressed: () async {
                      final pref = await SharedPreferences.getInstance();
                      if (formKey.currentState!.validate()) {
                        setState(() {
                          isLoading = true;
                        });
                        var user = LoginedUser(
                            name: nameController.text.trim(),
                            phone: phoneController.text.trim(),
                            email: emailController.text.trim());
                        CollectionReference users;
                        DocumentReference docRef;
                        String documentId;
                        await Authentication.signupError(
                                emailController.text.trim(),
                                passwordController.text.trim())
                            .then((error) {
                          if (error == SignupEnum.weakPassword) {
                            singupAlert(
                                title: "Weak password",
                                content:
                                    "Given password is too weak use a secure one",
                                context: context);
                          } else if (error == SignupEnum.alreadyInUse) {
                            singupAlert(
                                title: "User exists",
                                content:
                                    "The given email already in use try anotherone",
                                context: context,
                                action: "Login ?");
                          } else if (error == SignupEnum.other) {
                            singupAlert(
                                title: "Oopss!",
                                content:
                                    "something went wrong,try after sometimes");
                          } else {
                            print("ok...................");
                            CollectionOperations.createCollection("Logineduser")
                                .then((value) {
                              users = value;
                              CollectionOperations.addDocumentToCollection(
                                      users, user.toMap())
                                  .then((data) {
                                docRef = data;
                                documentId = docRef.id;
                                pref.setString("DoccId", documentId);
                                pref.setString("Phone", phoneController.text);
                                print(documentId);
                                Navigator.pushNamed(context, Routes.homeview);
                                emailController.clear();
                                passwordController.clear();
                                phoneController.clear();
                                nameController.clear();
                              });
                            });
                            print("Success");
                          }
                        });
                        setState(() {
                          isLoading = false;
                        });
                      }
                    },
                    color: Colors.black,
                    minWidth: 150,
                    height: 50,
                    textColor: Colors.white,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25),
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10))),
                    child: isLoading == false
                        ? const Text(
                            "Sign Up",
                            style: TextStyle(fontSize: 18),
                          )
                        : const CircularProgressIndicator(
                            color: Colors.white,
                          ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
