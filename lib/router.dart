import 'package:flutter/material.dart';
import 'package:flutternodeapp/features/address/screens/address_screen.dart';
import 'package:flutternodeapp/features/admin/screens/add_product_screen.dart';
import 'package:flutternodeapp/features/admin/screens/admin_screen.dart';
import 'package:flutternodeapp/features/auth/screens/auth_screen.dart';
import 'package:flutternodeapp/features/order_details/screens/order_detail_screen.dart';
import 'package:flutternodeapp/features/productdetails/product_detail_screen.dart';
import 'package:flutternodeapp/features/search/screens/search_screen.dart';
import 'package:flutternodeapp/home/screens/categories_deal_screen.dart';
import 'package:flutternodeapp/models/product.dart';
import 'common/widgets/bottom_bar.dart';
import 'home/screens/home_screen.dart';
import 'models/order.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case AuthScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AuthScreen(),
      );
    case HomeScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const HomeScreen(),
      );
    case BottomBar.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const BottomBar(),
      );
    case AddressScreen.routeName:
      var totalAmount = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => AddressScreen(
          totalAmount: totalAmount,
        ),
      );

    case AdminScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AdminScreen(),
      );
    case AddProductScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AddProductScreen(),
      );
    case CatagoriesDeal.routeName:
      var category = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => CatagoriesDeal(
          category: category,
        ),
      );
    case SearchScreen.routeName:
      var searchQuary = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => SearchScreen(
          searchQuary: searchQuary,
        ),
      );
    case ProductDetailScreen.routeName:
      var product = routeSettings.arguments as Product;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => ProductDetailScreen(
          product: product,
        ),
      );
    case OrderDetailScreen.routeName:
      var order = routeSettings.arguments as Order;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => OrderDetailScreen(
          order: order,
        ),
      );
    default:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const Scaffold(
          body: Center(
            child: Text("Page not found"),
          ),
        ),
      );
  }
}
