import 'package:flutter/material.dart';
import 'package:imd_weather/values/MyColors.dart';

import '../values/MyColors.dart';

class Launcher extends StatefulWidget {
  @override
  _LauncherState createState() => _LauncherState();
}

class _LauncherState extends State<Launcher> with TickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    animation = CurvedAnimation(parent: controller, curve: Curves.easeIn);

    animation.addStatusListener((status) async {
      if (status == AnimationStatus.completed) {
        await Future.delayed(Duration(seconds: 1));
        Navigator.pushReplacementNamed(context, '/loading');
      }
    });
    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffc3cfe2),
      body: Center(
        child: FadeTransition(
          opacity: animation,
          child: Column(
            children: <Widget>[
              SizedBox(height: MediaQuery.of(context).size.height*0.2,),
              Center(
                child: Container(
                   width: MediaQuery.of(context).size.width*0.45,
                    height:MediaQuery.of(context).size.height*0.25,
                    child: Image.asset('assets/images/imd_logo.png',)),
              ),
              SizedBox(height: MediaQuery.of(context).size.height*0.03),
              Padding(
                padding:  EdgeInsets.only(left: MediaQuery.of(context).size.height*0.03,
                                          right: MediaQuery.of(context).size.height*0.03,
                                          top: MediaQuery.of(context).size.height*0.0),
                child: Divider(
                  height: MediaQuery.of(context).size.height*0.01,
                 color: MyColors.text1,
                thickness: 2,
               ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height*0.01),
              Expanded(
                  child: Text('Indian Meteorological Department',
                      textAlign: TextAlign.center,
                      style: TextStyle( color: MyColors.main_black,
                          fontFamily: 'OpenSans Light', fontSize: MediaQuery.of(context).size.height*0.04)))
            ],
          ),
        ),
      ),
    );
  }
}
