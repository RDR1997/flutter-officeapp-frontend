import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:intl/intl.dart';
import 'package:officeapp/Controllers/TasksController.dart';
import '../Controllers/CommentController.dart';
import '../Controllers/NotificationController.dart';
import 'SingleTask.dart';

class PendingTasks extends StatelessWidget {
  final tasksController = Get.put(TasksController());
  final commentController = Get.put(CommentController());
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  PendingTasks({super.key});

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now().toLocal();

    final Height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    final Width = MediaQuery.of(context).size.width;

    return GetX<NotificationController>(
        builder: (controller) => Scaffold(
            extendBody: true,
            body: RefreshIndicator(
                      key: _refreshIndicatorKey,
                      color: Colors.white,
                      backgroundColor: HexColor("#30a6d6"),
                      strokeWidth: 3.0,
                      onRefresh: () async {
                       
                        await tasksController.getUserTasksPending();
                        return Future<void>.delayed(
                            const Duration(seconds: 2));
                      },

                      child: SingleChildScrollView(
              child: tasksController.myListPending.isEmpty
                  ? Container(
                      height: Height,
                      alignment: Alignment.center,
                      child: const CircularProgressIndicator())
                  : Padding(
                      padding: const EdgeInsets.only(
                          left: 20.0, right: 20, bottom: 20, top: 30),
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Pending Tasks',
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 25,
                                  fontWeight: FontWeight.w800,
                                  color: HexColor('#4d4d4d')),
                            ),
                          ),
                          // const SizedBox(
                          //   height: 10,
                          // ),
                          SizedBox(
                              height: Height * 0.95,
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  // reverse: true,
                                  physics: BouncingScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                                  itemCount:
                                      tasksController.myListPending.length,
                                  itemBuilder: (rowContext, index) => SizedBox(
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
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: InkWell(
                                              onTap: () async {
                                                tasksController.singleTaskList
                                                    .clear();
                                                Get.to(SingleTask());
                                                await tasksController
                                                    .getSingleTask(
                                                        tasksController
                                                            .myListPending[
                                                                index]
                                                            .id);
                                                await commentController
                                                    .getComments(tasksController
                                                        .myListPending[index]
                                                        .id);
                                              },
                                              child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(16),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        tasksController
                                                            .myListPending[
                                                                index]
                                                            .projectTitle!,
                                                        softWrap: false,
                                                        overflow:
                                                            TextOverflow.fade,
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'Poppins',
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight.w800,
                                                            color: HexColor(
                                                                '#4d4d4d')),
                                                      ),
                                                      const SizedBox(
                                                        height: 5,
                                                      ),
                                                      Text(
                                                        tasksController
                                                            .myListPending[
                                                                index]
                                                            .taskTopic,
                                                        softWrap: false,
                                                        overflow:
                                                            TextOverflow.fade,
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
                                                        height: 10,
                                                      ),
                                                      Row(
                                                        // mainAxisAlignment:
                                                        //     MainAxisAlignment
                                                        //         .spaceBetween,
                                                        children: [
                                                          Text(
                                                            'Due Date :  ',
                                                            softWrap: false,
                                                            overflow:
                                                                TextOverflow
                                                                    .fade,
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    'Poppins',
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                color: HexColor(
                                                                    '#4d4d4d')),
                                                          ),
                                                          Row(
                                                            children: [
                                                              const Icon(
                                                                Icons
                                                                    .calendar_month_outlined,
                                                                size: 15,
                                                              ),
                                                              const SizedBox(
                                                                width: 5,
                                                              ),
                                                              Text(
                                                                DateFormat("dd/MM/yyyy").format(DateFormat(
                                                                        "E, dd MMM yyyy HH:mm:ss 'GMT'")
                                                                    .parse(tasksController
                                                                        .myListPending[
                                                                            index]
                                                                        .dueDate as String)),
                                                                softWrap: false,
                                                                overflow:
                                                                    TextOverflow
                                                                        .fade,
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        'Poppins',
                                                                    fontSize:
                                                                        15,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    color: HexColor(
                                                                        '#4d4d4d')),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  )),
                                            )),
                                      )))
                        ],
                      ),
                    ),
            ))));
  }
}
