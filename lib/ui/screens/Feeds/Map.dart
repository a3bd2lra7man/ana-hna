import 'dart:async';
import 'package:ana_hna/providers/Home/MapProvider.dart';
import 'package:ana_hna/providers/HomeProvider.dart';
import 'package:ana_hna/ui/screens/Feeds/PlacerProfile.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:m7utils/m7utils.dart';

class AppMap extends StatelessWidget {

  final Completer<GoogleMapController> _controller =  Completer();
  @override
  Widget build(BuildContext context) {
    HomeP provider = context.watch<HomeP>();
    MapProvider mapProvider = context.watch<MapProvider>();
    return GoogleMap(
      initialCameraPosition: CameraPosition(target: provider.userLocation,zoom: 18),
      onMapCreated: _onMapCreated,
      markers: provider.nearByPlacers.map((e) 
        => Marker(
            markerId: MarkerId(e.id),
            position: LatLng(e.lat, e.lng),
            icon: mapProvider.marks[e.id] ?? mapProvider.defaultMark ?? BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan),
            infoWindow: InfoWindow(
              title: e.name,
              snippet: e.categoryEnName,
              onTap: (){
                context.navigateTo(PlacerProfile(e));
              }
            )
        ),
      ).toSet(),
    );
  }

  void _onMapCreated(GoogleMapController controller) => _controller.complete(controller);

}
