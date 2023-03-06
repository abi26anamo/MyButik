import 'package:flutter/material.dart';
import 'package:flutternodeapp/constants/global_variables.dart';
import 'package:flutternodeapp/features/accounts/widgets/blow_app_bar.dart';
import 'package:flutternodeapp/features/accounts/widgets/orders.dart';
import 'package:flutternodeapp/features/accounts/widgets/top_button.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                alignment: Alignment.topLeft,
                child: Image.asset(
                  'assets/amazon_in.png',
                  width: 120,
                  height: 45,
                  color: Colors.black,
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: const [
                    Padding(
                      padding: EdgeInsets.only(right: 15),
                      child: Icon(Icons.notifications_outlined),
                    ),
                    Icon(Icons.search)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      body: Column(
        children: const [
          BlowAppBar(),
          SizedBox(height: 10),
          TopButtons(),
          SizedBox(height: 10),
          Orders()
        ],
      ),
    );
  }
}
