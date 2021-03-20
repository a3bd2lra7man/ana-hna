import 'package:ana_hna/data/apis/HomeApi.dart';
import 'package:ana_hna/data/db/Dao/UserDao.dart';
import 'package:ana_hna/data/db/models/User.dart';
import 'package:m7utils/m7utils.dart';

class AppR {


  UserDao _userDao;
  M7Client _m7client;
  AppR(this._userDao,this._m7client);

  HomeApi get _homeApi => HomeApi(_m7client);

  Future logOut(User user)async => await _userDao.delete(user);

  Future<User> checkIfUserLogin()async => await _userDao.getById(1);

  Future saveUser (User user) async => await _userDao.insert(user);

  Future<bool> updateUserProfile (User user)async{
    Map res = await _homeApi.updateProfile(user.remoteId,name: user.name,image: user.image);
    if(res['resultCode'] == 100){
      var a =await saveUser(user);
      print(a);
      return true;
    }else return false;
  }
}