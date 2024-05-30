import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:officeapp/Views/Notifications.dart';
import 'package:officeapp/Views/Project.dart';

import '../Controllers/NavBarController.dart';
import '../Controllers/TasksController.dart';
import 'Popup.dart';
import 'Home.dart';
import 'Profile.dart';

class NavBar extends StatelessWidget {
  final navBarController = Get.put(NavBarController());
  final tasksController = Get.put(TasksController());

  NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final Height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    final Width = MediaQuery.of(context).size.width;

    return GetX<NavBarController>(
        builder: (controller) => Scaffold(
              extendBody: true,
              appBar: CustomAppBar(
                  line1: 'Hi ${navBarController.userName} !',
                  line2:
                      'You have ${tasksController.userTaskCount} task in progress',
                  imageUrl: navBarController.proPicUrl.value),
              body: PageView(
                controller: navBarController.pageController,
                onPageChanged: (index) {
                  navBarController.selectedIndex.value = index;
                },
                children: [
                  Home(),
                  Notifications(),
                  Project(),
                  Profile(),
                ],
              ),
              bottomNavigationBar: Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: DotNavigationBar(
                  margin: const EdgeInsets.only(left: 10, right: 10),
                  currentIndex: navBarController.selectedIndex.value,
                  dotIndicatorColor: HexColor('#f5f5f5'),
                  unselectedItemColor: HexColor('#f5f5f5'),
                  selectedItemColor: HexColor('#f5f5f5'),
                  splashBorderRadius: 50,
                  backgroundColor: HexColor('#30a6d6'),
                  // enableFloatingNavBar: false,
                  onTap: (index) {
                    navBarController.selectedIndex.value = index;
                    navBarController.pageController.animateToPage(index,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.ease);
                  },
                  items: [
                    /// Home
                    DotNavigationBarItem(
                      icon: const Icon(Icons.home),
                    ),

                    /// Likes
                    DotNavigationBarItem(
                      icon: const Icon(Icons.notifications_active_rounded),
                    ),

                    /// Search
                    DotNavigationBarItem(
                      icon: const Icon(Icons.workspaces),
                    ),

                    /// Profile
                    DotNavigationBarItem(
                      icon: const Icon(Icons.person),
                    ),
                  ],
                ),
              ),
              floatingActionButton: navBarController.auth_level.value == 2
                  ? FloatingActionButton(
                      onPressed: () async {
                        Get.bottomSheet(
                          const Popup(),
                          enterBottomSheetDuration: const Duration(seconds: 1),
                        );
                        await tasksController.getSubordinates();
                        await projectsController.getProjects();
                      },
                      child: const Icon(Icons.add),
                    )
                  : null,
            ));
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  // final Widget title;
  final String line1;
  final String line2;
  final String imageUrl;

  const CustomAppBar({
    super.key,
    required this.line1,
    required this.line2,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    final Height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    return SizedBox(
      height: Height * 0.23,
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(50.0),
          bottomRight: Radius.circular(50.0),
        ),
        child: AppBar(
          toolbarHeight: Height * 0.15,
          titleSpacing: 20,

          title: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 10, top: 5, bottom: 10),
                child: Text(
                  line1,
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: HexColor('#f5f5f5')),
                ),
              ),
              Text(
                line2,
                softWrap: true,
                maxLines: 2,
                overflow: TextOverflow.fade,
                style: TextStyle(
                    height: 1.0,
                    fontFamily: 'Poppins',
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: HexColor('#f5f5f5')),
              ),
            ],
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: CircleAvatar(
                backgroundImage:
                    NetworkImage(imageUrl), // Replace with your image URL
              ),
            ),
          ],

          elevation: 0,
          backgroundColor: HexColor(
              '#30a6d6'), // Customize your AppBar background color here
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(200);
}
