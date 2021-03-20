import 'package:ana_hna/data/db/models/Message.dart';
import 'package:ana_hna/data/db/models/Placer.dart';
import 'package:ana_hna/data/ws/M7Socket.dart';
import 'package:flutter/material.dart';

class ChatP extends ChangeNotifier{

  AppSocket _m7socket;
  Set onlinePlacers = {};
  
  ChatP(String id){
    print("ay");
    _initialWebSocket(id);

  }
  Map<String,List<Message>> messages = {};
  String currentRoom;
  void interRoom(String id){
    if(messages[id] == null)
      messages[id] = [];
    currentRoom = id;
    notifyListeners();
  }
  void sendMessage(Message message){
    messages[currentRoom].add(message);
    notifyListeners();
    _m7socket.ws.add(event: 'NewMessageC',message:{"message":message.toMap(),"id":currentRoom},);
  }
  void addMessage(Message message){
    messages[currentRoom].add(message);
    notifyListeners();
  }

  void _initialWebSocket(String id)async{
    _m7socket = AppSocket();
    _m7socket.connect(url: "ws://192.168.43.160:3000").then((value) {
      _m7socket.ws.on('addAllPlacers', (e){
        onlinePlacers.addAll(e);
        notifyListeners();
      });
      _m7socket.ws.on("removePlacer", (id){
        onlinePlacers.removeWhere((element) => element == id);
        notifyListeners();
      });
      _m7socket.ws.on("addAPlacer", (id){
        onlinePlacers.add(id);
        notifyListeners();
      });
      _m7socket.ws.on("NewMessageP", (data){
        var message = Message(senderId: data['senderId'],messageType: data['messageType'] == 0 ? MessageType.text : MessageType.image,
            message: data['message'],time: DateTime.parse(data['time'])
        );
        addMessage(message);
      });
      _m7socket.register(id);
    });
  }

}