import 'dart:convert';
import 'dart:async'; // Import async library
import 'package:get/get.dart';
import 'package:officeapp/Models/Environment.dart';
import 'package:http/http.dart' as http;
import '../Models/Notifis.dart';
import 'LoginController.dart';

class NotificationController extends GetxController {
  final loginController = Get.put(LoginController());

  var notificationList = <Notifi>[].obs;
  var notificationListCount = 0.obs;
  var isNotificationRead = false.obs;

  var isNotificationLoading = true.obs;

  @override
  void onInit() {
    getNotification();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  getNotification() async {
    var notificaationData = await fetchNotification();
    notificationListCount.value = notificaationData.notifications.length;
    List<Notifi> notificationDataList = notificaationData.notifications;

  
    notificationList.value = notificationDataList;
  }

  Future<Notifis> fetchNotification() async {
    final url = "${Environment().api}/view-notification";
    final response = await http.get(Uri.parse(url), headers: {
      'Accept': 'application/json',
      'Cookie': loginController.cookie.value,
    });
    var result = jsonDecode(response.body);
    return Notifis.fromJson(result);
  }

  changeReadStatus(String id) async {
    final url = "${Environment().api}/notification-read";
    final response = await http.post(Uri.parse(url), body: {
      "id": id,
    }, headers: {
      'Accept': 'application/json',
      'Cookie': loginController.cookie.value,
    });
  }
}
