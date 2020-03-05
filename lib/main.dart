import 'dart:math';

import 'package:flutter/material.dart';
import 'package:map_builder/surface_duo_helper.dart';
import 'package:map_builder/tile_map_container.dart';

import 'tile_map.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<List<String>> createMap(assetName) {
    List<List<String>> map = [];
    for (int i = 0; i < 40; i++) {
      List<String> row = [];
      for (int j = 0; j < 50; j++) {
        row.add(assetName);
      }
      map.add(row);
    }
    return map;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
          future: getHinge(context),
          initialData: Container(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Expanded(
                    child: TileMapContainer(
                        map: createMap("assets/images/PixelArt.png"),
                        viewPortPosition: Point(0, 0),
                        tileSize: 24),
                  ),
                  snapshot.data.hinge,
                  Expanded(
                    child: TileMapContainer(
                        map: createMap("assets/images/PixelArt.png"),
                        viewPortPosition: Point(0, 0),
                        tileSize: 24),
                  ),
                ],
              );
            } else
              return TileMapContainer(
                  map: createMap("assets/images/PixelArt.png"),
                  viewPortPosition: Point(0, 0),
                  tileSize: 24);
          },
        ),
      ),
    ); // This trailing comma makes auto-formatting nicer for build methods.
  }
}
