import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TaskAddFaild extends StatelessWidget {
  const TaskAddFaild({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Delayed redirection to the previous page
    Future.delayed(const Duration(seconds: 1), () {
      Get.back(); // Redirecting to the previous page
    });

    return const AlertDialog(
      title: Text('Task Add Failed'),
      content: Icon(
        Icons.warning_amber_rounded,
        color: Colors.red,
        size: 100,
      ),
      actions: <Widget>[],
    );
  }
}
