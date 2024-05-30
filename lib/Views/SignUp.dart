import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:officeapp/Controllers/NavBarController.dart';
import '../Controllers/SignUpController.dart';
import 'package:image_picker/image_picker.dart';

class SingUp extends StatelessWidget {
  final singUpController = Get.put(SingUpController());
  final navBarController = Get.put(NavBarController());

  final _formkey = GlobalKey<FormState>();

  Future selectImage() async {
    final ImagePicker _picker = ImagePicker();

    final pickedImage =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    if (pickedImage != null) {
      singUpController.profile_pic.value = XFile(pickedImage.path);
    } else {
      print("There is no any selected image");
    }
  }

  @override
  Widget build(BuildContext context) {
    final Height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    final Width = MediaQuery.of(context).size.width;

    return Scaffold(
        // backgroundColor: Colors.lightBlue,
        body: SingleChildScrollView(
            child: GetX<SingUpController>(
      builder: (controller) => Container(
          padding: const EdgeInsets.only(top: 60, left: 20, right: 20),
          // height: Height,
          // width: Width,
          alignment: Alignment.topCenter,
          child: Form(
              key: _formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.task_rounded,
                    size: 100,
                    color: HexColor("#30a6d6"),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'OfficeAPP',
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 50,
                        fontWeight: FontWeight.w800,
                        color: HexColor('#4d4d4d')),
                  ),
                  Column(
                    children: [
                      singUpController.profile_pic.value != null
                          ? Container(
                              height: 150,
                              width: 150,
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(100.0),
                              ),
                              child: InkWell(
                                  onTap: () {
                                    selectImage();
                                  },
                                  child: ClipOval(
                                    child: Image.file(
                                      File(singUpController
                                          .profile_pic.value!.path),
                                      fit: BoxFit.cover,
                                      width: 100.0, // specify the width
                                      height: 100.0, // specify the height
                                    ),
                                  )

                                  // Image.file(

                                  //   File(
                                  //       singUpController.profile_pic.value!.path),
                                  // ),
                                  ))
                          : Container(
                              height: 150,
                              width: 150,
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(100.0),
                              ),
                              child: InkWell(
                                onTap: () {
                                  selectImage();
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10, top: 10, bottom: 10),
                                  child: Icon(
                                    Icons.image_search,
                                    color: HexColor("#4d4d4d"),
                                    size: 50,
                                  ),
                                ),
                              )),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: singUpController.nameController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please Enter user name";
                            }

                            return null;
                          },
                          decoration: const InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50.0)),
                              borderSide: BorderSide(
                                color: Color.fromARGB(255, 158, 158, 158),
                                style: BorderStyle.solid,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50.0)),
                              borderSide: BorderSide(
                                color: Color.fromARGB(255, 158, 158, 158),
                                style: BorderStyle.none,
                              ),
                            ),
                            labelText: 'User name',
                            hintText: 'User name',
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: singUpController.fullNameController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please Enter Name";
                            }

                            return null;
                          },
                          decoration: const InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50.0)),
                              borderSide: BorderSide(
                                color: Color.fromARGB(255, 158, 158, 158),
                                style: BorderStyle.solid,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50.0)),
                              borderSide: BorderSide(
                                color: Color.fromARGB(255, 158, 158, 158),
                                style: BorderStyle.none,
                              ),
                            ),
                            labelText: 'Name',
                            hintText: 'Name',
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: singUpController.designationController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please Enter Designation";
                            }

                            return null;
                          },
                          decoration: const InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50.0)),
                              borderSide: BorderSide(
                                color: Color.fromARGB(255, 158, 158, 158),
                                style: BorderStyle.solid,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50.0)),
                              borderSide: BorderSide(
                                color: Color.fromARGB(255, 158, 158, 158),
                                style: BorderStyle.none,
                              ),
                            ),
                            labelText: 'Designation',
                            hintText: 'Designation',
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: singUpController.emailController,
                          autofillHints: const [AutofillHints.email],
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please Enter email";
                            }
                            if (!RegExp(
                                    "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                .hasMatch(value)) {
                              return "Please Enter valid email";
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50.0)),
                              borderSide: BorderSide(
                                color: Color.fromARGB(255, 158, 158, 158),
                                style: BorderStyle.solid,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50.0)),
                              borderSide: BorderSide(
                                color: Color.fromARGB(255, 158, 158, 158),
                                style: BorderStyle.none,
                              ),
                            ),
                            labelText: 'Email',
                            hintText: 'Email',
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: singUpController.phoneNoController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please Enter Phone Number";
                            }

                            return null;
                          },
                          decoration: const InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50.0)),
                              borderSide: BorderSide(
                                color: Color.fromARGB(255, 158, 158, 158),
                                style: BorderStyle.solid,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50.0)),
                              borderSide: BorderSide(
                                color: Color.fromARGB(255, 158, 158, 158),
                                style: BorderStyle.none,
                              ),
                            ),
                            labelText: 'Phone Number',
                            hintText: 'Phone Number',
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: singUpController.passwordController,
                          autofillHints: const [AutofillHints.password],
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please Enter Password";
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50.0)),
                              borderSide: BorderSide(
                                color: Color.fromARGB(255, 158, 158, 158),
                                style: BorderStyle.solid,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50.0)),
                              borderSide: BorderSide(
                                color: Color.fromARGB(255, 158, 158, 158),
                                style: BorderStyle.none,
                              ),
                            ),
                            labelText: 'Password',
                            hintText: 'Password',
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: singUpController.re_passwordController,
                          autofillHints: const [AutofillHints.password],
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please Re-Enter Password";
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50.0)),
                              borderSide: BorderSide(
                                color: Color.fromARGB(255, 158, 158, 158),
                                style: BorderStyle.solid,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50.0)),
                              borderSide: BorderSide(
                                color: Color.fromARGB(255, 158, 158, 158),
                                style: BorderStyle.none,
                              ),
                            ),
                            labelText: 'Confirm Password',
                            hintText: 'Confirm Password',
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                      child: singUpController.isLoading.value
                          ? const SizedBox(
                              height: 30,
                              width: 30,
                              child: CircularProgressIndicator(),
                            )
                          : SizedBox(
                              width: Width * 0.3,
                              height: Height * 0.06,
                              child: MaterialButton(
                                onPressed: () async {
                                  if (_formkey.currentState!.validate()) {
                                    if (singUpController
                                            .passwordController.value !=
                                        singUpController
                                            .re_passwordController.value) {
                                      Fluttertoast.showToast(
                                          msg:
                                              "Confirmation of password failed",
                                          gravity: ToastGravity.BOTTOM,
                                          backgroundColor: Colors.black54);
                                    } else {
                                      singUpController.toggleLoading();

                                      await singUpController.register(
                                          singUpController.nameController.text,
                                          singUpController
                                              .fullNameController.text,
                                          singUpController
                                              .designationController.text,
                                          singUpController
                                              .passwordController.text,
                                          singUpController.emailController.text,
                                          singUpController
                                              .phoneNoController.text,
                                          singUpController.profile_pic.value
                                              as XFile);
                                    }
                                  }

                                  // Add your SingUp logic here
                                },
                                color: HexColor('#30a6d6'),
                                textColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: Text(
                                  'Sign Up',
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 18,
                                      fontWeight: FontWeight.w800,
                                      color: HexColor('#f5f5f5')),
                                ),
                              ),
                            )),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ))),
    )));
  }
}
