import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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


  onTileTap(int index, context){
    print("tile: $index tapped");
    print(" display widht ${MediaQuery.of(context).size.width} height :${MediaQuery.of(context).size.height}");

  }
  
  buildRow(int rowNumber, Dimension viewPortTileSize, context) {
    List<Tile> tiles = [];

    for (int i = widget.viewPortPosition.x;
        i < widget.viewPortPosition.x + viewPortTileSize.width;
        i++) {
      if (i < widget.map[rowNumber].length) {
        tiles.add(Tile(
          assetsName: widget.map[rowNumber][i],
          size: widget.tileSize,
          onTap: (){
            onTileTap(rowNumber* widget.map[rowNumber].length + i, context);
            print("position col: $i row: $rowNumber");

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

    for (int i = widget.viewPortPosition.y;
        i < widget.viewPortPosition.y + viewPortTileSize.height;
        i++) {
      if (i < widget.map.length && i* widget.tileSize <= height) {
        rows.add(buildRow(i, viewPortTileSize, context));
      }
    }

    return rows;
  }

  buildMap(BuildContext context) {

    if (widget.map.isEmpty) return Container();

    return LayoutBuilder(
      builder: (context, constraints) {
        Dimension viewPortTileSize = widget.viewPortSizeInTile(constraints);
        print(viewPortTileSize);
        print(constraints);
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
    return buildMap(context);
  }
}
