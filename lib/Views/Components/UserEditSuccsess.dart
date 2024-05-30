import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserEditSuccsess extends StatelessWidget {
  const UserEditSuccsess({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Delayed redirection to the previous page
    Future.delayed(const Duration(seconds: 1), () {
      Get.back(); // Redirecting to the previous page
    });

    return const AlertDialog(
      title: Text('User Edited Successfully'),
      content: Icon(
        Icons.done_all_rounded,
        color: Colors.green,
        size: 100,
      ),
      actions: <Widget>[],
    );
  }
}
