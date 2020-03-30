import 'package:flutter/material.dart';
import 'package:routingwithautoroute/routes/router.gr.dart';

class InitialPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('First Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              child: Text('Go to second page'),
              onPressed: () => navigateToSecond(context),
            ),
            RaisedButton(
              child: Text('Go to third page'),
              onPressed: () => navigateToThird(context),
            ),
          ],
        ),
      ),
    );
  }

  void navigateToSecond(BuildContext context) {
    Router.navigator.pushNamed(Router.secondPage, arguments: 'peterg');
  }

  void navigateToThird(BuildContext context) {
    Router.navigator.pushNamed(
      Router.thirdPage,
      arguments: ThirdPageArguments(username: 'peterg', points: 2048),
    );
  }
}
