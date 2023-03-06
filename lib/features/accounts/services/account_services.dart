import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:flutternodeapp/constants/error_handling.dart';
import 'package:flutternodeapp/constants/global_variables.dart';
import 'package:flutternodeapp/constants/utils.dart';
import 'package:flutternodeapp/models/order.dart';
import 'package:flutternodeapp/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class AccountServices {
  Future<List<Order>> fetchMyOrders(
      {required BuildContext context}) async {
    final userprovider = Provider.of<UserProvider>(context, listen: false);
    List<Order> orderList = [];
    try {
      http.Response res = await http.get(
        Uri.parse('$url/api/order/me'),
        headers: {
          "Content-Type": "Application/json",
          "x-auth-token": userprovider.user.token
        },
      );

      // ignore: use_build_context_synchronously
      httpErrorHandler(
        response: res,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            orderList.add(
              Order.fromJson(
                jsonEncode(
                  jsonDecode(
                    res.body[i],
                  ),
                ),
              ),
            );
          }
        },
      );
    } catch (err) {
      showSnackBar(context, err.toString());
    }
    return orderList;
  }
}
