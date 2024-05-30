import 'dart:convert';

import 'package:get/get.dart';
import 'package:officeapp/Models/User.dart';
import 'package:officeapp/Models/Environment.dart';
import 'package:http/http.dart' as http;
import 'package:package_info_plus/package_info_plus.dart';

class AuthController extends GetxController {
  login(String name, String password) async {
    final url = "${Environment().api}/login";

    // await http.get(Uri.parse("${Environment().api_server}sanctum/csrf-cookie"),
    //     headers: {
    //       'Accept': 'application/json',
    //     });
    (url);
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String appVersion = packageInfo.version;

    final response = await http.post(Uri.parse(url), body: {
      "name": name,
      "password": password,
    }, headers: {
      'App-Version': appVersion,
      'Accept': 'application/json',
    });

    return response;
  }

  logout() async {
    final url = "${Environment().api}/logout";
    ('++++++++++++++++++++');

    final response = await http.post(Uri.parse(url), headers: {
      'Accept': 'application/json',
    });
    ('++++++++++++++++++++');

    return response;
  }

  register(String name, String password, String email) async {
    final url = "${Environment().api}/register";

    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String appVersion = packageInfo.version;

    final response = await http.post(Uri.parse(url), body: {
      "name": name,
      "password": password,
      "email": email
    }, headers: {
      'App-Version': appVersion,
      'Accept': 'application/json',
    });

    return response;
  }

  Future<User> fetchUser() async {
    // Obtain shared preferences.
    // final prefs = await SharedPreferences.getInstance();
    // Try reading data from the 'action' key. If it doesn't exist, returns null.
    // final String? auth_token = prefs.getString('auth_token');
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String appVersion = packageInfo.version;
    var response =
        await http.get(Uri.parse("${Environment().api}/user"), headers: {
      'Accept': 'application/json',
      'App-Version': appVersion,
      // 'Authorization': 'Bearer ${window.localStorage['auth_token']!}'
      // 'Authorization': 'Bearer ${auth_token!}'
    });

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      String jsonstring = (response.body);
      final user = jsonDecode(jsonstring);
      (response.body);
      return User.fromJson(user);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load user details!!');
    }
  }
}
