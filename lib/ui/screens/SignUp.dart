import 'package:ana_hna/providers/AppProvider.dart';
import 'package:ana_hna/providers/loginProvider.dart';
import 'package:ana_hna/ui/widgets/LoginButton.dart';
import 'package:ana_hna/ui/widgets/LoginEditText.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:m7utils/m7utils.dart';
import 'package:provider/provider.dart';

class SignUp extends StatelessWidget {


  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _accountController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey= GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: context.watch<AppP>().primary,
      body: Padding(
        padding: const EdgeInsets.only(top: 20,right: 10,left: 10,bottom: 20),
        child:Form(
            key: _formKey,
            child: ListView(

              children: <Widget>[

                Text("Ana hna",style: GoogleFonts.sacramento(color: context.provider<AppP>().second,fontSize: 60,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),

                SizedBox(height: context.height *.15,),

                LoginEditText(
                  height: context.height * .02,
                  editTextValidator:(str)=> context.provider<LoginP>().textValidator(context,str),
                  controller: _nameController,
                  label: context.translate( 'Enter_Your_Name'),
                  prefixIcon: Icons.account_circle,
                ),
                SizedBox(height: context.height * .03,),

                LoginEditText(
                  editTextValidator:(str)=>context.provider<LoginP>().emailValidator(context,str),
                  height: context.height* .02,
                  controller: _accountController,
                  label: context.translate( 'Enter_Your_Account'),
                  prefixIcon: Icons.email,
                ),

                SizedBox(height: context.height* .03,),

                LoginEditText(
                  editTextValidator:(str)=> context.provider<LoginP>().textValidator(context,str),
                  height: context.height* .02,
                  label: context.translate( 'Enter_Your_Password'),
                  prefixIcon: Icons.lock,
                  controller: this._passwordController,
                  secure: true,
                  passwordVisibility: context.watch<LoginP>().isSecured,
                  ifSecureOnClicked:context.provider<LoginP>().negativeIsSecured,
                ),

                SizedBox(height: context.height* .03,),

                LoginEditText(
                  height: context.height * .02,
                  editTextValidator: (pass2)=> context.provider<LoginP>().passwordValidator(context,_passwordController.text, pass2),
                  label: context.translate( 'Repeat_Password'),
                  prefixIcon: Icons.lock_outline,
                  secure: true,
                  passwordVisibility: context.watch<LoginP>().isSecured,
                  ifSecureOnClicked:context.provider<LoginP>().negativeIsSecured,
                  controller: null,
                ),
                SizedBox(height: context.height * .1),
                Flex(
                  direction: Axis.vertical,
                  children: [
                    LoginButton(
                      color: context.provider<AppP>().second[400],
                      width: .8,
                      height: .06,
                      label: context.translate( 'SignUp'),
                      onClicked:(){
                        if(_formKey.currentState.validate())
                          context.provider<LoginP>().loginOrSign(context, _accountController.text, _passwordController.text,name: _nameController.text,signUp: true);
                      },
                      radius: 20,
                    ),
                  ],
                ),


              ],
            ),
          ),
        ),
    );
  }
}