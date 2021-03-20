import 'package:ana_hna/providers/AppProvider.dart';
import 'package:flutter/material.dart';
import 'package:m7utils/m7utils.dart';

enum InternetDataState{
  Loading,NoInternet,Data
}

class InternetAble extends StatelessWidget {

  final InternetDataState internetDataState;
  final Widget onLoading;
  final Widget onNoInternet;
  final Widget onData;
  final Function(BuildContext) onPressed;

  const InternetAble({ this.onLoading, this.onNoInternet,@required this.onData,@required this.onPressed,this.internetDataState = InternetDataState.Loading}) ;

  @override
  Widget build(BuildContext context) =>_checkInternetState(context);


  Widget _onNoInternet(BuildContext context) => Padding(
    padding: const EdgeInsets.all(20.0),
    child: Center(
      child: Column(
        children: [
          SizedBox(height: context.height * .03,),
          Text(context.translate('Some_Wrong'),textAlign: TextAlign.center,),
          SizedBox(height: context.height * .05,),
          FlatButton(color: context.provider<AppP>().second,
              shape: StadiumBorder(),
              onPressed: ()=>this.onPressed(context),
              child: Text(context.translate('Try_Again'),style: context.textTheme.headline3.copyWith(color: context.provider<AppP>().primary),)),
          SizedBox(height: context.height * .05,),

        ],),),
  );

  Widget _onLoading(BuildContext context)=>Padding(
    padding: const EdgeInsets.all(20.0),
    child: Center(child: CircularProgressIndicator(),),
  );


  Widget _checkInternetState(BuildContext context){
    Widget widget;
    switch(this.internetDataState){
      case InternetDataState.Loading:
        widget = this.onLoading ?? _onLoading(context);
        break;
      case InternetDataState.NoInternet:
        widget = this.onNoInternet ?? _onNoInternet(context);
        break;
      case InternetDataState.Data:
        widget = this.onData;
        break;
    }
    return widget;
  }
}