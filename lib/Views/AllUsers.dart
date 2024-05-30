import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:intl/intl.dart';
import 'package:officeapp/Controllers/AdminController.dart';
import '../Controllers/HomeController.dart';
import '../Controllers/ProjectController.dart';
import '../Controllers/TasksController.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'package:carousel_slider/carousel_slider.dart';

import 'EditProfile.dart';
import 'SingleProject.dart';

class AllUsers extends StatelessWidget {
  AllUsers({super.key});
  final adminController = Get.put(AdminController());
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    final Height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    final Width = MediaQuery.of(context).size.width;

    return
        // Scaffold(extendBody: true, body: Text("testing"));

        GetX<AdminController>(
            builder: (controller) => Scaffold(
                extendBody: true,
                body: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0, right: 20, bottom: 20, top: 5),
                    child: SizedBox(
                      height: Height * 1.01,
                      child: Column(
                        children: [
                          adminController.usersList.isEmpty
                              ? SizedBox(
                                  height: Height,
                                  child: const Center(
                                    child: Text(
                                      "No Users to Display!",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: 'Poppins',
                                      ),
                                    ),
                                  ),
                                )
                              : SizedBox(
                                  height: Height * 1.01,
                                  child: RefreshIndicator(
                                      key: _refreshIndicatorKey,
                                      color: Colors.white,
                                      backgroundColor: HexColor("#30a6d6"),
                                      strokeWidth: 3.0,
                                      onRefresh: () async {
                                        await adminController.getAllusers();

                                        return Future<void>.delayed(
                                            const Duration(seconds: 2));
                                      },
                                      child: ListView.separated(
                                        shrinkWrap: true,
                                        // reverse: true,
                                        physics: const BouncingScrollPhysics(),
                                        scrollDirection: Axis.vertical,
                                        itemCount:
                                            adminController.usersList.length,

                                        itemBuilder: (rowContext, index) =>
                                            SizedBox(
                                          height: Height * 0.15,
                                          child: InkWell(
                                            onTap: () async {
                                              await adminController
                                                  .getAuth2users();
                                              await adminController.getUser(
                                                  adminController
                                                      .usersList[index].id);
                                              await adminController
                                                  .getSupervisorById(
                                                      adminController
                                                          .usersList[index].id);
                                              Get.to(EditProfile());
                                              // await projectsController.getSingleProject(
                                              //     projectsController
                                              //         .projectList[index].id);

                                              // await projectsController.getTasksByProject(
                                              //     projectsController
                                              //         .projectList[index].id);
                                              // // projectsController.selected_project_id.value =
                                              // //     projectsController.projectList[index].id;
                                            },
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                SizedBox(
                                                  width: Width * 0.25,
                                                  height: Width * 0.25,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            5.0),
                                                    child: CircleAvatar(
                                                      backgroundImage: NetworkImage(
                                                          (adminController
                                                                  .usersList[
                                                                      index]
                                                                  .profilePicUrl)
                                                              .toString()), // Replace with your image URL
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 20,
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      adminController
                                                          .usersList[index]
                                                          .fullName,
                                                      softWrap: true,
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.fade,
                                                      style: TextStyle(
                                                          fontFamily: 'Poppins',
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.w800,
                                                          color: HexColor(
                                                              '#4d4d4d')),
                                                    ),
                                                    Text(
                                                      adminController
                                                          .usersList[index]
                                                          .name,
                                                      softWrap: true,
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.fade,
                                                      style: TextStyle(
                                                          fontFamily: 'Poppins',
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: HexColor(
                                                              '#4d4d4d')),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        separatorBuilder:
                                            (BuildContext context, int index) {
                                          return const Divider(
                                            thickness: 2,
                                          );
                                        },
                                      )),
                                ),
                        ],
                      ),
                    ),
                  ),
                )));
  }
}
