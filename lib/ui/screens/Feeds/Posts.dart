import 'dart:convert';
import 'package:ana_hna/data/db/models/Post.dart';
import 'package:ana_hna/providers/AppProvider.dart';
import 'package:ana_hna/providers/HomeProvider.dart';
import 'package:ana_hna/ui/screens/Feeds/PlacerProfile.dart';
import 'package:ana_hna/ui/widgets/InternetAble.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:m7utils/m7utils.dart';

class Posts extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    HomeP provider=  context.watch<HomeP>();
    return Material(
      color: context.watch<AppP>().primary[200],
      child: ListView(
        padding: EdgeInsets.all(10),
        children: [
          InternetAble(
              internetDataState: _getDataState(provider.posts),
              onData: (provider.posts == null || provider.posts.isEmpty)
                  ? Center(child: Text("No posts"),)
                  : Column(
                children: provider.posts.map((e) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap:()=>context.navigateTo(PlacerProfile(provider.nearByPlacers.firstWhere((element) => element.id == e.placerId))),
                          child: Row(
                            children: [
                              provider.nearByPlacers.firstWhere((element) => element.id == e.placerId).image != null
                              ? CircleImage(
                                size: context.width *.13,
                                image:MemoryImage( base64Decode( provider.nearByPlacers.firstWhere((element) => element.id == e.placerId).image)),
                              )
                              : Icon(Icons.account_circle,size: context.height * .25,color: context.provider<AppP>().second[300],),
                              SizedBox(width: 10,),
                              Text(provider.nearByPlacers.firstWhere((element) => element.id == e.placerId).name,style: GoogleFonts.gabriela(fontSize: 15))
                            ],
                          ),
                        ),
                        Text("${_getFormattedTime(e.dateTime.difference(DateTime.now()))}",textAlign: TextAlign.start,style: TextStyle(color: Colors.grey[300]),),
                      ],
                    ),
                    SizedBox(height: context.height * .05,),
                    if(e.image != null)
                      Container(width: context.width,height: context.height * .4,child: Image.memory(base64Decode(e.image),fit: BoxFit.fill,)),
                    SizedBox(height: context.height * .01,),
                    if(e.text != null)
                      Center(child: Text(e.text,style: GoogleFonts.lateef(fontSize: 30),),),
                    Divider(),

                  ],
                )).toList(),
              ),
              onPressed: (c){}),
        ],
      ),
    );
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
