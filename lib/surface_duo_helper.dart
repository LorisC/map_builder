import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

final platform = const MethodChannel('duosdk.microsoft.dev');

Future<bool> isAppSpanned(BuildContext context) {
  return platform.invokeMethod('isAppSpanned');
}

Future<bool> isDualScreenDevice(BuildContext context) {
  return platform.invokeMethod('isDualScreenDevice');
}

Future<Size> getScreenRealDimension(BuildContext context) async {
  Size flutterScreenSize = MediaQuery.of(context).size;
  final drawingScreenSize = await platform.invokeMethod('getDrawingScreenSize');
  final displayMak = await platform.invokeMethod('getDisplayMask');

  double ratio = drawingScreenSize['width'] / flutterScreenSize.width;

  return Size(
    flutterScreenSize.width - (displayMak['width'] / ratio) / 2,
    flutterScreenSize.height - (displayMak['height'] / ratio),
  );
}

void funn() async {
  final displayMak = await platform.invokeMethod('getDisplayMask');
  print(displayMak);
  final drawingScreenSize = await platform.invokeMethod('getDrawingScreenSize');
  print(drawingScreenSize['width']);
}
Future<Hinge> getHinge(BuildContext context) async {
  Size flutterScreenSize = MediaQuery.of(context).size;
  final displayMak = await platform.invokeMethod('getDisplayMask');
  final drawingScreenSize = await platform.invokeMethod('getDrawingScreenSize');
  double ratio = drawingScreenSize['width'] / flutterScreenSize.width;

  return Hinge(
    dimension: Size(displayMak["width"] / ratio, displayMak["height"] / ratio),
    position: Point(displayMak["x"] / ratio, 0),
  );
}

class Hinge {
  Container hinge;
  Size dimension;
  Point position;

  Hinge({this.dimension, this.position}) {
    hinge = Container(
      height: this.dimension.height,
      width: this.dimension.width,
    );
  }
}
