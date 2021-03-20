import 'package:ana_hna/providers/AppProvider.dart';
import 'package:m7utils/m7utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginButton extends StatelessWidget {
  
  final Function onClicked;
  final String label;
  final double width;
  final double height;
  final double radius;
  final Color color;
  const LoginButton({
    this.height =.1,
    this.width =.1,
    this.radius = 0,
    @required this.onClicked,
    @required this.label,
    this.color = Colors.grey
  });
  
  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      minWidth: context.width * this.width,
      height: context.height * this.height,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(this.radius),
        side: BorderSide.none
      ),
      child: FlatButton(
        color: this.color,
        onPressed: this.onClicked,
        child: Text(this.label,style: context.textTheme.headline1.copyWith(fontSize: 20,color: context.watch<AppP>().primary),),
      ),
    );
  }
}