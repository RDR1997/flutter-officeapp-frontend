import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:officeapp/Controllers/AdminController.dart';
import 'package:officeapp/Controllers/LoginController.dart';
import '../Controllers/ProjectController.dart';

import 'package:multi_dropdown/enum/app_enums.dart';
import 'package:multi_dropdown/models/chip_config.dart';
import 'package:multi_dropdown/models/network_config.dart';
import 'package:multi_dropdown/models/value_item.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:multi_dropdown/widgets/hint_text.dart';
import 'package:multi_dropdown/widgets/selection_chip.dart';
import 'package:multi_dropdown/widgets/single_selected_item.dart';

class EditProfile extends StatelessWidget {
  final projectsController = Get.put(ProjectController());
  final adminController = Get.put(AdminController());
  final loginController = Get.put(LoginController());

  EditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final Height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    final Width = MediaQuery.of(context).size.width;

    return GetX<AdminController>(
        builder: (controller) => Scaffold(
            extendBody: true,
            body: SingleChildScrollView(
              child: adminController.isLoading.value
                  ? const Center(
                      child: SizedBox(
                        height: 30,
                        width: 30,
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.only(
                          left: 30.0, right: 30, bottom: 20, top: 50),
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            alignment: Alignment.bottomRight,
                            child: InkWell(
                              onTap: () async {
                                if (adminController.isEditEnable.value) {
                                  await adminController.editUser(
                                      (adminController.userId.value).toString(),
                                      context);
                                  adminController.toggleEditButton();
                                } else {
                                  adminController.toggleEditButton();
                                }
                              },
                              child: adminController.isEditEnable.value
                                  ? Icon(
                                      Icons.done,
                                      size: 30,
                                      color: HexColor('#30a6d6'),
                                    )
                                  : Icon(
                                      Icons.mode_edit_rounded,
                                      size: 30,
                                      color: HexColor('#30a6d6'),
                                    ),
                            ),
                          ),
                          SizedBox(
                            width: Width * 0.45,
                            height: Width * 0.45,
                            child: Padding(
                              padding: EdgeInsets.all(5.0),
                              child: CircleAvatar(
                                backgroundImage: NetworkImage((adminController
                                        .proPicUrl)
                                    .toString()), // Replace with your image URL
                              ),
                            ),
                          ),
                          Text(
                            adminController.userName.value,
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: HexColor('#4d4d4d')),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding:
                                    const EdgeInsets.only(top: 10, bottom: 10),
                                child: Text(
                                  'Name: ',
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 15,
                                      fontWeight: FontWeight.w800,
                                      color: HexColor('#4d4d4d')),
                                ),
                              ),
                              TextFormField(
                                controller:
                                    adminController.editFullnameController,
                                enabled: adminController.isEditEnable.value,
                                onChanged: (value) {
                                  // schoolNameController.text = value;
                                },
                                style: const TextStyle(fontSize: 20),
                                cursorColor: Colors.black,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                      borderSide:
                                          BorderSide(color: Colors.black)),
                                  filled: false,
                                  //hintText: snapshot.data!.name,
                                  contentPadding: EdgeInsets.all(17),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Container(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: Text(
                                  'Designation: ',
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 15,
                                      fontWeight: FontWeight.w800,
                                      color: HexColor('#4d4d4d')),
                                ),
                              ),
                              TextFormField(
                                //initialValue: snapshot.data!.name,
                                controller:
                                    adminController.editDesignationController,
                                enabled: adminController.isEditEnable.value,
                                onChanged: (value) {
                                  // schoolNameController.text = value;
                                },
                                style: const TextStyle(fontSize: 20),
                                cursorColor: Colors.black,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                      borderSide:
                                          BorderSide(color: Colors.black)),
                                  filled: false,
                                  //hintText: snapshot.data!.name,
                                  contentPadding: EdgeInsets.all(17),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Container(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: Text(
                                  'Email: ',
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 15,
                                      fontWeight: FontWeight.w800,
                                      color: HexColor('#4d4d4d')),
                                ),
                              ),
                              TextFormField(
                                //initialValue: snapshot.data!.name,
                                controller:
                                    adminController.editEmailnController,
                                enabled: adminController.isEditEnable.value,
                                onChanged: (value) {
                                  // schoolNameController.text = value;
                                },
                                style: const TextStyle(fontSize: 20),
                                cursorColor: Colors.black,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                      borderSide:
                                          BorderSide(color: Colors.black)),
                                  filled: false,
                                  //hintText: snapshot.data!.name,
                                  contentPadding: EdgeInsets.all(17),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Container(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: Text(
                                  'Phone Number: ',
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 15,
                                      fontWeight: FontWeight.w800,
                                      color: HexColor('#4d4d4d')),
                                ),
                              ),
                              TextFormField(
                                //initialValue: snapshot.data!.name,
                                controller:
                                    adminController.editPhonNoController,
                                enabled: adminController.isEditEnable.value,
                                onChanged: (value) {
                                  // schoolNameController.text = value;
                                },
                                style: const TextStyle(fontSize: 20),
                                cursorColor: Colors.black,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                      borderSide:
                                          BorderSide(color: Colors.black)),
                                  filled: false,
                                  //hintText: snapshot.data!.name,
                                  contentPadding: EdgeInsets.all(17),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Container(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: Text(
                                  'Authentication level: ',
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 15,
                                      fontWeight: FontWeight.w800,
                                      color: HexColor('#4d4d4d')),
                                ),
                              ),
                              DropdownButtonFormField<int>(
                                value: adminController.auth_level.value,

                                //hint: Text("Country"),
                                decoration: const InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                      borderSide:
                                          BorderSide(color: Colors.black),
                                    ),
                                    filled: true,
                                    contentPadding: EdgeInsets.all(17)),
                                items: List.generate(
                                  adminController.authLevel.length,
                                  (index) {
                                    //return DropdownMenuItem(child: Text(cat.country!));
                                    return DropdownMenuItem(
                                      value: adminController.authLevel[index],
                                      child: Container(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          (adminController.authLevel[index])
                                              .toString(),
                                          style: const TextStyle(fontSize: 18),
                                        ),
                                      ),
                                    );
                                  },
                                ),

                                onChanged:
                                    adminController.isEditEnable.value == false
                                        ? null
                                        : (value) {
                                            adminController.auth_level.value =
                                                value!;
                                          },
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Container(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: Text(
                                  'Supervisor: ',
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 15,
                                      fontWeight: FontWeight.w800,
                                      color: HexColor('#4d4d4d')),
                                ),
                              ),
                              DropdownButtonFormField<int>(
                                value:
                                    adminController.selectedAuth2UserId.value,

                                //hint: Text("Country"),
                                decoration: const InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                      borderSide:
                                          BorderSide(color: Colors.black),
                                    ),
                                    filled: true,
                                    contentPadding: EdgeInsets.all(17)),
                                items: List.generate(
                                  adminController.auth2UserList.length,
                                  (index) {
                                    var supervisor =
                                        adminController.auth2UserList[index];
                                    print('0000000000000000000000000000000000');
                                    print(supervisor.id);
                                    print('0000000000000000000000000000000000');

                                    //return DropdownMenuItem(child: Text(cat.country!));
                                    return DropdownMenuItem(
                                      value: supervisor.id,
                                      child: Container(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          supervisor.fullName,
                                          style: const TextStyle(fontSize: 18),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                // onChanged: (Object? value) {
                                //   setState(() {
                                //     // futureCategories =
                                //     //     fetchCategories(value.toString());
                                //     _selectedCountry = value.toString();
                                //   });
                                // },
                                onChanged:
                                    adminController.isEditEnable.value == false
                                        ? null
                                        : (value) {
                                            adminController.selectedSupervisorId
                                                .value = value!;
                                          },
                                //onChanged: null,
                              )
                              // MultiSelectDropDown(
                              //   showClearIcon: true,
                              //   controller:
                              //       adminController.supervisorController,
                              //   onOptionSelected: (options) {
                              //     debugPrint(options.toString());
                              //   },
                              //   options: adminController.supervisorList.value,
                              //   // maxItems: 2,
                              //   disabledOptions: const [
                              //     ValueItem(label: 'Option 1', value: '1')
                              //   ],
                              //   selectionType: SelectionType.multi,
                              //   chipConfig:
                              //       const ChipConfig(wrapType: WrapType.wrap),
                              //   dropdownHeight: 300,
                              //   optionTextStyle: const TextStyle(fontSize: 16),
                              //   selectedOptionIcon:
                              //       const Icon(Icons.check_circle),
                              // ),
                              // DropdownButtonFormField<int>(
                              //   value: adminController.auth_level.value,

                              //   //hint: Text("Country"),
                              //   decoration: const InputDecoration(
                              //       enabledBorder: OutlineInputBorder(
                              //         borderRadius: BorderRadius.all(
                              //             Radius.circular(10.0)),
                              //         borderSide:
                              //             BorderSide(color: Colors.black),
                              //       ),
                              //       filled: true,
                              //       contentPadding: EdgeInsets.all(17)),
                              //   items: List.generate(
                              //     adminController.authLevel.length,
                              //     (index) {
                              //       //return DropdownMenuItem(child: Text(cat.country!));
                              //       return DropdownMenuItem(
                              //         value: adminController.authLevel[index],
                              //         child: Container(
                              //           alignment: Alignment.centerLeft,
                              //           child: Text(
                              //             (adminController.authLevel[index])
                              //                 .toString(),
                              //             style: const TextStyle(fontSize: 18),
                              //           ),
                              //         ),
                              //       );
                              //     },
                              //   ),

                              //   onChanged:
                              //       adminController.isEditEnable.value == false
                              //           ? null
                              //           : (value) {
                              //               adminController.auth_level.value =
                              //                   value!;
                              //             },
                              // )
                              // DropDownMultiSelect(
                              //   options: adminController.fruits,
                              //   selectedValues: adminController.selectedFruits,
                              //   onChanged: (value) {
                              //     print('selected fruit $value');
                              //     adminController.selectedFruits = value;
                              //     print(
                              //         'you have selected ${adminController.selectedFruits} fruits.');
                              //   },
                              //   whenEmpty: 'Select your favorite fruits',
                              // ),
                            ],
                          ),

                          // if (adminController.supervisorList.isNotEmpty)
                          //   Container(
                          //     padding: const EdgeInsets.only(bottom: 10),
                          //     child: Row(
                          //       crossAxisAlignment: CrossAxisAlignment.start,
                          //       children: [
                          //         Text(
                          //           'Supervisours: ',
                          //           style: TextStyle(
                          //               fontFamily: 'Poppins',
                          //               fontSize: 15,
                          //               fontWeight: FontWeight.w800,
                          //               color: HexColor('#4d4d4d')),
                          //         ),
                          //         SizedBox(
                          //           width: Width * 0.5,
                          //           height: 45,
                          //           child: ListView.builder(
                          //             physics:
                          //                 const NeverScrollableScrollPhysics(),
                          //             itemCount: adminController
                          //                 .supervisorListCount.value,
                          //             itemBuilder: (context, index) {
                          //               return Text(
                          //                   adminController
                          //                       .supervisorList[index].fullName,
                          //                   style: TextStyle(
                          //                       fontFamily: 'Poppins',
                          //                       fontSize: 15,
                          //                       fontWeight: FontWeight.w500,
                          //                       color: HexColor('#4d4d4d')));
                          //             },
                          //           ),
                          //         ),
                          //         // Text(
                          //         //   '{spervisors}',
                          //         //   style: TextStyle(
                          //         //       fontFamily: 'Poppins',
                          //         //       fontSize: 15,
                          //         //       fontWeight: FontWeight.w500,
                          //         //       color: HexColor('#4d4d4d')),
                          //         // ),
                          //       ],
                          //     ),
                          //   ),
                          // if (projectsController.userProjectList.isNotEmpty)
                          //   const Divider(
                          //     thickness: 2,
                          //   ),
                          // if (projectsController.userProjectList.isNotEmpty)
                          //   Container(
                          //     alignment: Alignment.topLeft,
                          //     padding: const EdgeInsets.only(bottom: 10),
                          //     child: Text(
                          //       'Associated Projects',
                          //       style: TextStyle(
                          //           fontFamily: 'Poppins',
                          //           fontSize: 15,
                          //           fontWeight: FontWeight.w800,
                          //           color: HexColor('#4d4d4d')),
                          //     ),
                          //   ),
                          // if (projectsController.userProjectList.isNotEmpty)
                          //   SizedBox(
                          //     height: Height * 0.6,
                          //     child: ListView.builder(
                          //       shrinkWrap: true,
                          //       // reverse: true,
                          //       physics: const BouncingScrollPhysics(),
                          //       scrollDirection: Axis.vertical,
                          //       itemCount: projectsController.userProjectList.length,

                          //       itemBuilder: (rowContext, index) => SizedBox(
                          //           height: Height * 0.1,
                          //           child: Card(
                          //             color: HexColor('#f5f5f5'),
                          //             elevation: 5,
                          //             shape: RoundedRectangleBorder(
                          //               borderRadius: BorderRadius.circular(20),
                          //             ),
                          //             child: InkWell(
                          //               onTap: () {
                          //                 Get.to(SingleProject());
                          //               },
                          //               child: Container(
                          //                 decoration: BoxDecoration(
                          //                   borderRadius: BorderRadius.circular(20.0),
                          //                   image: const DecorationImage(
                          //                     opacity: 80.0,
                          //                     image: AssetImage(
                          //                         'assets/images/task.png'),
                          //                     fit: BoxFit.cover,
                          //                   ),
                          //                 ),
                          //                 child: Padding(
                          //                     padding: const EdgeInsets.all(16),
                          //                     child: Column(
                          //                       mainAxisAlignment:
                          //                           MainAxisAlignment.start,
                          //                       crossAxisAlignment:
                          //                           CrossAxisAlignment.start,
                          //                       children: [
                          //                         Row(
                          //                           mainAxisAlignment:
                          //                               MainAxisAlignment
                          //                                   .spaceBetween,
                          //                           children: [
                          //                             Text(
                          //                               projectsController
                          //                                   .userProjectList[index]
                          //                                   .title,
                          //                               softWrap: true,
                          //                               maxLines: 1,
                          //                               overflow: TextOverflow.fade,
                          //                               style: TextStyle(
                          //                                   fontFamily: 'Poppins',
                          //                                   fontSize: 20,
                          //                                   fontWeight:
                          //                                       FontWeight.w800,
                          //                                   color:
                          //                                       HexColor('#4d4d4d')),
                          //                             ),
                          //                             projectsController
                          //                                         .userProjectList[
                          //                                             index]
                          //                                         .status ==
                          //                                     'on_going'
                          //                                 ? Row(
                          //                                     children: [
                          //                                       const Icon(
                          //                                         Icons
                          //                                             .pending_actions,
                          //                                         size: 15,
                          //                                         color:
                          //                                             Colors.orange,
                          //                                       ),
                          //                                       const SizedBox(
                          //                                         width: 5,
                          //                                       ),
                          //                                       Text(
                          //                                         'On Going',
                          //                                         style: TextStyle(
                          //                                             fontFamily:
                          //                                                 'Poppins',
                          //                                             fontSize: 12,
                          //                                             fontWeight:
                          //                                                 FontWeight
                          //                                                     .w500,
                          //                                             color: HexColor(
                          //                                                 '#4d4d4d')),
                          //                                       ),
                          //                                     ],
                          //                                   )
                          //                                 : Row(
                          //                                     children: [
                          //                                       const Icon(
                          //                                         Icons
                          //                                             .task_alt_outlined,
                          //                                         size: 15,
                          //                                         color: Colors.green,
                          //                                       ),
                          //                                       const SizedBox(
                          //                                         width: 5,
                          //                                       ),
                          //                                       Text(
                          //                                         'Completed',
                          //                                         style: TextStyle(
                          //                                             fontFamily:
                          //                                                 'Poppins',
                          //                                             fontSize: 12,
                          //                                             fontWeight:
                          //                                                 FontWeight
                          //                                                     .w500,
                          //                                             color: HexColor(
                          //                                                 '#4d4d4d')),
                          //                                       ),
                          //                                     ],
                          //                                   )
                          //                           ],
                          //                         ),
                          //                       ],
                          //                     )),
                          //               ),
                          //             ),
                          //           )),
                          //     ),
                          //   ),
                        ],
                      ),
                    ),
            )));
  }
}
