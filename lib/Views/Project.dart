import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:intl/intl.dart';
import '../Controllers/HomeController.dart';
import '../Controllers/ProjectController.dart';
import '../Controllers/TasksController.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'package:carousel_slider/carousel_slider.dart';

import 'SingleProject.dart';

class Project extends StatelessWidget {
  final projectsController = Get.put(ProjectController());
  final tasksController = Get.put(TasksController());
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  Project({super.key});

  @override
  Widget build(BuildContext context) {
    final Height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    final Width = MediaQuery.of(context).size.width;

    return GetX<TasksController>(
        builder: (controller) => Scaffold(
            extendBody: true,
            body: RefreshIndicator(
                      key: _refreshIndicatorKey,
                      color: Colors.white,
                      backgroundColor: HexColor("#30a6d6"),
                      strokeWidth: 3.0,
                      onRefresh: () async {
                        await projectsController.getProjects();

                        return Future<void>.delayed(
                            const Duration(seconds: 2));
                      },

                      child: SingleChildScrollView(
              child: SizedBox(
                height: Height*0.78,
                child:
                Padding(
                padding: const EdgeInsets.only(
                    left: 20.0, right: 20, bottom: 20, top: 5),
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Projects',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 25,
                            fontWeight: FontWeight.w800,
                            color: HexColor('#4d4d4d')),
                      ),
                    ),
                    projectsController.projectList.isEmpty
                        ? const Text(
                            "No Projects to Display!",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Poppins',
                            ),
                          )
                        : SizedBox(
                            height: Height * 0.6,
                            child: ListView.builder(
                              shrinkWrap: true,
                              // reverse: true,
                              physics: BouncingScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              itemCount:
                                  projectsController.projectListCount.value,

                              itemBuilder: (rowContext, index) => SizedBox(
                                  height: Height * 0.2,
                                  child: Card(
                                    color: HexColor('#f5f5f5'),
                                    elevation: 5,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: InkWell(
                                      onTap: () async {
                                        await projectsController
                                            .getSingleProject(projectsController
                                                .projectList[index].id);

                                        await projectsController
                                            .getTasksByProject(
                                                projectsController
                                                    .projectList[index].id);
                                        // projectsController.selected_project_id.value =
                                        //     projectsController.projectList[index].id;

                                        Get.to(SingleProject());
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                          image: DecorationImage(
                                            opacity: 80.0,
                                            image: NetworkImage(
                                                projectsController
                                                    .projectList[index]
                                                    .thumbnailUrl),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        child: Padding(
                                            padding: const EdgeInsets.all(16),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      projectsController
                                                          .projectList[index]
                                                          .title,
                                                      softWrap: true,
                                                      maxLines: 1,
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
                                                    projectsController
                                                                .projectList[
                                                                    index]
                                                                .status ==
                                                            'on_going'
                                                        ? Row(
                                                            children: [
                                                              const Icon(
                                                                Icons
                                                                    .pending_actions,
                                                                size: 15,
                                                                color: Colors
                                                                    .orange,
                                                              ),
                                                              const SizedBox(
                                                                width: 5,
                                                              ),
                                                              Text(
                                                                'On Going',
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        'Poppins',
                                                                    fontSize:
                                                                        12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    color: HexColor(
                                                                        '#4d4d4d')),
                                                              ),
                                                            ],
                                                          )
                                                        : Row(
                                                            children: [
                                                              const Icon(
                                                                Icons
                                                                    .task_alt_outlined,
                                                                size: 15,
                                                                color: Colors
                                                                    .green,
                                                              ),
                                                              const SizedBox(
                                                                width: 5,
                                                              ),
                                                              Text(
                                                                'Completed',
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        'Poppins',
                                                                    fontSize:
                                                                        12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    color: HexColor(
                                                                        '#4d4d4d')),
                                                              ),
                                                            ],
                                                          )
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  projectsController
                                                      .projectList[index]
                                                      .description,
                                                  softWrap: true,
                                                  maxLines: 2,
                                                  overflow: TextOverflow.fade,
                                                  style: TextStyle(
                                                      fontFamily: 'Poppins',
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color:
                                                          HexColor('#4d4d4d')),
                                                ),
                                                const Spacer(
                                                  flex: 1,
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      'Created date: ',
                                                      softWrap: false,
                                                      overflow:
                                                          TextOverflow.fade,
                                                      style: TextStyle(
                                                          fontFamily: 'Poppins',
                                                          fontSize: 13,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: HexColor(
                                                              '#4d4d4d')),
                                                    ),
                                                    Text(
                                                      DateFormat("dd/MM/yyyy")
                                                          .format(DateFormat(
                                                                  "E, dd MMM yyyy HH:mm:ss 'GMT'")
                                                              .parse(projectsController
                                                                  .projectList[
                                                                      index]
                                                                  .createdDate)),
                                                      softWrap: false,
                                                      overflow:
                                                          TextOverflow.fade,
                                                      style: TextStyle(
                                                          fontFamily: 'Poppins',
                                                          fontSize: 13,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: HexColor(
                                                              '#4d4d4d')),
                                                    )
                                                  ],
                                                ),
                                              ],
                                            )),
                                      ),
                                    ),
                                  )),
                            ),
                          ),
                  ],
                ),
              ),
            )))));
  }
}
