import 'package:animalplanetapp/utils/text_styles.dart';
import 'package:flutter/material.dart';

class SubscriptionContainer extends StatelessWidget {
  final String amount;
  final String text;
  final String imagePath;
  final double height;

  const SubscriptionContainer(
      {this.amount, this.text, this.imagePath, this.height = 120.0});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
//      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        image: DecorationImage(image: AssetImage(imagePath), fit: BoxFit.cover),
      ),
      child: Stack(
        children: <Widget>[
          Container(
            height: height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: Colors.black26,
            ),
//            width: double.i,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Center(
              child: Row(
                children: <Widget>[
                  Container(
                    width: 200.0,
                    child: Text(text, style: TextStyles.subscriptionTextStyle),
                  ),
                  Spacer(),
                  Text(amount, style: TextStyles.subscriptionAmountTextStyle),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
