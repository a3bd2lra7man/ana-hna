import 'dart:convert';

import 'package:ana_hna/data/db/models/Placer.dart';
import 'package:ana_hna/providers/AppProvider.dart';
import 'package:ana_hna/providers/ChatProvider.dart';
import 'package:ana_hna/providers/HomeProvider.dart';
import 'package:ana_hna/ui/screens/Chats/ChatRoom.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:m7utils/m7utils.dart';

class EntryChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Set<Placer> _placers = context.watch<ChatP>().onlinePlacers.map((e) =>
      context.provider<HomeP>().nearByPlacers.firstWhere((element) => element.id == e)).toSet();

    return Material(
      color: context.watch<AppP>().primary[200],
      child: ListView(
        padding: EdgeInsets.all(7),
        children:[
          SizedBox(height: context.height *.02,),
          Text(  "Chat with" ,textAlign: TextAlign.center,style: GoogleFonts.gabriela(fontSize: 20),),
          SizedBox(height: context.height *.02,),
            ..._placers.map((e) => ListTile(
              leading: e.image != null ? CircleImage(image: MemoryImage(base64Decode(e.image)),size: context.width * .15,) : Icon(Icons.account_circle,size: context.width *.15,),
              title: Text(e.name),
              subtitle: Text(context.provider<AppP>().localeName == 'en' ? e.categoryEnName : e.categoryArName),
              onTap: (){
                context.provider<ChatP>().interRoom(e.id);
                context.navigateTo(MultiProvider(providers: [
                  ChangeNotifierProvider<ChatP>.value(value: context.provider<ChatP>()),
                  ChangeNotifierProvider<HomeP>.value(value: context.provider<HomeP>()),
                ],child: ChatRoom() ));
              },
            )).toList(),

        ],
      ),
    );
  }
}
