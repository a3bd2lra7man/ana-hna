import 'package:ana_hna/providers/AppProvider.dart';
import 'package:ana_hna/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:m7utils/m7utils.dart';
import 'package:provider/provider.dart';

typedef EditTextValidator = String Function(String);

class LoginEditText extends StatelessWidget {

  final double height;
  final String label;
  final IconData prefixIcon;
  final TextEditingController controller;
  final bool secure;
  final Function ifSecureOnClicked;
  final bool passwordVisibility;
  final EditTextValidator editTextValidator;
  final double radius;
  final String hint;
  final Color borderColor;
  const LoginEditText({
    @required this.label,
    @required this.prefixIcon,
    @required this.controller,
    this.secure = false,
    this.ifSecureOnClicked,
    this.passwordVisibility = false,
    @required this.editTextValidator,
    this.height = 10,
    this.radius = 10,
    this.hint = '',
    this.borderColor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    
    
    return TextFormField(
      validator: editTextValidator,
      controller: this.controller,
      cursorColor: AppColors.third,
      obscureText: this.passwordVisibility,
      decoration: InputDecoration(

        hintText: this.hint,
        suffixIcon: 
          this.secure 
            ? IconButton(icon: Icon(Icons.remove_red_eye,color:  this.passwordVisibility ? AppColors.third[900] : AppColors.third[500],), onPressed:this.ifSecureOnClicked) 
            : null,
        contentPadding: EdgeInsets.all(this.height),     
        icon: this.prefixIcon != null ? Icon(this.prefixIcon,size: 40,color: context.watch<AppP>().second[400],) : null,
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(radius)),
          borderSide:BorderSide(color:this.borderColor,width: 2)),
        border: OutlineInputBorder(gapPadding: 0,borderRadius: BorderRadius.all(Radius.circular(radius)),
          borderSide:BorderSide(color: this.borderColor,width: 2,)),
        labelText:  this.label,
        fillColor: AppColors.second,
        filled: true,
        labelStyle: context.textTheme.headline4,
        // errorStyle: context
      ),
      style: context.textTheme.headline3,
    );
  }
}