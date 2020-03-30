// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:auto_route/router_utils.dart';
import 'package:routingwithautoroute/initial_page.dart';
import 'package:routingwithautoroute/second_page.dart';
import 'package:routingwithautoroute/third_page.dart';
import 'package:auto_route/transitions_builders.dart';

class Router {
  static const initialPage = '/';
  static const secondPage = '/second-page';
  static const thirdPage = '/third-page';
  static GlobalKey<NavigatorState> get navigatorKey =>
      getNavigatorKey<Router>();
  static NavigatorState get navigator => navigatorKey.currentState;

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case Router.initialPage:
        return MaterialPageRoute(
          builder: (_) => InitialPage(),
          settings: settings,
        );
      case Router.secondPage:
        if (hasInvalidArgs<String>(args, isRequired: true)) {
          return misTypedArgsRoute<String>(args);
        }
        final typedArgs = args as String;
        return MaterialPageRoute(
          builder: (_) => SecondPage(userId: typedArgs),
          settings: settings,
          fullscreenDialog: true,
        );
      case Router.thirdPage:
        if (hasInvalidArgs<ThirdPageArguments>(args)) {
          return misTypedArgsRoute<ThirdPageArguments>(args);
        }
        final typedArgs = args as ThirdPageArguments ?? ThirdPageArguments();
        return PageRouteBuilder(
          pageBuilder: (ctx, animation, secondaryAnimation) =>
              ThirdPage(username: typedArgs.username, points: typedArgs.points),
          settings: settings,
          transitionsBuilder: TransitionsBuilders.slideBottom,
          transitionDuration: Duration(milliseconds: 400),
        );
      default:
        return unknownRoutePage(settings.name);
    }
  }
}

//**************************************************************************
// Arguments holder classes
//***************************************************************************

//ThirdPage arguments holder class
class ThirdPageArguments {
  final String username;
  final int points;
  ThirdPageArguments({this.username, this.points});
}
