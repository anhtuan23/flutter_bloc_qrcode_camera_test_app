import 'package:flutter/material.dart';

class CapturedImage {
  final String path;
  final double longtitude;
  final double latitude;
  const CapturedImage({
    @required this.path,
    @required this.longtitude,
    @required this.latitude,
  });
}
