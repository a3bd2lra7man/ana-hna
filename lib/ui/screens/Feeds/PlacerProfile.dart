import 'dart:convert';

import 'package:ana_hna/data/db/models/Placer.dart';
import 'package:ana_hna/data/db/models/Post.dart';
import 'package:ana_hna/providers/AppProvider.dart';
import 'package:ana_hna/providers/HomeProvider.dart';
import 'package:ana_hna/providers/Home/PlacerProfileProvider.dart';
import 'package:ana_hna/ui/widgets/InternetAble.dart';
import 'package:ana_hna/ui/widgets/LoginButton.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:m7utils/m7utils.dart';
import 'package:provider/provider.dart';
class PlacerProfile extends StatelessWidget {
  final Placer user;
  PlacerProfile(this.user);
  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.watch<AppP>().primary[200],
      child: ListView(
        padding: EdgeInsets.all(10),
        children: [
          SizedBox(height: context.height *.01,),
          Center(
            child: user.image != null
                ? CircleImage(
              size: context.height *.2,
              image:MemoryImage( base64Decode( user.image)),
            )
            : Icon(Icons.account_circle,size: context.height * .25,color: context.provider<AppP>().second[300],)
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(user.name,style: GoogleFonts.gabriela(color: context.provider<AppP>().second,fontSize: 33,fontWeight: FontWeight.bold),),
              IconButton(icon: Icon(Icons.chat,color: Colors.cyan,), onPressed: (){}),
            ],
          ),

          SizedBox(height: context.height *.04,),

          Text(user.categoryEnName,style: GoogleFonts.gabriela(color: context.provider<AppP>().second,fontSize: 20,fontWeight: FontWeight.bold),),
          SizedBox(height: context.height *.05,),
          Divider(),
          SizedBox(height: context.height *.01,),
          ChangeNotifierProvider<PlacerProfileP>(
            create: (context)=>PlacerProfileP(context.provider<HomeP>().homeR,user.id),
            child: Posts(),
          ),
        ],
      ),
    );
  }
}


class Posts extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    PlacerProfileP provider=  context.watch<PlacerProfileP>();
    return InternetAble(
        internetDataState: _getDataState(provider.posts),
        onData: (provider.posts == null || provider.posts.isEmpty)
            ? Center(child: Text("No Posts"),)
            : Column(
              children: provider.posts.map((e) => Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text("${_getFormattedTime(e.dateTime.difference(DateTime.now()))}",textAlign: TextAlign.start,style: TextStyle(color: Colors.grey[300]),),
                  SizedBox(height: context.height * .05,),
                  if(e.image != null)
                    Container(width: context.width,height: context.height * .6,child: Image.memory(base64Decode(e.image),fit: BoxFit.fill,)),
                  SizedBox(height: context.height * .01,),
                  if(e.text != null)
                    Center(child: Text(e.text,style: GoogleFonts.lateef(fontSize: 30),),),
                  Divider(),

                ],
              )).toList(),
            ),
        onPressed: (c){});
  }

  String _getFormattedTime(Duration duration){
    if(duration.inMinutes > -60) return duration.inMinutes.toString().replaceAll('-', '') + 'minutes ago';

    if(duration.inHours > -24)  return duration.inHours.toString().replaceAll('-', '') + 'hours ago';

    if(duration.inDays > -30) return duration.inDays.toString().replaceAll('-', '') + 'days ago';

    if(duration.inDays <= -30 && duration.inDays > -356){
      return (duration.inDays.toDouble() / 30.0).truncate().toString().replaceAll('-', '') + 'month ago';
    }
    else return '';

  }
  InternetDataState _getDataState(Set<Post> posts) {
    if(posts == null) return InternetDataState.Loading;
    else return InternetDataState.Data;
  }
}
