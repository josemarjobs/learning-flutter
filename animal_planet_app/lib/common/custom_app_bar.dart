import 'package:animalplanetapp/utils/strings.dart';
import 'package:animalplanetapp/utils/text_styles.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.9,
      child: Container(
        padding: const EdgeInsets.only(top: 60.0, left: 16.0, right: 16.0),
        child: Row(
          children: <Widget>[
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: Strings.APP_NAME,
                    style: TextStyles.appNameTextStyle,
                  ),
                  TextSpan(text: '\n'),
                  TextSpan(
                    text: Strings.TAG_LINE,
                    style: TextStyles.tagLineTextStyle,
                  ),
                ],
              ),
            ),
            Spacer(),
            Icon(
              Icons.menu,
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}
