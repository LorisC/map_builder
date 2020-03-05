import 'dart:math';
import 'package:flutter/material.dart';
import 'package:map_builder/dimension.dart';
import 'package:map_builder/tile.dart';
import 'package:map_builder/tile_map.dart';

class TileMapContainer extends TileMap {
  const TileMapContainer(
      {@required List<List<String>> map,
      @required double tileSize,
      @required Point viewPortPosition})
      : assert(map != null),
        assert(tileSize != null && tileSize > 0),
        super(map: map, tileSize: tileSize, viewPortPosition: viewPortPosition);

  @override
  State<StatefulWidget> createState() => TileMapContainerState();
}

class TileMapContainerState extends State<TileMapContainer> {
  buildRow(int rowNumber, Dimension viewPortTileSize) {
    List<Tile> tiles = [];

    for (int i = widget.viewPortPosition.x;
        i < widget.viewPortPosition.x + viewPortTileSize.width;
        i++) {
      if (i < widget.map[rowNumber].length) {
        tiles.add(Tile(
          assetsName: widget.map[rowNumber][i],
          size: widget.tileSize,

        ));
      }
    }
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: tiles,
    );
  }

  buildRows(Dimension viewPortTileSize, double height) {
    List<Row> rows = [];

    for (int i = widget.viewPortPosition.y;
        i < widget.viewPortPosition.y + viewPortTileSize.height;
        i++) {
      if (i < widget.map.length && i* widget.tileSize <= height) {
        rows.add(buildRow(i, viewPortTileSize));
      }
    }

    return rows;
  }

  buildMap(BuildContext context) {

    if (widget.map.isEmpty) return Container();

    return LayoutBuilder(
      builder: (context, constraints) {
        Dimension viewPortTileSize = widget.viewPortSizeInTile(constraints);

        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: buildRows(viewPortTileSize, constraints.maxHeight),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return buildMap(context);
  }
}
