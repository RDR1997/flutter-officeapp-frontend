import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:intl/intl.dart';
import '../Controllers/CommentController.dart';
import '../Controllers/HomeController.dart';
import '../Controllers/LoginController.dart';
import '../Controllers/NavBarController.dart';
import '../Controllers/ProjectController.dart';
import '../Controllers/TasksController.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'package:carousel_slider/carousel_slider.dart';

import '../Models/Comments.dart';
import 'EditTaskPopup.dart';

class SingleTask extends StatelessWidget {
  final projectsController = Get.put(ProjectController());
  final tasksController = Get.put(TasksController());
  final commentController = Get.put(CommentController());
  final navBarController = Get.put(NavBarController());
  final loginController = Get.put(LoginController());
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();


  SingleTask({super.key});

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now().toLocal();

    final Height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    final Width = MediaQuery.of(context).size.width;

    return GetX<TasksController>(
        builder: (controller) => Scaffold(
              extendBody: true,

              floatingActionButton:

             navBarController.auth_level.value == 3 || (navBarController.auth_level.value == 2 && loginController.user_id.value == tasksController.singleTaskList[0].createdBy)?


              Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              print('taped!!');
              projectsController.toggleIsEpanded();
              print(projectsController.isExpanded.value);
            },
            child: 
            projectsController.isExpanded.value?
            Icon(Icons.keyboard_arrow_right_rounded):
            Icon(Icons.keyboard_arrow_left_rounded),
          ),
          AnimatedContainer(
            duration: Duration(milliseconds: 300),
            width: projectsController.isExpanded.value ? 150 : 0,
            height: projectsController.isExpanded.value ? 100 : 0,
            curve: Curves.easeInOut,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FloatingActionButton(
                      onPressed: () async {

              projectsController.toggleIsEpanded();
              Get.bottomSheet(
                          const EditTaskPopup(),
                          enterBottomSheetDuration: const Duration(seconds: 1),
                        );
                        await tasksController.getSubordinates();


                      },
                      child: const Icon(Icons.edit),
                    ),

                FloatingActionButton(
                  onPressed: () async {
              projectsController.toggleIsEpanded();

                  },
                  child: Icon(Icons.delete),
                ),
              ],
            ),
          ),
        ],
      ):
      // navBarController.auth_level.value == 2?
      //              Row(
      //   mainAxisAlignment: MainAxisAlignment.end,
      //   children: [
      //     FloatingActionButton(
      //       onPressed: () {
      //         print('taped!!');
      //         projectsController.toggleIsEpanded();
      //         print(projectsController.isExpanded.value);
      //       },
      //       child: 
      //       projectsController.isExpanded.value?
      //       Icon(Icons.keyboard_arrow_right_rounded):
      //       Icon(Icons.keyboard_arrow_left_rounded),
      //     ),
      //     AnimatedContainer(
      //       duration: Duration(milliseconds: 300),
      //       width: projectsController.isExpanded.value ? 150 : 0,
      //       height: projectsController.isExpanded.value ? 100 : 0,
      //       curve: Curves.easeInOut,
      //       child: Row(
      //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //         children: [
      //           FloatingActionButton(
      //                 onPressed: () async {

      //         projectsController.toggleIsEpanded();


      //                 },
      //                 child: const Icon(Icons.edit),
      //               ),

      //           FloatingActionButton(
      //             onPressed: () async {
      //         projectsController.toggleIsEpanded();

      //             },
      //             child: Icon(Icons.delete),
      //           ),
      //         ],
      //       ),
      //     ),
      //   ],
      // )
      // : 
      null,



              body: RefreshIndicator(
                      key: _refreshIndicatorKey,
                      color: Colors.white,
                      backgroundColor: HexColor("#30a6d6"),
                      strokeWidth: 3.0,
                      onRefresh: () async {
                        await tasksController.getSingleTask(tasksController.singleTaskList[0].id);

                        return Future<void>.delayed(
                            const Duration(seconds: 2));
                      },

                      child: SingleChildScrollView(
              child: SizedBox(
                height: Height*1.05,
                child:
                 tasksController.singleTaskList.isEmpty
                    ? Container(
                        height: Height,
                        alignment: Alignment.center,
                        child: const CircularProgressIndicator())
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            color: 
                            (now.isAfter(DateFormat("EEE, dd MMM yyyy HH:mm:ss 'GMT'").parseUtc(tasksController
                                                            .singleTaskList[0]
                                                            .dueDate)))?HexColor('#ff4122'):
                                            
                                           
                            HexColor('#30a6d6'),
                            child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 20.0, right: 20, bottom: 10, top: 30),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            'Category : ',
                                            softWrap: true,
                                            maxLines: 1,
                                            overflow: TextOverflow.fade,
                                            style: TextStyle(
                                                fontFamily: 'Poppins',
                                                fontSize: 15,
                                                fontWeight: FontWeight.w800,
                                                color: HexColor('#f5f5f5')),
                                          ),
                                          Text(
                                            tasksController
                                                .singleTaskList[0].category,
                                            softWrap: true,
                                            maxLines: 1,
                                            overflow: TextOverflow.fade,
                                            style: TextStyle(
                                                fontFamily: 'Poppins',
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500,
                                                color: HexColor('#f5f5f5')),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        tasksController
                                            .singleTaskList[0].taskTopic,
                                        softWrap: true,
                                        maxLines: 2,
                                        overflow: TextOverflow.fade,
                                        style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 30,
                                            fontWeight: FontWeight.w800,
                                            color: HexColor('#f5f5f5')),
                                      ),
                                      // const SizedBox(
                                      //   height: 10,
                                      // ),
                                      Row(
                                        children: [
                                          Text(
                                            'Project : ',
                                            softWrap: true,
                                            maxLines: 1,
                                            overflow: TextOverflow.fade,
                                            style: TextStyle(
                                                fontFamily: 'Poppins',
                                                fontSize: 15,
                                                fontWeight: FontWeight.w800,
                                                color: HexColor('#f5f5f5')),
                                          ),
                                          Text(
                                            tasksController.singleTaskList[0]
                                                .projectTitle!,
                                            softWrap: true,
                                            maxLines: 1,
                                            overflow: TextOverflow.fade,
                                            style: TextStyle(
                                                fontFamily: 'Poppins',
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500,
                                                color: HexColor('#f5f5f5')),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                'Status : ',
                                                softWrap: true,
                                                maxLines: 1,
                                                overflow: TextOverflow.fade,
                                                style: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w800,
                                                    color: HexColor('#f5f5f5')),
                                              ),
                                              tasksController
                                                    .singleTaskList[0].status != "pending"?
                                              Text(
                                                      tasksController.viewStatus.value
,
                                                softWrap: true,
                                                maxLines: 1,
                                                overflow: TextOverflow.fade,
                                                style: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w500,
                                                    color: HexColor('#f5f5f5')),
                                              )
                                              
                                              // :
                                              // tasksController
                                              //       .singleTaskList[0].status == "in_progress"?
                                              // Text(
                                              //   "In Progress",
                                              //   softWrap: true,
                                              //   maxLines: 1,
                                              //   overflow: TextOverflow.fade,
                                              //   style: TextStyle(
                                              //       fontFamily: 'Poppins',
                                              //       fontSize: 15,
                                              //       fontWeight: FontWeight.w500,
                                              //       color: HexColor('#f5f5f5')),
                                              // )
                                              
                                              :
                                              Text(
                                                "Pending",
                                                softWrap: true,
                                                maxLines: 1,
                                                overflow: TextOverflow.fade,
                                                style: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w500,
                                                    color: HexColor('#f5f5f5')),
                                              ),

                                            ],
                                          ),
                                          tasksController.singleTaskList[0].status != "pending"?
                                          
                                              TextButton(
                                                onPressed:() async {
                                                  tasksController.toggleStatusAction();
                                                }, 
                                                child: Text(
                                                    tasksController.statusAction.value,
                                                    softWrap: true,
                                                    maxLines: 1,
                                                    overflow: TextOverflow.fade,
                                                    style: TextStyle(
                                                        fontFamily: 'Poppins',
                                                        fontSize: 10,
                                                        fontWeight: FontWeight.w500,
                                                        color: HexColor('#f5f5f5'),
                                                        decoration:TextDecoration.underline),
                                                  )):SizedBox.shrink(), 
                                            //       Icon(Icons.done,
                                            // color: Colors.green,)
                                          
                                          // :
                                          // tasksController.singleTaskList[0].status == "completed"?
                                          // Row(
                                          //   children: [
                                          //     TextButton(
                                          //       onPressed:() {}, 
                                          //       child: Text(
                                          //           "Mark as in progress",
                                          //           softWrap: true,
                                          //           maxLines: 1,
                                          //           overflow: TextOverflow.fade,
                                          //           style: TextStyle(
                                          //               fontFamily: 'Poppins',
                                          //               fontSize: 10,
                                          //               fontWeight: FontWeight.w500,
                                          //               color: HexColor('#f5f5f5'),
                                          //               decoration:TextDecoration.underline),
                                          //         )), Icon(Icons.restart_alt_sharp,
                                          //   color: Colors.orange,)
                                          //   ],
                                          // ):SizedBox.shrink()


                                        ],
                                      ),
                                      // const SizedBox(
                                      //   height: 10,
                                      // ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Start Date : ',
                                                softWrap: true,
                                                maxLines: 1,
                                                overflow: TextOverflow.fade,
                                                style: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w800,
                                                    color: HexColor('#f5f5f5')),
                                              ),
                                              Text(
                                                DateFormat("dd/MM/yyyy").format(
                                                    DateFormat(
                                                            "E, dd MMM yyyy HH:mm:ss 'GMT'")
                                                        .parse(tasksController
                                                            .singleTaskList[0]
                                                            .startDate)),
                                                softWrap: true,
                                                maxLines: 1,
                                                overflow: TextOverflow.fade,
                                                style: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w500,
                                                    color: HexColor('#f5f5f5')),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Due Date : ',
                                                softWrap: true,
                                                maxLines: 1,
                                                overflow: TextOverflow.fade,
                                                style: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w800,
                                                    color: HexColor('#f5f5f5')),
                                              ),
                                              Text(
                                                DateFormat("dd/MM/yyyy").format(
                                                    DateFormat(
                                                            "E, dd MMM yyyy HH:mm:ss 'GMT'")
                                                        .parse(tasksController
                                                            .singleTaskList[0]
                                                            .dueDate)),
                                                softWrap: true,
                                                maxLines: 1,
                                                overflow: TextOverflow.fade,
                                                style: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w500,
                                                    color: HexColor('#f5f5f5')),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          const Spacer(
                                            flex: 1,
                                          ),
                                          Text(
                                            '- ${tasksController.singleTaskList[0].created_by_name} | ',
                                            softWrap: true,
                                            maxLines: 1,
                                            overflow: TextOverflow.fade,
                                            style: TextStyle(
                                                fontFamily: 'Poppins',
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                                color: HexColor('#f5f5f5')),
                                          ),
                                          Text(
                                            DateFormat("dd/MM/yyyy -").format(
                                                DateFormat(
                                                        "E, dd MMM yyyy HH:mm:ss 'GMT'")
                                                    .parse(tasksController
                                                        .singleTaskList[0]
                                                        .createdDate)),
                                            softWrap: true,
                                            maxLines: 1,
                                            overflow: TextOverflow.fade,
                                            style: TextStyle(
                                                fontFamily: 'Poppins',
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                                color: HexColor('#f5f5f5')),
                                          ),
                                        ],
                                      ),
                                    ])),
                          ),
                          Padding(
                              padding: const EdgeInsets.only(
                                  left: 20.0, right: 20, bottom: 10, top: 10),
                              child: Column(
                                  // mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Description : ',
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
                                      tasksController
                                          .singleTaskList[0].description,
                                      // softWrap: true,
                                      // maxLines: 1,
                                      // overflow: TextOverflow.fade,
                                      style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                          color: HexColor('#4d4d4d')),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.only(top: 20),
                                      child: Text(
                                        'Comments ',
                                        softWrap: true,
                                        maxLines: 1,
                                        overflow: TextOverflow.fade,
                                        style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 15,
                                            fontWeight: FontWeight.w800,
                                            color: HexColor('#4d4d4d')),
                                      ),
                                    ),
                                    commentController.commentList.isEmpty
                                        ? Container(
                                            alignment: Alignment.center,
                                            padding:
                                                const EdgeInsets.only(top: 20),
                                            child: Text(
                                              'No Comments to Display',
                                              softWrap: true,
                                              maxLines: 1,
                                              overflow: TextOverflow.fade,
                                              style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.grey[500]),
                                            ),
                                          )
                                        : StreamBuilder<List<Comment>>(
                                            stream:
                                                commentController.commentStream,
                                            builder: (context, snapshot) {
                                              List<Comment> comments =
                                                  snapshot.data ?? [];

                                              return ListView.builder(
                                                  shrinkWrap: true,
                                                  // reverse: true,
                                                  physics:
                                                      const NeverScrollableScrollPhysics(),
                                                  scrollDirection:
                                                      Axis.vertical,
                                                  itemCount: commentController
                                                      .commentList.length,
                                                  itemBuilder: (rowContext,
                                                          index) =>
                                                      Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  bottom: 10),
                                                          child: Container(
                                                            width: Width,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: HexColor(
                                                                  '#f5f5f5'),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20),
                                                            ),
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(10),
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                  commentController
                                                                      .commentList[
                                                                          index]
                                                                      .created_by_name!,
                                                                  softWrap:
                                                                      true,
                                                                  maxLines: 1,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .fade,
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          'Poppins',
                                                                      fontSize:
                                                                          12,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w800,
                                                                      color: HexColor(
                                                                          '#4d4d4d')),
                                                                ),
                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      left:
                                                                          10.0),
                                                                  child: Text(
                                                                    commentController
                                                                        .commentList[
                                                                            index]
                                                                        .comment,
                                                                    softWrap:
                                                                        true,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .fade,
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
                                                                ),
                                                                Row(
                                                                  children: [
                                                                    const Spacer(
                                                                      flex: 1,
                                                                    ),
                                                                    Text(
                                                                      DateFormat("dd/MM/yyyy").format(DateFormat("E, dd MMM yyyy HH:mm:ss 'GMT'").parse(commentController
                                                                          .commentList[
                                                                              index]
                                                                          .createdDate)),
                                                                      softWrap:
                                                                          true,
                                                                      maxLines:
                                                                          1,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .fade,
                                                                      style: TextStyle(
                                                                          fontFamily:
                                                                              'Poppins',
                                                                          fontSize:
                                                                              12,
                                                                          fontWeight: FontWeight
                                                                              .w500,
                                                                          color:
                                                                              HexColor('#4d4d4d')),
                                                                    ),
                                                                  ],
                                                                )
                                                              ],
                                                            ),
                                                          )));
                                            },
                                          ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    TextFormField(
                                      minLines: 1,
                                      maxLines: 10,
                                      controller: commentController
                                          .commentTextController,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "Comment";
                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                        focusedBorder: const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(50.0)),
                                          borderSide: BorderSide(
                                            color: Color.fromARGB(
                                                255, 158, 158, 158),
                                            style: BorderStyle.solid,
                                          ),
                                        ),
                                        border: const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(50.0)),
                                          borderSide: BorderSide(
                                            color: Color.fromARGB(
                                                255, 158, 158, 158),
                                            style: BorderStyle.none,
                                          ),
                                        ),
                                        suffixIcon: IconButton(
                                          icon: Icon(
                                            Icons.send_rounded,
                                            color: HexColor('#30a6d6'),
                                          ),
                                          onPressed: () async {
                                            await commentController.addComment(
                                                (tasksController
                                                        .singleTaskList[0].id)
                                                    .toString(),
                                                commentController
                                                    .commentTextController
                                                    .text);
                                            commentController
                                                .commentTextController
                                                .clear();
                                            await commentController.getComments(
                                                tasksController
                                                    .singleTaskList[0].id);
                                          },
                                        ),
                                      ),
                                    ),
                                  ]))
                        ],
                      ),
              ),
            ))));
  }
}
