import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:flutternodeapp/constants/error_handling.dart';
import 'package:flutternodeapp/constants/global_variables.dart';
import 'package:flutternodeapp/constants/utils.dart';
import 'package:flutternodeapp/models/product.dart';
import 'package:flutternodeapp/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../../../models/user.dart';

class ProductDetailServices {
  void addToCart({
    required BuildContext context,
    required Product product,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.post(Uri.parse('$url/api/add-to-cart'),
          headers: {
            'Content-Type': 'application/json',
            'token': userProvider.user.token
          },
          body: jsonEncode({'id': product.id}));

      httpErrorHandler(
        response: res,
        context: context,
        onSuccess: () {
          User user =
              userProvider.user.copyWith(cart: jsonDecode(res.body)['cart']);
          userProvider.setUserFromModel(user);
        },
      );
    } catch (err) {
      showSnackBar(context, err.toString());
    }
  }

  void rateProduct(
      {required BuildContext context,
      required Product product,
      required double rating}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.post(Uri.parse('$url/api/rate-product'),
          headers: {
            'Content-Type': 'application/json',
            'token': userProvider.user.token
          },
          body: jsonEncode({'id': product.id, 'rating': rating}));
      httpErrorHandler(
        response: res,
        context: context,
        onSuccess: () {},
      );
    } catch (err) {
      showSnackBar(context, err.toString());
    }
  }
}
