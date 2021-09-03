import 'package:flutter/material.dart';

Widget lineargradientbg() {
  return Container(
    decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFcea335), Color(0xFFed1c22)])),
  );
}
