import 'dart:convert';

import 'package:ana_hna/data/db/models/Message.dart';
import 'package:ana_hna/data/db/models/Placer.dart';
import 'package:ana_hna/providers/AppProvider.dart';
import 'package:ana_hna/providers/ChatProvider.dart';
import 'package:ana_hna/providers/HomeProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:m7utils/m7utils.dart';

import 'ChatRoom.dart';

class OldChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    ChatP provider = context.watch<ChatP>();
    return Material(
      color: context.watch<AppP>().primary[200],
      child: ListView.builder(
        itemCount: provider.messages.length,
        itemBuilder:(context,index){
          Placer user = context.provider<HomeP>().nearByPlacers.firstWhere((element) => element.id == provider.messages.keys.elementAt(provider.messages.length - index - 1));
          return ListTile(
            title: Text(user.name),
            subtitle: Text(provider.messages[user.id].isNotEmpty ? provider.messages[user.id].last.message : "Write Something"),
            leading: user.image != null ? CircleImage(image: MemoryImage(base64Decode(user.image)),size: context.width * .15,) : Icon(Icons.account_circle,size: context.width *.15,),
            onTap: (){
              context.provider<ChatP>().interRoom(user.id);
              context.navigateTo(MultiProvider(providers: [
                ChangeNotifierProvider<ChatP>.value(value: context.provider<ChatP>()),
                ChangeNotifierProvider<HomeP>.value(value: context.provider<HomeP>()),
              ],child: ChatRoom() ));
            },
          ) ;
        }
      ),
    );
  }
}
