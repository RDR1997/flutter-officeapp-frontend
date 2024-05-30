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

class Notifications extends StatelessWidget {
  final notificationController = Get.put(NotificationController());
  final taskController = Get.put(TasksController());
  final commentController = Get.put(CommentController());
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  Notifications({super.key});

  @override
  Widget build(BuildContext context) {
    final Height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    final Width = MediaQuery.of(context).size.width;

    return GetX<NotificationController>(
        builder: (controller) => Scaffold(
            extendBody: true,
            body: 
              RefreshIndicator(
                      key: _refreshIndicatorKey,
                      color: Colors.white,
                      backgroundColor: HexColor("#30a6d6"),
                      strokeWidth: 3.0,
                      onRefresh: () async {
                        await notificationController.getNotification();

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
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Notifications',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 25,
                            fontWeight: FontWeight.w800,
                            color: HexColor('#4d4d4d')),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    notificationController.notificationList.isEmpty
                        ? const Text(
                            "No Notifications to Display!",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Poppins',
                            ),
                          )
                        : SizedBox(
                            height: Height * 0.6,
                            child: ListView.separated(
                              shrinkWrap: true,
                              // reverse: true,
                              physics: BouncingScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              itemCount: notificationController
                                  .notificationListCount.value,
                              separatorBuilder: (context, index) =>
                                  const Divider(
                                height: 2.0,
                              ),
                              itemBuilder: (rowContext, index) => InkWell(
                                  onTap: () async {
                                    notificationController.changeReadStatus(
                                        (notificationController
                                                .notificationList[index].id)
                                            .toString());
                                    taskController.singleTaskList.clear();
                                    Get.to(SingleTask());
                                    notificationController.getNotification();
                                    await taskController.getSingleTask(
                                        notificationController
                                            .notificationList[index].id);
                                    await commentController.getComments(
                                        notificationController
                                            .notificationList[index].id);
                                  },
                                  child: SizedBox(
                                      height: Height * 0.12,
                                      child: Container(
                                          padding: const EdgeInsets.all(5),
                                          color: notificationController
                                                      .notificationList[index]
                                                      .isRead ==
                                                  1
                                              ? null
                                              : Colors.grey[200],
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                notificationController
                                                    .notificationList[index]
                                                    .title,
                                                softWrap: true,
                                                maxLines: 1,
                                                overflow: TextOverflow.fade,
                                                style: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w800,
                                                    color: HexColor('#4d4d4d')),
                                              ),
                                              Text(
                                                notificationController
                                                    .notificationList[index]
                                                    .description,
                                                softWrap: true,
                                                maxLines: 1,
                                                overflow: TextOverflow.fade,
                                                style: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w500,
                                                    color: HexColor('#4d4d4d')),
                                              ),
                                              Container(
                                                alignment:
                                                    Alignment.bottomRight,
                                                child: Text(
                                                  DateFormat(
                                                          "dd/MM/yyyy | HH:mm")
                                                      .format(DateFormat(
                                                              "E, dd MMM yyyy HH:mm:ss 'GMT'")
                                                          .parse(notificationController
                                                              .notificationList[
                                                                  index]
                                                              .createdDate)),
                                                  softWrap: true,
                                                  maxLines: 1,
                                                  overflow: TextOverflow.fade,
                                                  style: TextStyle(
                                                      fontFamily: 'Poppins',
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color:
                                                          HexColor('#4d4d4d')),
                                                ),
                                              )
                                            ],
                                          )))),
                            ),
                          ),
                  ],
                ),
              ),)
            ))));
  }
}
