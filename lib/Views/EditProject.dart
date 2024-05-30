import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:intl/intl.dart';
import 'package:officeapp/Models/Users.dart';
import '../Controllers/AdminController.dart';
import '../Controllers/HomeController.dart';
import '../Controllers/ProjectController.dart';
import '../Controllers/TasksController.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multiselect/flutter_multiselect.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'Components/ProjectAddFaild.dart';
import 'Components/ProjectAddSuccsess.dart';
import 'SingleProject.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dotted_border/dotted_border.dart';

class EditProject extends StatelessWidget {
  final projectsController = Get.put(ProjectController());
  final tasksController = Get.put(TasksController());
  final adminController = Get.put(AdminController());
  final _multiSelectKey = GlobalKey<FormFieldState>();

  EditProject({super.key});

  Future selectImage() async {
    final ImagePicker _picker = ImagePicker();

    final pickedImage = await _picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    if (pickedImage != null) {
      print('11111111111111111111111111111');
      adminController.thumbnail_url.value = XFile(pickedImage.path);
      print('11111111111111111111111111111');
    } else {
      print("There is no any selected image");
    }
  }

  @override
  Widget build(BuildContext context) {
    final Height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    final Width = MediaQuery.of(context).size.width;
    final _formkey = GlobalKey<FormState>();

    return GetX<ProjectController>(
        builder: (controller) => Scaffold(
              extendBody: true,
              body: SingleChildScrollView(
                  child: Padding(
                padding: const EdgeInsets.only(
                    left: 20.0, right: 20, bottom: 20, top: 30),
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Edit Project',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 25,
                            fontWeight: FontWeight.w800,
                            color: HexColor('#4d4d4d')),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Project Title: ',
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 15,
                              fontWeight: FontWeight.w800,
                              color: HexColor('#4d4d4d')),
                        )),
                    SizedBox(
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: TextFormField(
                          // keyboardType: TextInputType.multiline,
                          // minLines:
                          //     1, // Normal textInputField will be displayed
                          // maxLines:
                          //     10, // When user presses enter it will adapt to it
                          controller:
                              projectsController.editProjectTitleController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Project Title is required';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color.fromARGB(255, 158, 158, 158),
                                  style: BorderStyle.solid,
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color.fromARGB(255, 158, 158, 158),
                                  style: BorderStyle.solid,
                                ),
                              ),
                              // labelText: 'Material List',
                              hintText: 'Project Title',
                              contentPadding: EdgeInsets.only(
                                  top: 10.0, bottom: 10, left: 10, right: 10)),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Project Description: ',
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 15,
                              fontWeight: FontWeight.w800,
                              color: HexColor('#4d4d4d')),
                        )),
                    SizedBox(
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: TextFormField(
                          // autofocus: true,
                          keyboardType: TextInputType.multiline,
                          minLines:
                              1, // Normal textInputField will be displayed
                          maxLines:
                              5, // When user presses enter it will adapt to it
                          controller: projectsController
                              .editProjectDescriptionController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Project Descrption is required';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromARGB(255, 158, 158, 158),
                                style: BorderStyle.solid,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromARGB(255, 158, 158, 158),
                                style: BorderStyle.solid,
                              ),
                            ),
                            // labelText: 'Material List',
                            hintText: 'Project Descrption',
                            // contentPadding:
                            //     EdgeInsets.only(left: 10, right: 10)
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Select Users: ',
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 15,
                              fontWeight: FontWeight.w800,
                              color: HexColor('#4d4d4d')),
                        )),
                    adminController.usersList.isEmpty
                        ? const Text(
                            "No Users to Display!",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Poppins',
                            ),
                          )
                        : SizedBox(
                            // height: Height * 0.6,
                            child: MultiSelectDialogField(
                              searchable: true,
                              items: adminController.items
                                  .map((e) => MultiSelectItem(e, e.label))
                                  .toList(),
                              listType: MultiSelectListType.CHIP,
                              onConfirm: (values) {
                                projectsController.editUsersList.value = values;
                              },
                            ),
                          ),
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Select Image: ',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 15,
                            fontWeight: FontWeight.w800,
                            color: HexColor('#4d4d4d')),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          bottom: Height * 0.025, right: 25, left: 25),
                      child: DottedBorder(
                          dashPattern: const [1, 1],
                          strokeWidth: 2,
                          color: const Color.fromARGB(255, 207, 229, 238),
                          child: adminController.thumbnail_url.value != null
                              ? Container(
                                  width: double.infinity,
                                  height: 150,
                                  child: InkWell(
                                    onTap: () {
                                      selectImage();
                                    },
                                    child: Image.file(
                                      File(adminController
                                          .thumbnail_url.value!.path),
                                    ),
                                  ))
                              : Container(
                                  width: double.infinity,
                                  height: 150,
                                  child: ElevatedButton(
                                    onPressed: () async {},
                                    style: ElevatedButton.styleFrom(
                                      primary: HexColor("#DBDBDB"),
                                      padding: const EdgeInsets.only(
                                          left: 5, right: 5),
                                    ),
                                    child: InkWell(
                                      onTap: () {
                                        selectImage();
                                      },
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 5, right: 5, top: 20),
                                            child: Icon(
                                              Icons.image_search,
                                              color: HexColor("#30a6d6"),
                                              size: 50,
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          Text(
                                            'Select Image form Gallery',
                                            style: TextStyle(
                                                fontFamily: 'Poppins',
                                                fontSize: 12,
                                                fontWeight: FontWeight.w800,
                                                color: HexColor('#4d4d4d')),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    adminController.isAddProjectLoading.value
                        ? const SizedBox(
                            height: 30,
                            width: 30,
                            child: CircularProgressIndicator(),
                          )
                        : Container(
                            alignment: Alignment.bottomRight,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: HexColor(
                                    '#30a6d6'), // Change the background color here
                              ),
                              onPressed: () {
                                showDialog<String>(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                    title: const Text(
                                        'Confirmation of Adding Project'),
                                    content: const Text(
                                        'Are you sure want to add this project?'),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () => Get.back(),
                                        child: const Text('No'),
                                      ),
                                      TextButton(
                                        onPressed: () async {
                                          // tasksController.addTask();

                                          if (projectsController.editProjectTitleController.text == null ||
                                              projectsController
                                                      .editProjectDescriptionController
                                                      .text ==
                                                  null ||
                                              projectsController
                                                  .editUsersList.isEmpty) {
                                            showDialog<String>(
                                              context: context,
                                              builder: (BuildContext context) =>
                                                  const ProjectAddFaild(),
                                            );
                                          } else {
                                           
                                            await adminController.editProject(
                                                projectsController
                                                    .editProjectTitleController
                                                    .text,
                                                projectsController
                                                    .editProjectDescriptionController
                                                    .text,
                                                adminController.thumbnail_url
                                                    .value as XFile,
                                                projectsController
                                                    .editUsersList);
                                            Get.back();
                                            Get.back();
                                            adminController.toggleLoading();
                                            await projectsController
                                                .getProjects();
                                            showDialog<String>(
                                              context: context,
                                              builder: (BuildContext context) =>
                                                  const ProjectAddSuccsess(),
                                            );
                                          }
                                        },
                                        child: const Text('Yes'),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              child: const Text('Edit Project'),
                            ),
                          ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              )),
            ));
  }
}
