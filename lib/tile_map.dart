import 'dart:math';

import 'package:flutter/material.dart';
import 'package:map_builder/dimension.dart';

abstract class TileMap extends StatelessWidget {
  ///width of the map
  final List<List<String>> map;

  /// width of a square tile
  final double tileSize;

  /// position of the top left corner of the viewport
  final Point viewPortPosition;

  final Function onTap;
  final Function onHorizontalDragStart;
  final Function onHorizontalDragUpdate;
  final Function onHorizontalDragCancel;
  final Function onHorizontalDragDown;
  final Function onHorizontalDragEnd;
  final Function onVerticalDragStart;
  final Function onVerticalDragUpdate;
  final Function onVerticalDragCancel;
  final Function onVerticalDragDown;
  final Function onVerticalDragEnd;
  final Function onDragStart;
  final Function onDragUpdate;
  final Function onDragCancel;
  final Function onDragDown;
  final Function onDragEnd;

  const TileMap({
    @required this.map,
    @required this.tileSize,
    @required this.viewPortPosition,
    this.onTap,
    this.onHorizontalDragStart,
    this.onHorizontalDragUpdate,
    this.onHorizontalDragCancel,
    this.onHorizontalDragDown,
    this.onHorizontalDragEnd,
    this.onVerticalDragStart,
    this.onVerticalDragUpdate,
    this.onVerticalDragCancel,
    this.onVerticalDragDown,
    this.onVerticalDragEnd,
    this.onDragStart,
    this.onDragUpdate,
    this.onDragCancel,
    this.onDragDown,
    this.onDragEnd,
  })  : assert(map != null),
        assert(tileSize != null && tileSize > 0),
        assert(viewPortPosition != null);

  Dimension viewPortSizeInTile(BoxConstraints constraints) {
    return Dimension(
        width: (constraints.maxWidth / tileSize).floor(),
        height: (constraints.maxHeight / tileSize).floor());
  }

  Point normalizeScreenPosition(Offset screenPosition) {
    return Point((screenPosition.dy / tileSize).floor(),
        (screenPosition.dx / tileSize).floor());
  }

  void mOnHorizontalDragStart(DragStartDetails details) {
    Point normalizedPosition = normalizeScreenPosition(details.globalPosition);

    this.mDragStart(normalizedPosition);
    if (onHorizontalDragStart != null)
      onHorizontalDragStart(normalizedPosition);
  }

  void mHorizontalDragUpdate(DragUpdateDetails details) {
    Point normalizedPosition = normalizeScreenPosition(details.globalPosition);

    this.mDragUpdate(normalizedPosition);
    if (onHorizontalDragUpdate != null)
      onHorizontalDragUpdate(normalizedPosition);
  }

  void mHorizontalDragCancel() {
    this.mDragCancel();
    if (onHorizontalDragCancel != null) onHorizontalDragCancel();
  }

  void mHorizontalDragDown(DragDownDetails details) {
    Point normalizedPosition = normalizeScreenPosition(details.globalPosition);

    this.mDragDown(normalizedPosition);
    if (onHorizontalDragDown != null) onHorizontalDragDown(normalizedPosition);
  }

  void mHorizontalDragEnd(DragEndDetails details) {
    this.mDragEnd(details);
    if (onHorizontalDragEnd != null) onHorizontalDragEnd(details);
  }

  void mVerticalDragStart(DragStartDetails details) {
    Point normalizedPosition = normalizeScreenPosition(details.globalPosition);

    this.mDragStart(normalizedPosition);
    if (onVerticalDragStart != null)
      onVerticalDragStart(normalizeScreenPosition(details.globalPosition));
  }

  void mVerticalDragUpdate(DragUpdateDetails details) {
    Point normalizedPosition = normalizeScreenPosition(details.globalPosition);
    this.mDragUpdate(normalizedPosition);
    if (onVerticalDragUpdate != null)
      onVerticalDragUpdate(normalizeScreenPosition(details.globalPosition));
  }

  void mVerticalDragCancel() {
    this.mDragCancel();
    if (onVerticalDragCancel != null) onVerticalDragCancel();
  }

  void mVerticalDragDown(DragDownDetails details) {
    Point normalizedPosition = normalizeScreenPosition(details.globalPosition);

    this.mDragDown(normalizedPosition);
    if (onVerticalDragDown != null)
      onVerticalDragDown(normalizeScreenPosition(details.globalPosition));
  }

  void mVerticalDragEnd(DragEndDetails details) {
    this.mDragEnd(details);
    if (onVerticalDragEnd != null) onVerticalDragEnd((details));
  }

  void mDragStart(Point position) {
    if (onDragStart != null) onDragStart(position);
  }

  void mDragUpdate(Point position) {
    if (onDragUpdate != null) onDragUpdate(position);
  }

  void mDragCancel() {
    if (onDragCancel != null) onDragCancel();
  }

  void mDragDown(Point position) {
    if (onDragDown != null) onDragDown(position);
  }

  void mDragEnd(DragEndDetails details) {
    if (onDragEnd != null) onDragEnd(details);
  }
}
