import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import '../Controllers/ProjectController.dart';
import '../Controllers/TasksController.dart';
import 'Components/TaskAddSuccsess.dart';

final tasksController = Get.put(TasksController());
final projectsController = Get.put(ProjectController());

class Popup extends StatefulWidget {
  const Popup({super.key});

  @override
  _PopupState createState() => _PopupState();
}

class _PopupState extends State<Popup> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    final width = MediaQuery.of(context).size.width;

    return GetX<TasksController>(
      builder: (controller) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.only(
              top: 20.0,
              left: 20,
              right: 20,
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Text(
                    'Add Tasks',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: HexColor('#4d4d4d'),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Select User: ',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                          color: HexColor('#4d4d4d'),
                        ),
                      ),
                      SizedBox(
                        width: width * 0.56,
                        child: DropdownButtonFormField(
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.all(
                                Radius.circular(7.0),
                              ),
                            ),
                            filled: true,
                            fillColor: HexColor("#F6F7FA"),
                            labelText: "Subordinates",
                            labelStyle: const TextStyle(
                              color: Colors.grey,
                              fontSize: 18,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 10.0,
                              horizontal: 16.0,
                            ),
                          ),
                          dropdownColor: HexColor("#F6F7FA"),
                          icon: const Icon(Icons.arrow_drop_down),
                          iconSize: 40,
                          validator: (value) => value == null ? 'Subordinates is required' : null,
                          items: tasksController.subordinateList.map((subordinate) {
                            return DropdownMenuItem(
                              value: subordinate.id,
                              child: Text(
                                subordinate.fullName.toString(),
                                softWrap: true,
                                maxLines: 1,
                                overflow: TextOverflow.clip,
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: HexColor('#4d4d4d'),
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (Object? value) {
                            tasksController.selectedSubordinateValue.value = value.toString();
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Select Project: ',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                          color: HexColor('#4d4d4d'),
                        ),
                      ),
                      SizedBox(
                        width: width * 0.56,
                        child: DropdownButtonFormField(
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.all(
                                Radius.circular(7.0),
                              ),
                            ),
                            filled: true,
                            fillColor: HexColor("#F6F7FA"),
                            labelText: "Project",
                            labelStyle: const TextStyle(
                              color: Colors.grey,
                              fontSize: 18,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 10.0,
                              horizontal: 16.0,
                            ),
                          ),
                          dropdownColor: HexColor("#F6F7FA"),
                          icon: const Icon(Icons.arrow_drop_down),
                          iconSize: 40,
                          validator: (value) => value == null ? 'Project is required' : null,
                          items: projectsController.projectList.map((project) {
                            return DropdownMenuItem(
                              value: project.id,
                              child: Text(
                                project.title.toString(),
                                softWrap: true,
                                maxLines: 1,
                                overflow: TextOverflow.clip,
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: HexColor('#4d4d4d'),
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (Object? value) {
                            projectsController.selectedProjectValue.value = value.toString();
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Container(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Category: ',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                        color: HexColor('#4d4d4d'),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: TextFormField(
                        controller: tasksController.categoryController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Category is required';
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
                          hintText: 'Category',
                          contentPadding: EdgeInsets.only(
                            top: 10.0,
                            bottom: 10,
                            left: 10,
                            right: 10,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Topic: ',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                        color: HexColor('#4d4d4d'),
                      ),
                    ),
                  ),
                  SizedBox(
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: TextFormField(
                        controller: tasksController.topicController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Task Topic is required';
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
                          hintText: 'Task Topic',
                          contentPadding: EdgeInsets.only(
                            top: 10.0,
                            bottom: 10,
                            left: 10,
                            right: 10,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Description: ',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                        color: HexColor('#4d4d4d'),
                      ),
                    ),
                  ),
                  SizedBox(
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: TextFormField(
                        keyboardType: TextInputType.multiline,
                        minLines: 1,
                        maxLines: 5,
                        controller: tasksController.descriptionController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Task Description is required';
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
                          hintText: 'Task Description',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Start Date: ',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                          color: HexColor('#4d4d4d'),
                        ),
                      ),
                      TextButton(
                        onPressed: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1900),
                            lastDate: DateTime(2100),
                          );
                          if (pickedDate == null) return;

                          TimeOfDay? pickedTime = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay(
                              hour: tasksController.startDateTime.value.hour,
                              minute: tasksController.startDateTime.value.minute,
                            ),
                          );
                          if (pickedTime == null) return;

                          setState(() {
                            tasksController.startDateTime.value = DateTime(
                              pickedDate.year,
                              pickedDate.month,
                              pickedDate.day,
                              pickedTime.hour,
                              pickedTime.minute,
                            );
                          });
                        },
                        child: Text(
                          '${DateFormat.yMMMd().format(tasksController.startDateTime.value)} | ${DateFormat.jm().format(tasksController.startDateTime.value)}',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: HexColor('#30a6d6'),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Due Date: ',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                          color: HexColor('#4d4d4d'),
                        ),
                      ),
                      TextButton(
                        onPressed: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1900),
                            lastDate: DateTime(2100),
                          );
                          if (pickedDate == null) return;

                          TimeOfDay? pickedTime = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay(
                              hour: tasksController.dueDateTime.value.hour,
                              minute: tasksController.dueDateTime.value.minute,
                            ),
                          );
                          if (pickedTime == null) return;

                          setState(() {
                            tasksController.dueDateTime.value = DateTime(
                              pickedDate.year,
                              pickedDate.month,
                              pickedDate.day,
                              pickedTime.hour,
                              pickedTime.minute,
                            );
                          });
                        },
                        child: Text(
                          '${DateFormat.yMMMd().format(tasksController.dueDateTime.value)} | ${DateFormat.jm().format(tasksController.dueDateTime.value)}',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: HexColor('#30a6d6'),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    alignment: Alignment.bottomRight,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: HexColor('#30a6d6'),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: const Text('Confirmation of Adding Task'),
                              content: const Text('Are you sure want to add this task?'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () => Get.back(),
                                  child: const Text('No'),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    tasksController.addTask(
                                      projectsController.selectedProjectValue.value,
                                      tasksController.topicController.text,
                                      tasksController.categoryController.text,
                                      tasksController.descriptionController.text,
                                      tasksController.startDateTime.value.toString(),
                                      tasksController.dueDateTime.value.toString(),
                                      tasksController.selectedSubordinateValue.value,
                                      context,
                                    );
                                    Get.back();
                                    Get.back();
                                    showDialog<String>(
                                      context: context,
                                      builder: (BuildContext context) => const TaskAddSuccess(),
                                    );
                                  },
                                  child: const Text('Yes'),
                                ),
                              ],
                            ),
                          );
                        }
                      },
                      child: const Text('Add task'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
