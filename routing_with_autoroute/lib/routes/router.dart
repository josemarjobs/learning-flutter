import 'package:auto_route/auto_route_annotations.dart';
import 'package:auto_route/transitions_builders.dart';
import 'package:routingwithautoroute/initial_page.dart';
import 'package:routingwithautoroute/second_page.dart';
import 'package:routingwithautoroute/third_page.dart';

@autoRouter
class $Router {
  @initial
  InitialPage initialPage;
  @MaterialRoute(fullscreenDialog: true)
  SecondPage secondPage;
  @CustomRoute(
    transitionsBuilder: TransitionsBuilders.slideBottom,
    durationInMilliseconds: 400,
  )
  ThirdPage thirdPage;
}
