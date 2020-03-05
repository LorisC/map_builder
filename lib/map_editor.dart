import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'surface_duo_helper.dart';
import 'tile_map_container.dart';

class MapEditor extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MapEditorState();
}

class MapEditorState extends State<MapEditor> {
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

  MapEditorState() {
    map = createMap("assets/images/PixelArt.png");
  }

  List<List<String>> map;
  List<String> assets = [
    'assets/images/PixelArt.png',
    'assets/images/lava.jpg'
  ];
  int currentAssetIndex = 1;

  void onAssetSelected(int index) {
    setState(() {
      currentAssetIndex = index;
    });
  }

  void onTileSelected(int x, int y) {
    setState(() {
      if (x >= 0 && x < map.length && y >= 0 && y < map[0].length)
        map[x][y] = assets[currentAssetIndex];
    });
  }

  void onMapDragged(Point position) {
    this.onTileSelected(position.x, position.y);
  }

  List<TileButton> buildButtons() {
    List<TileButton> buttons = [];
    for (int i = 0; i < assets.length; i++) {
      buttons.add(TileButton(
        assetName: assets[i],
        onTap: () {
          onAssetSelected(i);
        },
        size: 200.0,
      ));
    }
    return buttons;
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder(
          future: getHinge(context),
          initialData: null,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData && snapshot.data != null) {
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Expanded(
                    child: TileMapContainer(
                      map: map,
                      viewPortPosition: Point(0, 0),
                      tileSize: 24,
                      onTap: onTileSelected,
                    ),
                  ),
                  snapshot.data.hinge,
                  Expanded(
                      child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: buildButtons())),
                ],
              );
            } else
              return TileMapContainer(
                map: map,
                viewPortPosition: Point(0, 0),
                tileSize: 24,
                onTap: onTileSelected,
                onDragUpdate: onMapDragged,
              );
          },
        ),
      ),
    ); // This trailing comma makes auto-formatting nicer for build methods.
  }
}

class TileButton extends StatelessWidget {
  final assetName;
  final onTap;
  final size;

  const TileButton({Key key, this.assetName, this.onTap, this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Image.asset(
        assetName,
        width: size,
        height: size,
      ),
      onTap: onTap,
    );
  }
}
