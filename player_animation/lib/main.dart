import 'dart:ui';

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
  Animation<double> albumImageBlurAnimation;
  Animation<Color> songContainerColorAnimation;
  Animation<Color> songContainerTextColorAnimation;

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
    albumImageAnimation = Tween<double>(begin: 1.0, end: 0.7).animate(
      CurvedAnimation(parent: paneController, curve: Curves.easeInOut),
    );
    albumImageBlurAnimation = Tween(begin: 0.0, end: 6.0).animate(
      CurvedAnimation(parent: paneController, curve: Curves.easeOut),
    );

    songContainerColorAnimation = ColorTween(
      begin: Colors.black87,
      end: Colors.white.withOpacity(0.5),
    ).animate(
      CurvedAnimation(parent: paneController, curve: Curves.easeOut),
    );
    songContainerTextColorAnimation = ColorTween(
      begin: Colors.white,
      end: Colors.black87,
    ).animate(
      CurvedAnimation(parent: paneController, curve: Curves.easeOut),
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
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: albumImageBlurAnimation.value,
                sigmaY: albumImageBlurAnimation.value,
              ),
              child: Container(
                color: Colors.white.withOpacity(0.0),
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
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25.0),
                  topRight: Radius.circular(25.0),
                ),
                color: songContainerColorAnimation.value,
              ),
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    "Now Playing",
                    style: TextStyle(
                      color: songContainerTextColorAnimation.value,
                    ),
                  ),
                  Text(
                    "La Cancion",
                    style: TextStyle(
                      color: songContainerTextColorAnimation.value,
                      fontSize: 16.0,
                    ),
                  ),
                  Text(
                    "J. Balvin and Bad Bunny",
                    style: TextStyle(
                      color: songContainerTextColorAnimation.value,
                      fontSize: 12.0,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Container(
                    height: MediaQuery.of(context).size.height / 2,
                    child: ListView.builder(
                      itemCount: 10,
                      itemBuilder: (BuildContext context, int index) {
                        return Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 8.0,
                                bottom: 8.0,
                                right: 16.0,
                                left: 8.0,
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: ExactAssetImage("assets/mm.jpg"),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                height: 60.0,
                                width: 60.0,
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Another song name | 3:45",
                                  style: TextStyle(
                                    color:
                                        songContainerTextColorAnimation.value,
                                  ),
                                ),
                                Text(
                                  "Another Singer name",
                                  style: TextStyle(
                                    color:
                                        songContainerTextColorAnimation.value,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                    ),
                  )
                ],
              ),
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
