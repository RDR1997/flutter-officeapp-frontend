import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:officeapp/Controllers/AdminController.dart';
import 'package:officeapp/Views/AllUsers.dart';
import 'package:officeapp/Views/AllProjects.dart';

import '../../Controllers/LoginController.dart';
import '../../Controllers/ProjectController.dart';
import '../Login.dart';

class SidePanel extends StatelessWidget {
  SidePanel({super.key});
  final loginController = Get.put(LoginController());
  final adminController = Get.put(AdminController());
  final projectsController = Get.put(ProjectController());

  @override
  Widget build(BuildContext context) {
    final Height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    final Width = MediaQuery.of(context).size.width;
    return Drawer(
      child: ListView(
        padding: EdgeInsets.only(top: 80),
        children: [
          ListTile(
            leading: const Icon(Icons.supervised_user_circle_outlined),
            title: const Text(
              "Manage Users",
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            onTap: () async {
              await adminController.getAllusers();
              Get.to(AllUsers());
            },
          ),
          ListTile(
            leading: const Icon(Icons.workspaces),
            title: const Text(
              "Manage Projects",
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            onTap: () async {
              await projectsController.getProjects();
              Get.to(AllProjects());
            },
          ),
          // ListTile(
          //   leading: Icon(Icons.receipt_long_sharp),
          //   title: const Text(
          //     "Invoices",
          //     style: TextStyle(fontWeight: FontWeight.w500),
          //   ),
          //   onTap: () {},
          // ),
          // ListTile(
          //   leading: Icon(Icons.paid_sharp),
          //   title: const Text(
          //     "Packages",
          //     style: TextStyle(fontWeight: FontWeight.w500),
          //   ),
          //   onTap: () {},
          // ),
          const Divider(),
          ListTile(
            leading: Icon(Icons.logout),
            title: const Text(
              "Log Out",
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            onTap: () async {
              await loginController.logout();
              Get.off(Login());
            },
          ),
        ],
      ),
    );
  }
}
