import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:intl/intl.dart';
import 'package:officeapp/Views/InProgressTasks.dart';
import 'package:officeapp/Views/PendingTasks.dart';
import '../Controllers/CommentController.dart';
import '../Controllers/HomeController.dart';
import '../Controllers/TasksController.dart';

import 'package:carousel_slider/carousel_slider.dart';

import 'SingleTask.dart';

class Home extends StatelessWidget {
  final homeUpController = Get.put(HomeController());
  final tasksController = Get.put(TasksController());
  final commentController = Get.put(CommentController());
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  Home({super.key});

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now().toLocal();

    final Height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    final Width = MediaQuery.of(context).size.width;

    return GetX<TasksController>(
        builder: (controller) => Scaffold(
            extendBody: true,
            body:RefreshIndicator(
                      key: _refreshIndicatorKey,
                      color: Colors.white,
                      backgroundColor: HexColor("#30a6d6"),
                      strokeWidth: 3.0,
                      onRefresh: () async {
                      await tasksController.getUserTasksInProgress();
                      await tasksController.getUserTasksPending();
                      await tasksController.getUserTasksInProgress();

                        return Future<void>.delayed(
                            const Duration(seconds: 2));
                      },

                      child: SingleChildScrollView(
              child: SizedBox(
                height: Height*0.78,
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 20.0, right: 20, bottom: 20, top: 5),
                  child: Column(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          if (tasksController.myListPending.isNotEmpty)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    'To Do',
                                    style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: HexColor('#4d4d4d')),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    Get.to(PendingTasks());
                                    await tasksController.getUserTasksPending();
                                  },
                                  child: Text(
                                    'View All',
                                    style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: HexColor('#30a6d6')),
                                  ),
                                )
                              ],
                            ),
                          tasksController.myListPending.isNotEmpty
                              ? Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      children: [
                                        SizedBox(
                                            height: Width * 0.43,
                                            width: Width * 0.43,
                                            child: Card(
                                              color: HexColor('#f5f5f5'),
                                              elevation: 5,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.all(10),
                                                child: tasksController
                                                        .isPendingLoading.value
                                                    ? const SizedBox(
                                                        height: 50,
                                                        width: 50,
                                                        child:
                                                            CircularProgressIndicator(),
                                                      )
                                                    : Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            (tasksController
                                                                .myListPending[0]
                                                                .projectTitle!),
                                                            softWrap: true,
                                                            maxLines: 2,
                                                            overflow:
                                                                TextOverflow.fade,
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    'Poppins',
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w800,
                                                                color: HexColor(
                                                                    '#4d4d4d')),
                                                          ),
                                                          const SizedBox(
                                                            height: 5,
                                                          ),
                                                          Text(
                                                            (tasksController
                                                                .myListPending[0]
                                                                .taskTopic),
                                                            softWrap: true,
                                                            maxLines: 2,
                                                            overflow:
                                                                TextOverflow.fade,
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    'Poppins',
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                color: HexColor(
                                                                    '#4d4d4d')),
                                                          ),
                                                        ],
                                                      ),
                                              ),
                                            )),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        SizedBox(
                                          height: Width * 0.1,
                                          // width: Width * 0.45,
                                        ),
                                        tasksController.myListPending.length > 1
                                            ? SizedBox(
                                                height: Width * 0.43,
                                                width: Width * 0.43,
                                                child: Card(
                                                  color: HexColor('#f5f5f5'),
                                                  elevation: 5,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(20),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(10),
                                                    child: tasksController
                                                            .isPendingLoading
                                                            .value
                                                        ? const SizedBox(
                                                            height: 50,
                                                            width: 50,
                                                            child:
                                                                CircularProgressIndicator(),
                                                          )
                                                        : Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                (tasksController
                                                                    .myListPending[
                                                                        0]
                                                                    .projectTitle!),
                                                                softWrap: true,
                                                                maxLines: 2,
                                                                overflow:
                                                                    TextOverflow
                                                                        .fade,
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        'Poppins',
                                                                    fontSize: 18,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w800,
                                                                    color: HexColor(
                                                                        '#4d4d4d')),
                                                              ),
                                                              const SizedBox(
                                                                height: 5,
                                                              ),
                                                              Text(
                                                                (tasksController
                                                                    .myListPending[
                                                                        0]
                                                                    .taskTopic),
                                                                softWrap: true,
                                                                maxLines: 2,
                                                                overflow:
                                                                    TextOverflow
                                                                        .fade,
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        'Poppins',
                                                                    fontSize: 12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    color: HexColor(
                                                                        '#4d4d4d')),
                                                              ),
                                                            ],
                                                          ),
                                                  ),
                                                ))
                                            : Container()
                                      ],
                                    )
                                  ],
                                )
                              : Container(),
                          const SizedBox(
                            height: 10,
                          ),
                          if (tasksController.myListInProgess.isNotEmpty)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    'In Progress',
                                    style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: HexColor('#4d4d4d')),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    Get.to(InProgressTasks());
                                    await tasksController
                                        .getUserTasksInProgress();
                                  },
                                  child: Text(
                                    'View All',
                                    style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: HexColor('#30a6d6')),
                                  ),
                                )
                              ],
                            ),
                          if (tasksController.myListInProgess.isNotEmpty)
                            CarouselSlider.builder(
                              options: CarouselOptions(
                                height: Height * 0.3,
              
                                autoPlay: true,
                                reverse: false,
                                viewportFraction: 1,
                                enlargeCenterPage: true,
                                enlargeStrategy: CenterPageEnlargeStrategy.height,
                                autoPlayInterval: const Duration(seconds: 5),
                                // onPageChanged: (index, reason) =>
                                //     setState(() => activeIndex = index),
                              ),
                              itemCount: tasksController.userTaskCount.value,
                              itemBuilder: (context, index, realIndex) {
                                if (tasksController.myListInProgess.isEmpty) {
                                  return const Text(
                                    "No Any In Progress Tasks to Display!",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: 'Poppins',
                                    ),
                                  );
                                }
                                return SizedBox(
                                  width: double.infinity,
                                  child: Card(
                                      color: 
                                      (now.isAfter(DateFormat("EEE, dd MMM yyyy HH:mm:ss 'GMT'").parseUtc(tasksController
                                                                          .myListInProgess[
                                                                              index]
                                                                          .dueDate)))?HexColor('#ff4122'):
                                              
                                              HexColor('#f5f5f5'),
                                      elevation: 5,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: InkWell(
                                        onTap: () async {
                                          tasksController.singleTaskList.clear();
                                          Get.to(SingleTask());
                                          await tasksController.getSingleTask(
                                              tasksController
                                                  .myListInProgess[index].id);
                                          await commentController.getComments(
                                              tasksController
                                                  .myListInProgess[index].id);
                                        },
                                        child: Padding(
                                            padding: const EdgeInsets.all(16),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  padding:
                                                      const EdgeInsets.all(8),
                                                  height: 40,
                                                  decoration: BoxDecoration(
                                                    color: 
                                                    (now.isAfter(DateFormat("EEE, dd MMM yyyy HH:mm:ss 'GMT'").parseUtc(tasksController
                                                                          .myListInProgess[
                                                                              index]
                                                                          .dueDate)))?HexColor('#df2c14'):
                                                    Colors.grey[350],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20), // Adjust the value to change the amount of rounding
                                                  ),
                                                  child: Text(
                                                    tasksController
                                                        .myListInProgess[index]
                                                        .category,
                                                    style: TextStyle(
                                                        fontFamily: 'Poppins',
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color:
                                                            HexColor('#4d4d4d')),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  tasksController
                                                      .myListInProgess[index]
                                                      .projectTitle!,
                                                  softWrap: false,
                                                  overflow: TextOverflow.fade,
                                                  style: TextStyle(
                                                      fontFamily: 'Poppins',
                                                      fontSize: 20,
                                                      fontWeight: FontWeight.w800,
                                                      color: HexColor('#4d4d4d')),
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  tasksController
                                                      .myListInProgess[index]
                                                      .taskTopic,
                                                  softWrap: false,
                                                  overflow: TextOverflow.fade,
                                                  style: TextStyle(
                                                      fontFamily: 'Poppins',
                                                      fontSize: 15,
                                                      fontWeight: FontWeight.w500,
                                                      color: HexColor('#4d4d4d')),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      'Due Date',
                                                      softWrap: false,
                                                      overflow: TextOverflow.fade,
                                                      style: TextStyle(
                                                          fontFamily: 'Poppins',
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: HexColor(
                                                              '#4d4d4d')),
                                                    ),
                                                    Text(
                                                      'Team Mates',
                                                      softWrap: false,
                                                      overflow: TextOverflow.fade,
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
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        const Icon(
                                                          Icons
                                                              .calendar_month_outlined,
                                                          size: 12,
                                                        ),
                                                        const SizedBox(
                                                          width: 5,
                                                        ),
                                                        Text(
                                                          DateFormat("dd/MM/yyyy")
                                                              .format(DateFormat(
                                                                      "E, dd MMM yyyy HH:mm:ss 'GMT'")
                                                                  .parse(tasksController
                                                                      .myListInProgess[
                                                                          index]
                                                                      .dueDate)),
                                                          softWrap: false,
                                                          overflow:
                                                              TextOverflow.fade,
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'Poppins',
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight.w500,
                                                              color: HexColor(
                                                                  '#4d4d4d')),
                                                        ),
                                                      ],
                                                    ),
                                                    Text(
                                                      'xx xx xx',
                                                      softWrap: false,
                                                      overflow: TextOverflow.fade,
                                                      style: TextStyle(
                                                          fontFamily: 'Poppins',
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: HexColor(
                                                              '#4d4d4d')),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            )),
                                      )),
                                );
                              },
                            ),
                          if (tasksController.myListInProgess.isEmpty &&
                              tasksController.myListPending.isEmpty)
                            const Text(
                              "Nothing to Display!",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Poppins',
                              ),
                            )
                        ],
                      ),
                      // Row(
                      //   children: [],
                      // )
                    ],
                  ),
                ),
              ),
            ))));
  }
}
