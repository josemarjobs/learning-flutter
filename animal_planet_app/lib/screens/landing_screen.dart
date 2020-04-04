import 'package:animalplanetapp/common/custom_app_bar.dart';
import 'package:animalplanetapp/screens/choose_plan_screen.dart';
import 'package:animalplanetapp/utils/strings.dart';
import 'package:animalplanetapp/utils/text_styles.dart';
import 'package:flutter/material.dart';

class LandingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Image.asset(
            'assets/elephant.jpg',
            height: height,
            fit: BoxFit.fitHeight,
          ),
          Column(
            children: <Widget>[
              CustomAppBar(),
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(
                    bottom: 32.0, left: 32.0, right: 32.0),
                child: RichText(
                  text: TextSpan(children: [
                    TextSpan(
                        text: Strings.READY_TO_WATCH,
                        style: TextStyles.bigHeadingTextStyle),
                    TextSpan(text: '\n'),
                    TextSpan(
                        text: Strings.READY_TO_WATCH_DESC,
                        style: TextStyles.bodyTextStyle),
                    TextSpan(text: '\n'),
                    TextSpan(text: '\n'),
                    TextSpan(
                        text: Strings.START_ENJOYING,
                        style: TextStyles.buttonTextStyle),
                  ]),
                ),
              )
            ],
          ),
          Positioned(
            bottom: -30,
            right: -30,
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ChoosePlanScreen(),
                  ),
                );
              },
              child: Container(
                width: 100.0,
                height: 100.0,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFFD3A070).withOpacity(0.8)),
                child: Align(
                  alignment: Alignment(-0.4, -0.4),
                  child: Icon(
                    Icons.arrow_forward,
                    size: 40.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
