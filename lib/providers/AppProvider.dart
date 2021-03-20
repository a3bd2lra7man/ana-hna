import 'package:ana_hna/data/AppRepo.dart';
import 'package:ana_hna/data/LoginRepo.dart';
import 'package:ana_hna/data/db/AppDB.dart';
import 'package:ana_hna/data/db/Dao/UserDao.dart';
import 'package:ana_hna/data/db/models/User.dart';
import 'package:ana_hna/providers/loginProvider.dart';
import 'package:ana_hna/ui/screens/Home.dart';
import 'package:ana_hna/ui/screens/Login.dart';
import 'package:ana_hna/utils/M7Common.dart';
import 'package:ana_hna/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:m7utils/m7utils.dart';
import 'package:provider/provider.dart';

import 'HomeProvider.dart';

class AppP extends ChangeNotifier  with M7Mixin{

  MaterialColor primary = AppColors.second;
  MaterialColor second = AppColors.primary;
  Future<AppR> get _appR async{
        var db = await AppDB().database;
        return AppR(UserDao(db, User.tableName),m7client);
  }

  String _localeName = 'ar';
  String _localHost = "http://192.168.43.160:3000/api";
  M7Client m7client ;

  User user;
  String get localeName => _localeName;

  AppP(){
    m7client = M7Client(localhost: _localHost);
    _checkLocalePre();
  }

  void _checkLocalePre() async{
    _localeName = await getStringFromSharedPreferences('locale') ?? 'en';
    notifyListeners();
  }


  void changeAppLocale(String localeCode)async{
    _localeName = localeCode;
    await setStringInSharedPreference('locale', _localeName);
    notifyListeners();
  }

  Future saveUser(User user) async => await(await _appR).saveUser(user);

  void checkUserLogin(BuildContext context)async{
     User user =await(await _appR).checkIfUserLogin();
     print(user);
     if(user == null){
       goTo(context,[ChangeNotifierProvider<LoginP>(create:(context)=> LoginP(LoginR(m7client)))], Login(),clearTask: true);
     }
     else{
       this.user = user;
        goTo(context, null,
            ChangeNotifierProvider<HomeP>(create: (context)=>HomeP(context),child: Home()),
            clearTask: true);
     }
  }

  void logout(BuildContext context)async{
    showM7OkCancelDialog(
        context: context,
        widget: Center(child: Text(context.translate('Are_Your_Sure'))),
        onOk: ()async{
          await(await _appR).logOut(user);
          checkUserLogin(context);
        },
    );
  }

  void updateUserInfo(BuildContext context,User newUser)async{
    GlobalKey key = GlobalKey();
    showM7WaitDialog(context,key: key);
    bool res = await (await _appR).updateUserProfile(newUser);
    await Future.delayed(Duration(seconds: 1));
    key.currentContext.pop();
    if(res) {
      this.user = newUser;
      notifyListeners();
      context.pop();
    }else{
      showM7ErrorDialog(Text(_localeName == 'en' ? 'check your internet connection' : 'تفقد حالة البيانات',textAlign: TextAlign.center,), context);
    }
  }

  void changeTheme(){
    var color= this.primary;
    var color2 = this.second;
    this.primary = color2;
    this.second = color;
    notifyListeners();
  }

}
