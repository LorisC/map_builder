import 'dart:math';

import 'package:flutter/material.dart';
import 'package:map_builder/dimension.dart';
import 'package:map_builder/tile.dart';
import 'package:map_builder/tile_map.dart';

class TileMapContainer extends TileMap {
  const TileMapContainer({
    @required List<List<String>> map,
    @required double tileSize,
    @required Point viewPortPosition,
    onTap,
    onHorizontalDragStart,
    onHorizontalDragUpdate,
    onHorizontalDragCancel,
    onHorizontalDragDown,
    onHorizontalDragEnd,
    onVerticalDragStart,
    onVerticalDragUpdate,
    onVerticalDragCancel,
    onVerticalDragDown,
    onVerticalDragEnd,
    onDragStart,
    onDragUpdate,
    onDragCancel,
    onDragDown,
    onDragEnd,
  })  : assert(map != null),
        assert(tileSize != null && tileSize > 0),
        super(
          map: map,
          tileSize: tileSize,
          viewPortPosition: viewPortPosition,
          onTap: onTap,
          onHorizontalDragStart: onHorizontalDragStart,
          onHorizontalDragUpdate: onHorizontalDragUpdate,
          onHorizontalDragCancel: onHorizontalDragCancel,
          onHorizontalDragDown: onHorizontalDragDown,
          onHorizontalDragEnd: onHorizontalDragEnd,
          onVerticalDragStart: onVerticalDragStart,
          onVerticalDragUpdate: onVerticalDragUpdate,
          onVerticalDragCancel: onVerticalDragCancel,
          onVerticalDragDown: onVerticalDragDown,
          onVerticalDragEnd: onVerticalDragEnd,
          onDragStart: onDragStart,
          onDragUpdate: onDragUpdate,
          onDragCancel: onDragCancel,
          onDragDown: onDragDown,
          onDragEnd: onDragEnd,
        );

  buildRow(int rowNumber, Dimension viewPortTileSize, context) {
    List<Tile> tiles = [];

    for (int i = viewPortPosition.x;
        i < viewPortPosition.x + viewPortTileSize.width;
        i++) {
      if (i < map[rowNumber].length) {
        tiles.add(Tile(
          assetsName: map[rowNumber][i],
          size: tileSize,
          onTap: () {
            onTap(rowNumber, i);
          },
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

  buildRows(Dimension viewPortTileSize, double height, context) {
    List<Row> rows = [];

    for (int i = viewPortPosition.y;
        i < viewPortPosition.y + viewPortTileSize.height;
        i++) {
      if (i < map.length && i * tileSize <= height) {
        rows.add(buildRow(i, viewPortTileSize, context));
      }
    }

    return rows;
  }

  buildMap(BuildContext context) {
    if (map.isEmpty) return Container();

    return LayoutBuilder(
      builder: (context, constraints) {
        Dimension viewPortTileSize = viewPortSizeInTile(constraints);
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: buildRows(viewPortTileSize, constraints.maxHeight, context),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: buildMap(context),
      onHorizontalDragStart: mOnHorizontalDragStart,
      onHorizontalDragUpdate: mHorizontalDragUpdate,
      onHorizontalDragCancel: mHorizontalDragCancel,
      onHorizontalDragDown: mHorizontalDragDown,
      onHorizontalDragEnd: mHorizontalDragEnd,
      onVerticalDragStart: mVerticalDragStart,
      onVerticalDragUpdate: mVerticalDragUpdate,
      onVerticalDragCancel: mVerticalDragCancel,
      onVerticalDragDown: mVerticalDragDown,
      onVerticalDragEnd: mVerticalDragEnd,
    );
  }
}
