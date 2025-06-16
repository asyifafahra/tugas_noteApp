import 'package:flutter/material.dart';

Color getNoteColor(int id) {
  final colors = Colors.primaries;
  return colors[id % colors.length].shade100;
}
