import 'package:ana_hna/data/db/models/Placer.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui' as ui;


class MapProvider extends ChangeNotifier{
  Map<String,BitmapDescriptor> marks = {};
  BitmapDescriptor defaultMark;
  MapProvider(Set<Placer> placers){
    _loadDefaultMarker();
    _getMarks(placers);
  }

  Future _loadDefaultMarker()async {
    defaultMark =  await BitmapDescriptor
        .fromAssetImage(ImageConfiguration(devicePixelRatio: 2.5),
        'assets/pic/marker.png');
    notifyListeners();
  }



  // drawing circle marker to the map helper
  Future<ui.Image> _getImageFromPath(Uint8List picture) async {

    final Completer<ui.Image> completer = new Completer();
    ui.decodeImageFromList(picture, (ui.Image img) {
      return completer.complete(img);
    });
    return completer.future;
  }

  // drawing circle marker to the map
  Future<Uint8List> _getBytesFromCanvas( Size size,String sourceImage) async  {
    if(sourceImage == null) return null;

    final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);
    final Paint paint = Paint()..color = Colors.black;
    final Radius radius = Radius.circular(size.width/2);
    final Paint borderPaint = Paint()..color = Colors.white;
    final  shadowWidth = 6.0;
    canvas.drawRRect(
        RRect.fromRectAndCorners(
          Rect.fromLTWH(0.0, 0.0, size.width.toDouble(),  size.height.toDouble()),
          topLeft: radius,
          topRight: radius,
          bottomLeft: radius,
          bottomRight: radius,
        ),
        paint);
    canvas.drawRRect(
        RRect.fromRectAndCorners(
          Rect.fromLTWH(
              shadowWidth,
              shadowWidth,
              size.width - (shadowWidth * 2),
              size.height - (shadowWidth * 2)
          ),
          topLeft: radius,
          topRight: radius,
          bottomLeft: radius,
          bottomRight: radius,
        ),
        borderPaint);

    final double imageOffset = 10;
    Rect oval = Rect.fromLTWH(
        imageOffset,
        imageOffset,
        size.width - (imageOffset * 2),
        size.height - (imageOffset * 2)
    );

    // Add path for oval image
    canvas.clipPath(Path()
      ..addOval(oval));

    ui.Image image = await _getImageFromPath(base64Decode(sourceImage)); // Alternatively use your own method to get the image
    paintImage(canvas: canvas, image: image, rect: oval, fit: BoxFit.fitWidth);

    // Convert canvas to image
    final ui.Image markerAsImage = await pictureRecorder.endRecording().toImage(
        size.width.toInt(),
        size.height.toInt()
    );
    final ByteData byteData = await markerAsImage.toByteData(format: ui.ImageByteFormat.png);
    final Uint8List uint8List = byteData.buffer.asUint8List();

    return uint8List;

  }

  void _getMarks(Set<Placer> placers) async{
    placers.forEach((element)async {
      if(element.image != null){
        Uint8List bytes = await _getBytesFromCanvas(Size(80, 80), element.image);
        marks[element.id] = BitmapDescriptor.fromBytes(bytes);
        notifyListeners();
      }
    });
  }


}