import 'dart:math';

import 'package:flutter/material.dart';
import 'package:map_builder/dimension.dart';

abstract class TileMap extends StatefulWidget {
  ///width of the map
  final List<List<String>> map;

  /// width of a square tile
  final double tileSize;

  /// position of the top left corner of the viewport
  final Point viewPortPosition;

  const TileMap({
    @required this.map,
    @required this.tileSize,
    @required this.viewPortPosition,
  })  : assert(map != null),
        assert(tileSize != null && tileSize > 0),
        assert(viewPortPosition != null);

  Dimension viewPortSizeInTile(BoxConstraints constraints) {
    print(constraints);
    return Dimension(
        width: (constraints.maxWidth / tileSize).floor(),
        height: (constraints.maxHeight / tileSize).floor());
  }
}
