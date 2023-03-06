import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:flutternodeapp/constants/error_handling.dart';
import 'package:flutternodeapp/constants/utils.dart';
import 'package:flutternodeapp/models/product.dart';
import 'package:flutternodeapp/models/user.dart';
import 'package:flutternodeapp/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../../../constants/global_variables.dart';

class CartServices {
  void removeFromCart({
    required BuildContext context,
    required Product product,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.delete(
        Uri.parse('$url/api/remove-from-cart/${product.id}'),
        headers: {
          'Content-Type': 'Application/json',
          'x-auth-token': userProvider.user.token
        },
      );

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
}
