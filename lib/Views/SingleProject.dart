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
import '../Controllers/NavBarController.dart';
import '../Controllers/ProjectController.dart';
import '../Controllers/TasksController.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'package:carousel_slider/carousel_slider.dart';

import 'EditProject.dart';
import 'TasksByProject.dart';

class SingleProject extends StatelessWidget {
  final projectsController = Get.put(ProjectController());
  final tasksController = Get.put(TasksController());
  final navBarController = Get.put(NavBarController());
  final adminController = Get.put(AdminController());

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  SingleProject({super.key});

  @override
  Widget build(BuildContext context) {
    final Height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    final Width = MediaQuery.of(context).size.width;

    return GetX<TasksController>(
        builder: (controller) => Scaffold(
            extendBody: true,
            floatingActionButton: navBarController.auth_level.value == 3
                ? FloatingActionButton(
                    onPressed: () async {
                      adminController.thumbnail_url.value = null;
                      await projectsController.getSingleProject(
                          projectsController.singleProjectList[0].id);
                      projectsController.toggleIsEpanded();
adminController.thumbnail_url.value = null;
                      Get.to(EditProject());
                    },
                    child: const Icon(Icons.edit),
                  )
//               Row(
//         mainAxisAlignment: MainAxisAlignment.end,
//         children: [
//           FloatingActionButton(
//             onPressed: () {
//               print('taped!!');
//               projectsController.toggleIsEpanded();
//               print(projectsController.isExpanded.value);
//             },
//             child:
//             projectsController.isExpanded.value?
//             Icon(Icons.keyboard_arrow_right_rounded):
//             Icon(Icons.keyboard_arrow_left_rounded),
//           ),
//           AnimatedContainer(
//             duration: Duration(milliseconds: 300),
//             width: projectsController.isExpanded.value ? 150 : 0,
//             height: projectsController.isExpanded.value ? 100 : 0,
//             curve: Curves.easeInOut,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 FloatingActionButton(
//                       onPressed: () async {
//                         await projectsController.getSingleProject(
//                             projectsController.singleProjectList[0].id);
//               projectsController.toggleIsEpanded();

//                         Get.to(EditProject());
//                       },
//                       child: const Icon(Icons.edit),
//                     ),

// //                 FloatingActionButton(
// //                   onPressed: () async {
// //               projectsController.toggleIsEpanded();
// //                                   await tasksController
// //                                       .getTasksByProject(projectsController.singleProjectList[0].id);
// // Get.to(TasksByProject());
// //                   },
// //                   child: Icon(Icons.pending_actions_rounded),
// //                 ),
//               ],
//             ),
//           ),
//         ],
//       ):
                : FloatingActionButton(
                    onPressed: () async {
                      // projectsController.toggleIsEpanded();
                      Get.to(TasksByProject());
                      await tasksController.getTasksByProject(
                          projectsController.singleProjectList[0].id);
                    },
                    child: const Icon(Icons.pending_actions_rounded),
                  ),
            body: RefreshIndicator(
                key: _refreshIndicatorKey,
                color: Colors.white,
                backgroundColor: HexColor("#30a6d6"),
                strokeWidth: 3.0,
                onRefresh: () async {
                  await projectsController.getSingleProject(
                      projectsController.singleProjectList[0].id);

                  return Future<void>.delayed(const Duration(seconds: 2));
                },
                child: SingleChildScrollView(
                  child: SizedBox(
                    height: Height * 1.05,
                    child: projectsController.singleProjectList.isEmpty
                        ? Container(
                            height: Height,
                            alignment: Alignment.center,
                            child: const CircularProgressIndicator())
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: Width,
                                height: Height * 0.3,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    opacity: 80.0,
                                    image: NetworkImage(projectsController
                                        .singleProjectList[0].thumbnailUrl),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20.0,
                                      right: 20,
                                      bottom: 20,
                                      top: 5),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          projectsController
                                              .singleProjectList[0].title,
                                          softWrap: true,
                                          maxLines: 1,
                                          overflow: TextOverflow.fade,
                                          style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 30,
                                              fontWeight: FontWeight.w800,
                                              color: HexColor('#4d4d4d')),
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              'Total Tasks: ',
                                              softWrap: true,
                                              maxLines: 1,
                                              overflow: TextOverflow.fade,
                                              style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w800,
                                                  color: HexColor('#4d4d4d')),
                                            ),
                                            Text(
                                              (projectsController
                                                      .taskByProjectCount.value)
                                                  .toString(),
                                              softWrap: true,
                                              maxLines: 1,
                                              overflow: TextOverflow.fade,
                                              style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500,
                                                  color: HexColor('#4d4d4d')),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "Status: ",
                                              softWrap: true,
                                              maxLines: 1,
                                              overflow: TextOverflow.fade,
                                              style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w800,
                                                  color: HexColor('#4d4d4d')),
                                            ),
                                            projectsController
                                                        .singleProjectList[0]
                                                        .status ==
                                                    'on_going'
                                                ? Row(
                                                    children: [
                                                      Text(
                                                        'On Going',
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'Poppins',
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: HexColor(
                                                                '#4d4d4d')),
                                                      ),
                                                      const SizedBox(
                                                        width: 5,
                                                      ),
                                                      const Icon(
                                                        Icons.pending_actions,
                                                        size: 15,
                                                        color: Colors.orange,
                                                      ),
                                                    ],
                                                  )
                                                : Row(
                                                    children: [
                                                      Text(
                                                        'Completed',
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'Poppins',
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: HexColor(
                                                                '#4d4d4d')),
                                                      ),
                                                      const SizedBox(
                                                        width: 5,
                                                      ),
                                                      const Icon(
                                                        Icons.task_alt_outlined,
                                                        size: 15,
                                                        color: Colors.green,
                                                      ),
                                                    ],
                                                  )
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              'Created Date: ',
                                              softWrap: true,
                                              maxLines: 1,
                                              overflow: TextOverflow.fade,
                                              style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w800,
                                                  color: HexColor('#4d4d4d')),
                                            ),
                                            Text(
                                              DateFormat("dd/MM/yyyy").format(
                                                  DateFormat(
                                                          "E, dd MMM yyyy HH:mm:ss 'GMT'")
                                                      .parse(projectsController
                                                          .singleProjectList[0]
                                                          .createdDate)),
                                              softWrap: true,
                                              maxLines: 1,
                                              overflow: TextOverflow.fade,
                                              style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500,
                                                  color: HexColor('#4d4d4d')),
                                            ),
                                          ],
                                        ),
                                        const Divider(
                                          thickness: 2,
                                        ),
                                        Text(
                                          projectsController
                                              .singleProjectList[0].description,
                                          softWrap: true,
                                          overflow: TextOverflow.fade,
                                          style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                              color: HexColor('#4d4d4d')),
                                        ),
                                      ])),
                            ],
                          ),
                  ),
                ))));
  }
}
