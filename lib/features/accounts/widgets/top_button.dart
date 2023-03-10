import 'package:flutter/widgets.dart';
import 'package:flutternodeapp/features/accounts/widgets/account_button.dart';

class TopButtons extends StatefulWidget {
  const TopButtons({super.key});

  @override
  State<TopButtons> createState() => _TopButtonsState();
}

class _TopButtonsState extends State<TopButtons> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            AccountButton(
              text: "Your orders",
              onTap: () {},
            ),
             AccountButton(
              text: "Turn seller",
              onTap: () {},
            ),
          ],
        ),
        const SizedBox(height: 10,),
        Row(
          children: [
            AccountButton(
              text: "Log Out",
              onTap: () {},
            ),
             AccountButton(
              text: "Your Wish Lists",
              onTap: () {},
            ),
          ],
        ),
      ],
    );
  }
}
