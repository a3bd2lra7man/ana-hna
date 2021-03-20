import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:m7utils/m7utils.dart';
class ImageConversation extends StatelessWidget {
  final bool isCurrentUser;
  final String image;
  const ImageConversation({this.image, this.isCurrentUser = false});

  @override
  Widget build(BuildContext context) {

    return Padding(

      padding: EdgeInsets.only(bottom: 8,left: (!isCurrentUser) ? context.width *.1 : 0,),

      child: Flex(

        mainAxisAlignment: isCurrentUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        direction: Axis.horizontal,

        children: <Widget>[

          Container(
            width: 130,
            height: 150,

            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                  image:image.startsWith('assets')? AssetImage(image) : MemoryImage(base64Decode(image)),
                  fit: BoxFit.fill
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class TextConversation extends StatelessWidget {
  final bool isCurrentUser;
  final String message;
  final double margin;
  const TextConversation({@required this.message,this.isCurrentUser = false, this.margin = 2});

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: EdgeInsets.only(bottom: margin),
      child: Flex(
        direction:Axis.horizontal,
        mainAxisAlignment: isCurrentUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: <Widget>[

          Container(
            margin: EdgeInsets.symmetric(horizontal: context.width *  (isCurrentUser ? .01 :.1)),
            padding: EdgeInsets.all(10),
            constraints: BoxConstraints(
                maxWidth: context.width*.7
            ),
            decoration: BoxDecoration(
              color: isCurrentUser ? Colors.blue : Colors.grey[300],
              borderRadius: BorderRadius.circular(15),
            ),

            child: Text(
                this.message,
                textAlign: TextAlign.center,
                style: TextStyle(height: 1.1,color:isCurrentUser ? Colors.white :Colors.black,fontWeight: FontWeight.bold)
            ),
          ),

        ],
      ),
    );
  }
}

