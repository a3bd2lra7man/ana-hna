import 'package:ana_hna/data/db/models/Message.dart';
import 'package:ana_hna/data/db/models/Placer.dart';
import 'package:ana_hna/providers/AppProvider.dart';
import 'package:ana_hna/providers/ChatProvider.dart';
import 'package:ana_hna/providers/HomeProvider.dart';
import 'package:ana_hna/ui/widgets/Chat/ChatAppBar.dart';
import 'package:ana_hna/ui/widgets/Chat/PerConversations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:m7utils/m7utils.dart';

class ChatRoom extends StatelessWidget {

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    ChatP provider = context.watch<ChatP>();
    // listen to ui stream
    Placer user = context.watch<HomeP>().nearByPlacers.firstWhere((element) => element.id == provider.currentRoom);

    return SafeArea(
      child: Scaffold(

        backgroundColor: context.watch<AppP>().primary,

        appBar:chatRoomAppBar(context,name: user.name,image: user.image) ,

        body: Stack(
          children: <Widget>[

            // listen to stream
            provider.messages[user.id].length > 0
            ? ListView.builder(
              controller: _scrollController,
              padding: EdgeInsets.symmetric(vertical: context.height * .13,horizontal: 10),
              reverse: true,
              itemCount: provider.messages[user.id].length,
              itemBuilder: (context,index){
                Message message = provider.messages[user.id][provider.messages[user.id].length - index - 1];
                return message.messageType == MessageType.text
                    ? TextConversation(message: message.message,isCurrentUser: message.senderId == context.provider<AppP>().user.remoteId ? true : false,)
                    : ImageConversation(image: message.message,isCurrentUser: message.senderId == context.provider<AppP>().user.remoteId ? true : false,);
              }
            )
            : Center(child: Text("Write something"),),

//
//                : ListView(
//              padding: EdgeInsets.symmetric(vertical: height(context)* .13,horizontal: 10),
//              reverse: true,
//              children: <Widget>[
//                Text("You are connected in Messanger",textAlign: TextAlign.center,),
//              ],
//            ),
//

            Positioned(
                bottom: 0,
                right: 0,
                left: 0,
                child:ChatRoomBottomBar()
            ),
          ],
        ),
      ),
    );
  }
//  void _onSend(BuildContext context,Message message){
//    provider<ChatProvider>(context).addNewMessage(message,id);
//    _scrollController.animateTo(0, duration: Duration(milliseconds: 500), curve: Curves.bounceInOut);
//  }
}