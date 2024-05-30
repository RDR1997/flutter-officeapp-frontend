import 'package:flutter/material.dart';

class StartPage extends StatelessWidget {
  StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    final Width = MediaQuery.of(context).size.width;
    return Scaffold(
      // backgroundColor: Colors.lightBlue,
      body: Container(
          width: Width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              stops: [0.1, 0.5, 0.7, 0.9],
              colors: [
                Colors.lightBlue[400] as Color,
                Colors.lightBlue[500] as Color,
                Colors.cyan[400] as Color,
                Colors.cyan[300] as Color,
              ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [],
            ),
          )),
    );
  }
}
