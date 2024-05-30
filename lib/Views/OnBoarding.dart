import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'Login.dart';
import 'StartPage.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:introduction_screen/introduction_screen.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({super.key});

  @override
  OnBoardingState createState() => OnBoardingState();
}

class OnBoardingState extends State<OnBoarding> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Get.off(StartPage());
  }

  Widget _buildFullscreenImage() {
    return Image.asset(
      'assets/fullscreen.jpg',
      fit: BoxFit.cover,
      height: double.infinity,
      width: double.infinity,
      alignment: Alignment.center,
    );
  }

  Widget _buildImage(String assetName, [double width = 260]) {
    return Column(
      children: [
        const SizedBox(
          height: 100,
        ),
        Image.asset('assets/images/$assetName', width: width)
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(
        fontFamily: 'Poppins',
        fontSize: 18,
        fontWeight: FontWeight.w500,
        // color: HexColor('#4d4d4d')
        );
    const titleStyle = TextStyle(
        fontFamily: 'Poppins',
        fontSize: 28,
        fontWeight: FontWeight.w700,
        // color: HexColor('#4d4d4d')
        );
    const pageDecoration = PageDecoration(
        imagePadding: EdgeInsets.only(bottom: 0),
        contentMargin: EdgeInsets.only(left: 10.0, right: 10),
        titleTextStyle: titleStyle,
        titlePadding: EdgeInsets.only(top: 60.0, bottom: 24.0),
        footerPadding: EdgeInsets.only(bottom: 0.0),
        bodyTextStyle: bodyStyle,

        // bodyPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
        pageColor: Colors.white,
        safeArea: 0);
const fullPageDecoration = PageDecoration(
        imagePadding: EdgeInsets.only(bottom: 0),
        contentMargin: EdgeInsets.only(left: 10.0, right: 10),
        titleTextStyle: titleStyle,
        titlePadding: EdgeInsets.only(top: 350, bottom: 24.0),
        footerPadding: EdgeInsets.only(bottom: 0.0),
        bodyTextStyle: bodyStyle,

        // bodyPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
        pageColor: Colors.white,
        safeArea: 0);


    return IntroductionScreen(
      key: introKey,
      globalBackgroundColor: Colors.white,
      allowImplicitScrolling: true,
      // autoScrollDuration: 3000,

      pages: [
        PageViewModel(
          title: "Welcome to OfficeAPP!",
          body: "In today's fast-paced world, effective task management is crucial for maximizing productivity and achieving success. As a employee, you play a vital role in the success of your team and organization. Here's why our task management app is indispensable for you:",
          // image: _buildFullscreenImage(),
          decoration: fullPageDecoration
        ),
        PageViewModel(
          title: "Efficiency Boost",
          body:
              "With OfficeAPP, you can streamline your workflow, prioritize tasks, and stay organized. Say goodbye to cluttered to-do lists and missed deadlines.",
          image: Icon(
                Icons.rocket_launch,
                size: 200,
                color: HexColor("#30a6d6"),
              ),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Clear Communication",
          body:
              "Our app facilitates clear communication between employees and their superiors. You can receive instructions, ask questions, and provide updates seamlessly, ensuring everyone is on the same page.",
          image: Icon(
                Icons.support_agent,
                size: 200,
                color: HexColor("#30a6d6"),
              ),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Empowerment",
          body:
              "Take control of your workday by breaking down tasks into manageable chunks. OfficeAPP empowers you to set goals, track progress, and take ownership of your responsibilities.",
          image: Icon(
                Icons.groups_3,
                size: 200,
                color: HexColor("#30a6d6"),
              ),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Collaborative Advantage",
          body:
              "Collaborate effectively with your team members by sharing tasks, files, and feedback within the app. Together, you can accomplish more and achieve your objectives faster.",
          image: Icon(
                Icons.supervisor_account,
                size: 200,
                color: HexColor("#30a6d6"),
              ),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Insightful Analytics",
          body:
              "Gain valuable insights into your productivity patterns and areas for improvement. Our app provides detailed analytics to help you optimize your performance over time.",
          image: Icon(
                Icons.analytics_outlined,
                size: 200,
                color: HexColor("#30a6d6"),
              ),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "OfficeAPP",
          body:
              "Remember, success is not just about working hard—it's about working smart. Start your journey towards enhanced productivity and professional growth with OfficeAPP today! \n\nReady to take charge of your tasks? Let's get started!",
          // image: _buildFullscreenImage(),
          decoration: fullPageDecoration
        )
      ],
      onDone: () => _onIntroEnd(context),
      onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: true,
      skipOrBackFlex: 0,
      nextFlex: 0,
      showBackButton: false,
      //rtl: true, // Display as right-to-left
      back: const Icon(Icons.arrow_back),
      skip: const Text('Skip', style: TextStyle(fontWeight: FontWeight.w600)),
      next: const Icon(Icons.arrow_forward),
      done: const Text('Done', style: TextStyle(fontWeight: FontWeight.w600)),
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: const EdgeInsets.all(16),
      controlsPadding: kIsWeb
          ? const EdgeInsets.all(12.0)
          : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
      dotsContainerDecorator: const ShapeDecoration(
        color: Colors.black87,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
      ),
    );
  }
}
