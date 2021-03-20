import 'package:ana_hna/providers/AppProvider.dart';
import 'package:ana_hna/providers/loginProvider.dart';
import 'package:ana_hna/ui/screens/SignUp.dart';
import 'package:ana_hna/ui/widgets/LoginButton.dart';
import 'package:ana_hna/ui/widgets/LoginEditText.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:m7utils/m7utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Login extends StatelessWidget {

  final TextEditingController _accountController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey= GlobalKey<FormState>();   

  @override
  Widget build(BuildContext context) {

  
    return Scaffold(
      backgroundColor: context.watch<AppP>().primary,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[

              SizedBox(height: context.height *.05,),

              Text("Ana hna",style: GoogleFonts.sacramento(color: context.provider<AppP>().second,fontSize: 60,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),

              SizedBox(height: context.height *.15,),

              LoginEditText(
                height:context.height *.02,
                controller: _accountController,
                label: context.translate('Enter_Your_Account'),
                prefixIcon: Icons.account_circle, 
                editTextValidator: (str)=>context.provider<LoginP>().emailValidator(context,str),
              ),

              SizedBox(height: context.height *.03,),

              LoginEditText(
                height: context.height *.02,
                  label: context.translate('Enter_Your_Password'), 
                  prefixIcon: Icons.lock,
                  controller: this._passwordController,
                  secure: true, 
                  editTextValidator:(str)=> context.provider<LoginP>().textValidator(context,str),
                  passwordVisibility: context.watch<LoginP>().isSecured,
                  ifSecureOnClicked:context.provider<LoginP>().negativeIsSecured, 
                ),
              
              SizedBox(height: context.height *.15,),

              Flex(
                direction: Axis.vertical,
                children: [
                  LoginButton(
                    color: context.provider<AppP>().second[300],
                    width: .45,
                    height: .06,
                    label: context.translate('Login'),
                    onClicked:(){
                      if(_formKey.currentState.validate())
                        context.provider<LoginP>().loginOrSign(context, _accountController.text, _passwordController.text);
                    },
                    radius: 20,
                  ),

                  SizedBox(height: context.height *.01,),


                  LoginButton(
                    color: context.provider<AppP>().second[300],
                    width: .8,
                    height: .06,
                    label: context.translate('SignUp'),
                    onClicked:(){
                      context.provider<LoginP>().goTo(context, [ChangeNotifierProvider<LoginP>.value(value: context.provider<LoginP>())], SignUp());
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
