import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart'; // Import shared_preferences
import '../Models/Environment.dart';
import '../main.dart';

class FirebaseApi {
  // create an instance of FB Messaging
  final _firebaseMessaging = FirebaseMessaging.instance;

  // function to initialize notifications
  Future<void> initNotifications() async {
    // request permission from user
    await _firebaseMessaging.requestPermission();

    // fetch the FCM token for this device
    final fcmToken = await _firebaseMessaging.getToken();
    ('FCM Token: $fcmToken');

    // Store FCM token in local storage
    await _saveFCMToken(fcmToken);

    // initiate further settings for push notification
    initPushNotifications();
  }

  // Function to handle received message
  void handleMessage(RemoteMessage? message) {
    // if the message is null
    if (message == null) return;
    // else navigate to notification page
    navigatorKey.currentState?.pushNamed(
      '/notifications',
      arguments: message,
    );
  }

  // Function to initialize background settings
  Future initPushNotifications() async {
    // handle notification if the app was terminated and now opened
    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
    // attach event listener for when a notification opens the app
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
  }

  // Function to save FCM token in local storage
  Future<void> _saveFCMToken(String? token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('fcm_token', token ?? '');
  }

  Future<String?> getFCMToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('fcm_token');
    // ('88888888888888888888888888888888');
    // (prefs.getString('fcm_token'));
    // ('88888888888888888888888888888888');
  }
}
