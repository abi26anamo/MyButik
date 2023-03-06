import 'package:flutter/material.dart';
import 'package:flutternodeapp/constants/global_variables.dart';
import 'package:flutternodeapp/providers/user_provider.dart';
import 'package:provider/provider.dart';

import '../../features/accounts/screens/acount_screen.dart';
import '../../features/cart/screens/cart_screen.dart';
import '../../home/screens/home_screen.dart';

class BottomBar extends StatefulWidget {
  static const String routeName = '/actual-home';
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _page = 0;
  double bottomBarWidth = 42;
  double bottomBarBorderWidth = 5;

  List<Widget> pages = [
    const HomeScreen(),
    const AccountScreen(),
    const CartScreen(),
  ];

  void updatePage(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    final cartLen = context.watch<UserProvider>().user.cart.length;
    return Scaffold(
      body: pages[_page],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _page,
        selectedItemColor: GlobalVariables.selectedNavBarColor,
        unselectedItemColor: GlobalVariables.unselectedNavBarColor,
        backgroundColor: GlobalVariables.backgroundColor,
        iconSize: 25,
        onTap: updatePage,
        items: [
          BottomNavigationBarItem(
            icon: Container(
              width: bottomBarWidth,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                      color: _page == 0
                          ? GlobalVariables.selectedNavBarColor
                          : GlobalVariables.unselectedNavBarColor,
                      width: bottomBarBorderWidth),
                ),
              ),
              child: const Icon(Icons.home_outlined),
            ),
          ),
          BottomNavigationBarItem(
            icon: Container(
              width: bottomBarWidth,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                      color: _page == 0
                          ? GlobalVariables.selectedNavBarColor
                          : GlobalVariables.unselectedNavBarColor,
                      width: bottomBarBorderWidth),
                ),
              ),
              child: const Icon(Icons.person_outlined),
            ),
          ),
          BottomNavigationBarItem(
              icon: Container(
                width: bottomBarWidth,
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: _page == 0
                          ? GlobalVariables.selectedNavBarColor
                          : GlobalVariables.unselectedNavBarColor,
                      width: bottomBarBorderWidth,
                    ),
                  ),
                ),
                // child: Badge(
                //   elevation: 0,
                //   badgeColor: Colors.white,
                //   badgeContent: Text(cartLen.toString()),
                //   child: const Icon(Icons.shopping_cart_outlined),
                // ),
              ),
              label: ''),
        ],
      ),
    );
  }
}
