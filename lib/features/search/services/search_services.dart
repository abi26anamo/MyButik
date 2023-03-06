import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:flutternodeapp/constants/error_handling.dart';
import 'package:flutternodeapp/constants/global_variables.dart';
import 'package:flutternodeapp/constants/utils.dart';
import 'package:flutternodeapp/models/product.dart';
import 'package:flutternodeapp/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class SearchServices {
  Future<List<Product>> fetchSearchedProduct({
    required BuildContext context,
    required searchQuery,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final List<Product> products = [];
    try {
      http.Response res = await http.get(Uri.parse('$url/api/products/search/$searchQuery'), headers: {
        'Content-Type': 'application/json',
        'token': userProvider.user.token
      });
      httpErrorHandler(
        response: res,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            products.add(
              Product.fromJson(
                jsonEncode(
                  jsonDecode(res.body),
                ),
              ),
            );
          }
        },
      );
    } catch (err) {
      showSnackBar(context, err.toString());
    }
    return products;
  }
}
