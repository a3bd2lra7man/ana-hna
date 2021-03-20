import 'package:ana_hna/data/HomeRepo.dart';
import 'package:ana_hna/data/db/models/Placer.dart';
import 'package:ana_hna/data/db/models/Post.dart';
import 'package:ana_hna/providers/AppProvider.dart';
import 'package:ana_hna/utils/M7Common.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:m7utils/m7utils.dart';
import 'package:location/location.dart' as locations;

class HomeP extends ChangeNotifier with M7Mixin{

  LatLng userLocation = LatLng(15.52759090188647, 32.52742398530245);
  Set<Placer> nearByPlacers ;
  Set<Post> posts;

  HomeR homeR;

  HomeP(BuildContext context){
    homeR = HomeR(context.provider<AppP>().m7client);
    getPermissions(context);

  }

  Future getPermissions(BuildContext context,{PermissionWithService permission =Permission.locationAlways})async{

    PermissionStatus status = await permission.status;
    switch (status) {
      case PermissionStatus.granted:
        await _getLocation(context);
        break;
      case PermissionStatus.undetermined:
        await _requestPermission(context,permission);
        break;
      case PermissionStatus.denied:
        _permissionDenied(context,permission);
        break;
      case PermissionStatus.permanentlyDenied:
        _permissionDenied(context,permission,isPermanent: true);
        break;
    // for IOS implementation
      case PermissionStatus.restricted:
        break;
      default:
    }

  }

  Future _requestPermission(BuildContext context,PermissionWithService permission)async {
    await permission.request();
    await getPermissions(context,permission:permission);

  }

  Future _permissionDenied(BuildContext context,PermissionWithService permission,{bool isPermanent = false}) async{
    showM7OkCancelDialog(
      context: context,
      widget: Center(child: Text(context.translate('Permission_Denied'),textAlign: TextAlign.center,),),
      onCancel: ()=>SystemChannels.platform.invokeMethod('SystemNavigator.pop'),
      onOk: ()async {

        if(isPermanent){
          await openAppSettings();
          await Future.delayed(Duration(seconds: 7));
        }
        await _requestPermission(context,permission) ;
      },
    );
  }

  Future _getLocation(BuildContext context) async{
    GlobalKey key = GlobalKey();
    locations.Location loc = locations.Location();
    await _askLocationService(loc);
    showM7WaitDialog(context,key: key,widget: Text(context.translate('Get_User_Location'),textAlign: TextAlign.center,));
    LatLng latLng = await _getCurrentLocation(loc);
    key.currentContext.pop();
    print(latLng);
    userLocation = latLng;
    notifyListeners();
    await _getPlacers(userLocation);

  }

  Future<LatLng> _getCurrentLocation(locations.Location loc) async {
    locations.LocationData locationData = await loc.getLocation();
    return LatLng(locationData.latitude, locationData.longitude);
  }

  Future _askLocationService(locations.Location loc)async{
    if (!await loc.serviceEnabled()) {
      await loc.requestService();
      await _askLocationService(loc);
    }
  }

  Future _getPlacers(LatLng location) async{
    Map res = await homeR.getPlacers(location);
    nearByPlacers = (res['placers'] as List).map((e) => Placer.fromMap(e)).toSet();
    notifyListeners();
    print(nearByPlacers.length);
    await _getPosts(location);
  }

  Future _getPosts(LatLng location)async{
    Map res = await homeR.getPosts(location);
    posts = (res['posts'] as List).map((e) => Post.fromMap(e)).toSet();
    notifyListeners();
  }

}

