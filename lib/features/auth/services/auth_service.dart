import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:flutternodeapp/constants/error_handling.dart';
import 'package:flutternodeapp/constants/global_variables.dart';
import 'package:flutternodeapp/constants/utils.dart';
import 'package:flutternodeapp/models/user.dart';
import 'package:flutternodeapp/providers/user_provider.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutternodeapp/common/widgets/bottom_bar.dart';

class AuthService {
  void signUpUser(
      {required BuildContext context,
      required String name,
      required String email,
      required String password}) async {
    try {
      User user = User(
        id: "",
        name: name,
        email: email,
        password: password,
        address: "",
        type: "",
        token: "",
        cart: [],
      );
      http.Response res = await http.post(
        Uri.parse('$url/api/signup'),
        body: user.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'charset': 'UTF-8',
        },
      );

      httpErrorHandler(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(
            context,
            "Acount have been created login with the same credentials",
          );
        },
      );
    } catch (err) {
      showSnackBar(context, err.toString());
    }
  }

  void signInUser(
      {required BuildContext context,
      required String email,
      required String password}) async {
    try {
      http.Response res = await http.post(
        Uri.parse('$url/api/signin'),
        body: jsonEncode({'email': email, 'password': password}),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'charset': 'UTF-8',
        },
      );

      // ignore: use_build_context_synchronously
      httpErrorHandler(
        response: res,
        context: context,
        onSuccess: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('x-auth-token', jsonDecode(res.body)['token']);

          // ignore: use_build_context_synchronously
          Provider.of<UserProvider>(context, listen: false).setUser(res.body);
          // ignore: use_build_context_synchronously
          Navigator.pushNamedAndRemoveUntil(
              context, BottomBar.routeName, (route) => false);
        },
      );
    } catch (err) {
      showSnackBar(context, err.toString());
    }
  }

  void getUserData(BuildContext context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');
      if (token == null) {
        prefs.setString('x-auth-token', '');

        var tokenRes = await http.post(Uri.parse('$url/tokenIsValid'),
            headers: <String, String>{
              'Content-Type': 'application/json',
              'x-auth-token': token!
            });
        var response = jsonDecode(tokenRes.body);

        if (response == true) {
          http.Response userRes = await http.get(Uri.parse("$url/"),
              headers: <String, String>{
                'Content-Type': 'application/json',
                'x-auth-token': token
              });

          var userProvider = Provider.of<UserProvider>(context, listen: false);
          userProvider.setUser(userRes.body);
        }
      }
    } catch (err) {
      showSnackBar(context, err.toString());
    }
  }
}
