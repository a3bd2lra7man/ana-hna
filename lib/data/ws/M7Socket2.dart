import 'dart:convert';
import 'dart:io';

class _SocketHelper {
  String eventName;
  dynamic data;
  _SocketHelper.fromEvent(dynamic event){
    Map map = json.decode(event);
    eventName = map['event'];
    data = map['data'];

  }
}

class M7Socket{

  static M7Socket _m7socket;


  M7Socket._();

  factory M7Socket(){
    if(_m7socket == null){
      _m7socket = M7Socket._();
    }
    return _m7socket;
  }

  WebSocket _webSocket;
  Future connect(String url)async{
    try{
      _webSocket = await WebSocket.connect(url);
      _addListeners();
    }catch(e){
      print("M7Socket Exception : $e");
      _webSocket = null;
    }
  }
  void add({String event,Map message}){
    _webSocket.add(json.encode({"event":event,...message}));
  }
  void _addListeners() {
    _webSocket.listen(_onData,cancelOnError: false,onDone: _onDone,onError: _onError);
  }

  void _onData( event) {
    _SocketHelper _socketHelper = _SocketHelper.fromEvent(event);
    _SocketEventHandler handler = _eventHandler[_socketHelper.eventName];
    if( handler != null){
      handler(_socketHelper.data);
    }

  }

  Map<String,_SocketEventHandler> _eventHandler = {};
  void on(String eventName,_SocketEventHandler doo){
    _eventHandler[eventName] = doo;
  }

  void _onDone() {
    print("M7Socket : Done");
    _webSocket?.close();
    _webSocket = null;
  }

  _onError(e) {
    print("M7Socket : Error");
    if(e != null) print(e);
    _webSocket?.close();
    _webSocket = null;
  }
}

typedef _SocketEventHandler = Function(dynamic);
