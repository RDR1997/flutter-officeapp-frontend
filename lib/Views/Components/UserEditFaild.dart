import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserEditFaild extends StatelessWidget {
  const UserEditFaild({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Delayed redirection to the previous page
    Future.delayed(const Duration(seconds: 1), () {
      Get.back(); // Redirecting to the previous page
    });

    return const AlertDialog(
      title: Text('User Edit Failed'),
      content: Icon(
        Icons.warning_amber_rounded,
        color: Colors.red,
        size: 100,
      ),
      actions: <Widget>[],
    );
  }
}
