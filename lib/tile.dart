import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';

class Tile extends StatefulWidget {
  final String assetsName;
  final double size;
  final Function onTap;

  Tile({this.assetsName, this.size, this.onTap});

  @override
  State<StatefulWidget> createState() => TileState(this.onTap);
}

class TileState extends State<Tile> {
  Function onTap;
  TileState(this.onTap);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Image.asset(
        widget.assetsName,
        width: widget.size ,
        height: widget.size ,
        fit: BoxFit.cover,
      ),
      onTap: onTap
    );
  }
}
