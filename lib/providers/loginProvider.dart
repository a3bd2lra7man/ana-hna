import 'package:ana_hna/data/LoginRepo.dart';
import 'package:ana_hna/data/db/models/User.dart';
import 'package:ana_hna/providers/AppProvider.dart';
import 'package:ana_hna/utils/M7Common.dart';
import 'package:flutter/material.dart';
import 'package:m7utils/m7utils.dart';
class LoginP extends ChangeNotifier with M7Mixin {

  LoginR _loginR;

  LoginP(LoginR loginR):
      _loginR = loginR;


  bool isSecured = true;

  String emailValidator(BuildContext context,String email) {
    Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (regex.hasMatch(email.trim())) return null;
    return context.translate('InValid_Email');
  }

  String textValidator(BuildContext context,String str){
    if(str.length > 5) return null;
    return context.translate('Enter_6_Character');
  }
  String passwordValidator(BuildContext context,String pass1,String pass2){
    if(pass1 == pass2) return null;
    return context.translate('Password_Mismatch');
  }
  void negativeIsSecured(){
    isSecured = !isSecured;
    notifyListeners();
  }


  void loginOrSign(BuildContext context,String email,String password,{String name,bool signUp = false})async{
    AppP appP = getAppP(context);
    bool res =await waitForResponse(context,
        doo:()async=> await _loginR.loginOrSignUp(email, password,name: name,signUp: signUp),
        onSuccess: (res)async=>await appP.saveUser(User.fromMap(res)),
        onField: (res)=>showM7ErrorDialog(Text(res[ appP.localeName == 'en' ? 'errorEnMessage' : 'errorArMessage']), context));
    if(res) appP.checkUserLogin(context);
  }


}