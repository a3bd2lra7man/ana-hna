
import 'dart:convert';
import 'dart:io';

import 'package:ana_hna/data/ws/M7Socket2.dart';
import 'package:flutter/material.dart';

class SocketMessage{
  String event;
  dynamic data;

  SocketMessage.fromDynamic(dynamic message){
    Map map = json.decode(message);
    event = map['event'];
    data = map['data'];
  }
}

class AppSocket{

  M7Socket _webSocket;
  M7Socket get ws {
    if(_webSocket == null) _webSocket = M7Socket();
    return _webSocket;
  }


  void register(String id)async{
    ws.add(event:'registerC',message: {"id":id});
  }


  Future connect({String url}) async{
    try{
      await ws.connect(url);
    }catch(e){
      _webSocket = null;
      print("M7: WebSocket Exception : $e");
    }
  }


}