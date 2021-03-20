import 'dart:convert';
import 'package:m7utils/m7utils.dart';
import 'package:ana_hna/data/db/models/Message.dart';
import 'package:ana_hna/providers/AppProvider.dart';
import 'package:ana_hna/providers/ChatProvider.dart';
import 'package:ana_hna/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:m7utils/m7utils.dart';

PreferredSizeWidget chatAppBar(double height, {String newMessageCount}) {

  return PreferredSize(

    preferredSize: Size(double.infinity, height),

    child: Column(

      children: <Widget>[

        TabBar(
          labelColor: Colors.cyan,
          unselectedLabelColor: AppColors.third,
          indicatorColor: Colors.cyan,
          tabs: [
            _customTap(height, newMessageCount),
            Tab(icon: Icon(Icons.people,size: height / 2,),),
          ],
        ),


      ],
    ),
  );
}

Tab _customTap(double height,String newMessageCount )
=>Tab(
  child: Stack(
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.all(4.0),
        child: Icon(
          FontAwesomeIcons.comment,
          size: height / 2.3,
        ),
      ),
      if (newMessageCount != null)
        Positioned(
          right: 0,
          top: 0,
          child: CircleAvatar(
            backgroundColor: Colors.white,
            maxRadius: height / 6,
            child: CircleAvatar(
              backgroundColor: Colors.red,
              maxRadius: height / 7,
              child: Center(
                child: Text(
                  newMessageCount,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: height / 5
                  ),
                ),
              ),
            ),
          ),
        ),
    ],
  ),
);


/// [chatRoomAppBar] return the app bar used in chat room  ***when chatting***
AppBar chatRoomAppBar(BuildContext context,{String image,String name}){

  return AppBar(

    backgroundColor: context.provider<AppP>().primary,
    elevation: 0,
    iconTheme: IconThemeData(color: Colors.blue),
    titleSpacing: 0,
    title: Row(

      children: <Widget>[

        image != null
            ? CircleImage(size: context.width * .12,image: MemoryImage(base64Decode(image)),)
            : Icon(Icons.account_circle,size: context.width* .1,color: Colors.grey[400],),

        SizedBox(width: context.width*.05,),

        Flexible(
          child: Text(name ,style: GoogleFonts.gabriela(color: Colors.black),
            overflow: TextOverflow.ellipsis,),
        ),

      ],
    ),

    // just draw a horizontal line at the bottom border in the app bar
    bottom: PreferredSize(child: Divider(color: Colors.cyan,height: 0,thickness: 1,), preferredSize: Size(double.infinity, .1)),
  );
}


class ChatRoomBottomBar extends StatelessWidget {

  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:  BoxDecoration(
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),

        child: Row(
          children: <Widget>[

            // try use flex
            Flexible(
              child: TextField(
                focusNode: _focusNode,
                controller: _controller,
                maxLines: 4,
                minLines: 1,
                decoration: InputDecoration(
                    suffixIcon:Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Wrap(

                        direction: Axis.horizontal,
                        runAlignment: WrapAlignment.center,
                        spacing: 0,
                        runSpacing: 0,
                        children: [
                          GestureDetector(child: Icon(Icons.camera_alt,color: Colors.blue,size: 30,),onTap: ()async=>await _sendImage(context, ImageSource.camera),),
                          SizedBox(width: context.width * .01,),
                          GestureDetector(child: Icon(Icons.image,color: Colors.blue,size: 30,),onTap: ()async=>await _sendImage(context, ImageSource.gallery)),
                        ],
                      ),
                    ),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide: BorderSide.none),
                    filled: true,
                    hintText: "Write some thing",
                    hintStyle: TextStyle(fontSize: 17,color: Colors.grey[700]),
                    fillColor: Colors.grey[200],
                    contentPadding: EdgeInsets.symmetric(horizontal: 20,vertical: 10)
                ),
                style: TextStyle(fontSize: context.height *.1 / 3.5,color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ),
            IconButton(
                icon: Icon(Icons.send,color:Colors.blue,size: context.width*.09,),
                onPressed: (){
                  if(_controller.text.isNotEmpty)
                    context.provider<ChatP>().sendMessage(Message(senderId: context.provider<AppP>().user.remoteId,time: DateTime.now(),messageType: MessageType.text,message: _controller.text));
                  _controller.text = "";
                }
            ),

          ],
        ),
      ),

    );
  }

  Future _sendImage(BuildContext context,ImageSource source)async{
    PickedFile pickedFile = await ImagePicker().getImage(source: source,imageQuality: 10);
    if(pickedFile != null){
      List<int> bytes = await pickedFile.readAsBytes();
      var _base64 = base64Encode(bytes);
      context.provider<ChatP>().sendMessage(
        Message(senderId:context.provider<AppP>().user.remoteId,messageType: MessageType.image,message: _base64,time: DateTime.now())
      );
    }
  }

}

