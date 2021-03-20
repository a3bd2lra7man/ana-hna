import 'package:m7utils/m7utils.dart';

class LoginApi {
  M7Client _m7client;

  LoginApi(this._m7client);

  Future<Map> loginOrSignUp(String email,String password,{String name,bool signUp})async =>
      await _m7client.request(
        requestType: RequestType.post,
        url: 'users/${signUp?'signUp':'login'}',
        data: {"email":email,"password":password,if(signUp)"name":name}
      );

}

