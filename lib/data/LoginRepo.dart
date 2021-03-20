import 'package:ana_hna/data/apis/LoginApi.dart';
import 'package:m7utils/m7utils.dart';

class LoginR {

  LoginApi _loginApi;
  M7Client _m7client;
  LoginR(this._m7client):
      _loginApi = LoginApi(_m7client);

  Future<Map> loginOrSignUp(String email,String password,{String name,bool signUp = false})async
    => await _loginApi.loginOrSignUp(email, password,name: name,signUp: signUp);



}