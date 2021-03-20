class Message{

  String senderId,message;
  MessageType messageType;
  DateTime time;

  Message({this.senderId,this.messageType,this.message,this.time });

  Map<String, dynamic> toMap()=>{
    "senderId":senderId,
    "messageType":messageType == MessageType.text ? 0 : 1,
    "message":message,
    "time":time.toIso8601String()
  };
}

enum MessageType{
  text,image
}


var messages = [
  Message(
    senderId: "1",
    message: "Hi",
    messageType: MessageType.text,
    time: DateTime.now(),
  ),
  Message(
    senderId: "1",
    message: "How are u",
    messageType: MessageType.text,
    time: DateTime.now(),
  ),
  Message(
    senderId: "2",
    message: "iam good how are you ?",
    messageType: MessageType.text,
    time: DateTime.now(),
  ),

  Message(
    senderId: "1",
    message: "iam good thanks to god",
    messageType: MessageType.text,
    time: DateTime.now(),
  ),
  Message(
    senderId: "2",
    message: "What do you think about this picture",
    messageType: MessageType.text,
    time: DateTime.now(),
  ),
  Message(
    senderId: "2",
    message: "assets/pic/a.jpg",
    messageType: MessageType.image,
    time: DateTime.now(),
  ),
  Message(
    senderId: "2",
    message: "assets/pic/splah1.jpg",
    messageType: MessageType.image,
    time: DateTime.now(),
  ),
  Message(
    senderId: "1",
    message: "Wow there are so beautiful",
    messageType: MessageType.text,
    time: DateTime.now(),
  ),

]..reversed;