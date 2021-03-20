import 'package:ana_hna/providers/AppProvider.dart';
import 'package:ana_hna/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:m7utils/m7utils.dart';
import 'package:provider/provider.dart';
mixin M7Mixin{

  void goTo(BuildContext context,List<ChangeNotifierProvider> provider,Widget widget,{bool clearTask = false}){
    context.navigateTo(
        MultiProvider(
          providers: [
            ChangeNotifierProvider<AppP>.value(value: context.provider<AppP>()),
            if(provider != null) ...provider
          ],
          child: widget,
        ),
        clearStack: clearTask
    );
  }

  AppP getAppP(BuildContext context) => context.provider<AppP>();

  bool responseChecker(Map res) => res['resultCode'] == 100 ? true : false;


  Future<bool> waitForResponse(BuildContext context,{@required Function doo,Function(Map) onSuccess,Function(Map) onField})async{
    showM7WaitDialog(context);
    Map res=  await doo();
    await Future.delayed(Duration(seconds: 2));
    context.pop();
    if(responseChecker(res)){
      if(onSuccess != null) onSuccess(res);
      return true;
    }
    if(onField != null) onField(res);
    return false;
  }

  void showM7OkCancelDialog({Widget widget,BuildContext context,Function onOk,Function onCancel}){
    showDialog(
        context: context,
        builder: (context)
        => SimpleDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          children: <Widget>[
            SizedBox(
              height:context.height *.05,),
            widget,
            SizedBox(height: context.height *.05,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FlatButton(onPressed: (){ context.pop(); if(onOk != null) onOk();}, child: Text(context.translate('Ok') )),
                FlatButton(onPressed: (){ context.pop(); if(onCancel != null) onCancel();}, child: Text(context.translate('Cancel'))),
              ],
            )
          ],
        )
    );
  }


  void showM7ErrorDialog(Widget widget,BuildContext context) {
    showDialog(

      context: context,
      builder: (context)
      => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        content: Container(
          height: context.height *  .4,
          width: context.height *  .8,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: context.height *  .01,),
              Text(context.translate('Error'),style: TextStyle(color: Colors.red,fontSize: 15,),textAlign: TextAlign.center,),
              SizedBox(height:context.height * .05,),
              widget,
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  FlatButton(onPressed: ()=>context.pop(), child: Text(context.translate('Ok'),style: TextStyle(color: AppColors.primary),))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Future showM7WaitDialog(BuildContext context,{Widget widget,GlobalKey key}){
    return showDialog(

        context: context,
        builder: (context)
        => SimpleDialog(
          key: key,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          children: <Widget>[
            SizedBox(height: context.width * .05,),
            Center(child: Text(context.translate('Please_Wait'))),
            SizedBox(height: context.height * .05,),
            widget ?? Center(child: CircularProgressIndicator(),),
            SizedBox(height: context.height * .05,),
          ],
        )
    );

  }

}