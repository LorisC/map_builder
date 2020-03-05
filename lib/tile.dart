import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';

class Tile extends StatefulWidget {
  final String assetsName;
  final double size;
  final Function onTap;
  Tile({this.assetsName, this.size, this.onTap});

  @override
  State<StatefulWidget> createState() => TileState( );
}

class TileState extends State<Tile> {
  Point position;
  Function onTap;
  TileState();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Image.asset(
        widget.assetsName,
        width: widget.size ,
        height: widget.size ,
        fit: BoxFit.cover,
      ),
      onTap: () {
        widget.onTap(position);
      },
    );
  }
}
