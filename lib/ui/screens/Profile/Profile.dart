import 'dart:convert';
import 'package:ana_hna/data/db/models/User.dart';
import 'package:ana_hna/providers/AppProvider.dart';
import 'package:ana_hna/ui/screens/Profile/ProfileEditing.dart';
import 'package:ana_hna/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:m7utils/m7utils.dart';
import 'package:provider/provider.dart';

class Profile extends StatelessWidget {

  final Function onLogOut;
  Profile({@required this.onLogOut});
  Widget build(BuildContext context) {
    User user = context.watch<AppP>().user;
    return Material(
        color: context.watch<AppP>().primary[200],
        child: ListView(
          padding: EdgeInsets.only(left:10,right:10,top:40,bottom: 8),
          children: <Widget>[
            Center(
              child: user.image != null
                ? CircleImage(
                  size: context.height *.25,
                  image:MemoryImage( base64Decode( user.image)),
                )
                : Icon(Icons.account_circle,size: context.height * .25,color: context.provider<AppP>().second[300],)
            ),

            SizedBox(height: context.height * .03,),
            Center(child: Text(user.name,style: GoogleFonts.gabriela(color: context.provider<AppP>().second,fontSize: 33,fontWeight: FontWeight.bold),),),

            SizedBox(height: context.height *.08,),

            ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 3),
              leading: CircleAvatar(backgroundColor: Colors.redAccent,child: Icon(context.provider<AppP>().primary == AppColors.primary ? FontAwesomeIcons.toggleOn :FontAwesomeIcons.toggleOff,color: AppColors.primary, )),
              title: Text(context.translate('Dark_Mode'),style:context.textTheme.headline1.copyWith(color: context.provider<AppP>().second,fontSize: 18,fontWeight: FontWeight.bold) ,),
              onTap: ()=>context.provider<AppP>().changeTheme(),
            ),


            ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 3),
              leading: CircleAvatar(backgroundColor: Colors.cyan,child: Icon(FontAwesomeIcons.user,color: AppColors.primary,)),
              title: Text(context.translate('Change_Profile'),style:context.textTheme.headline1.copyWith(color: context.provider<AppP>().second,fontSize: 18,fontWeight: FontWeight.bold) ,),
              onTap: () => context.provider<AppP>().goTo(context,null ,ProfileEditing()),

            ),

            ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 3),
              leading: CircleAvatar(backgroundColor: Colors.lightGreenAccent,child: Icon(FontAwesomeIcons.userLock,color: AppColors.primary,)),
              title: Text(context.translate('Log_Out'),style:context.textTheme.headline1.copyWith(color: context.provider<AppP>().second,fontSize: 18,fontWeight: FontWeight.bold) ,),
              onTap: () => onLogOut(),

            ),
          ],
        ),
    );
  }

}