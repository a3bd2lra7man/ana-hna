import 'dart:convert';

import 'package:ana_hna/data/db/models/Placer.dart';
import 'package:ana_hna/providers/AppProvider.dart';
import 'package:ana_hna/providers/HomeProvider.dart';
import 'package:ana_hna/ui/screens/Feeds/PlacerProfile.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:m7utils/m7utils.dart';
import 'package:provider/provider.dart';
class NearBy extends StatelessWidget {
  final String id,name;
  const NearBy({this.id,this.name});
  @override
  Widget build(BuildContext context) {
    Set<Placer> _placers = context.watch<HomeP>().nearByPlacers;
    return Material(
      color: context.watch<AppP>().primary[200],
      child: ListView(
        padding: EdgeInsets.all(7),
        children:[
          SizedBox(height: context.height *.02,),
          Text( id == null ? "Placers Near You " : name,textAlign: TextAlign.center,style: GoogleFonts.gabriela(fontSize: 20),),
          SizedBox(height: context.height *.02,),
          if(id == null)
          ..._placers.map((e) => ListTile(
            leading: e.image != null ? CircleImage(image: MemoryImage(base64Decode(e.image)),size: context.width * .15,) : Icon(Icons.account_circle,size: context.width *.15,),
            title: Text(e.name),
            subtitle: Text(context.provider<AppP>().localeName == 'en' ? e.categoryEnName : e.categoryArName),
            onTap: ()=>context.navigateTo(PlacerProfile(e)),
          )).toList(),
          if(id != null)
            ..._placers.where((element) => element.categoryId == id).map((e) => ListTile(
              leading: e.image != null ? CircleImage(image: MemoryImage(base64Decode(e.image)),size: context.width * .15,) : Icon(Icons.account_circle,size: context.width *.15,),
              title: Text(e.name),
              subtitle: Text(context.provider<AppP>().localeName == 'en' ? e.categoryEnName : e.categoryArName),
              onTap: ()=>context.navigateTo(PlacerProfile(e)),
            )).toList()

        ],
      ),
    );
  }
}
