import 'package:ana_hna/providers/AppProvider.dart';
import 'package:flutter/material.dart';
import 'package:m7utils/m7utils.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  @override
  void initState() {
    super.initState();
    context.provider<AppP>().checkUserLogin(context);
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width,
      height: context.height,
      child: Image.asset('assets/pic/splah1.jpg',fit: BoxFit.fill,),
    );
  }
}