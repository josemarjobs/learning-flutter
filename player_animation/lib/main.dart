import 'package:flutter/material.dart';

void main() => runApp(HomePage());

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: StackBuilder(),
      ),
    );
  }
}

class StackBuilder extends StatefulWidget {
  StackBuilder({Key key}) : super(key: key);

  _StackBuilderState createState() => _StackBuilderState();
}

class _StackBuilderState extends State<StackBuilder>
    with TickerProviderStateMixin {
  AnimationController paneController;
  Animation<double> paneAnimation;
  Animation<double> albumImageAnimation;

  @override
  void initState() {
    super.initState();

    paneController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    paneAnimation = Tween<double>(begin: -320, end: 0).animate(
      CurvedAnimation(parent: paneController, curve: Curves.easeInOut),
    );
    albumImageAnimation = Tween<double>(begin: 1.0, end: 0.5).animate(
      CurvedAnimation(parent: paneController, curve: Curves.easeInOut),
    );
  }

  animationInit() {
    if (paneController.status == AnimationStatus.completed) {
      paneController.reverse();
    } else if (paneController.status == AnimationStatus.dismissed) {
      paneController.forward();
    }
  }

  Widget stackBody(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        FractionallySizedBox(
          alignment: Alignment.topCenter,
          heightFactor: albumImageAnimation.value,
          child: Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: ExactAssetImage("assets/mm.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Positioned(
          bottom: paneAnimation.value, // paneController.value,
          child: GestureDetector(
            onTap: animationInit,
            child: Container(
              alignment: Alignment.bottomCenter,
              height: MediaQuery.of(context).size.height / 2,
              width: MediaQuery.of(context).size.width,
              color: Colors.amber,
            ),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: paneController,
      builder: (context, widget) {
        return stackBody(context);
      },
    );
  }
}
