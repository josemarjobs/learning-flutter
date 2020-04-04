import 'package:animalplanetapp/common/custom_app_bar.dart';
import 'package:animalplanetapp/common/subscription_container.dart';
import 'package:animalplanetapp/utils/strings.dart';
import 'package:animalplanetapp/utils/text_styles.dart';
import 'package:flutter/material.dart';

class ChoosePlanScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 0.6 / 4;
    return Scaffold(
      backgroundColor: Color(0xFFB98959),
      body: Stack(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              CustomAppBar(),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 24.0),
                child: Text(
                  Strings.chooseAPlan,
                  style: TextStyles.headingTextStyle,
                ),
              ),
              SubscriptionContainer(
                height: height,
                text: Strings.weekSubscription,
                imagePath: 'assets/weekly.jpg',
                amount: '\$1.99',
              ),
              SubscriptionContainer(
                height: height,
                text: Strings.oneMonthSubscription,
                imagePath: 'assets/monthly.jpg',
                amount: '\$4.39',
              ),
              SubscriptionContainer(
                height: height,
                text: Strings.threeMonthSubscription,
                imagePath: 'assets/3monthly.jpg',
                amount: '\$9.99',
              ),
              SubscriptionContainer(
                height: height,
                text: Strings.sixMonthSubscription,
                imagePath: 'assets/6monthly.jpg',
                amount: '\$13.00',
              )
            ],
          )
        ],
      ),
    );
  }
}
