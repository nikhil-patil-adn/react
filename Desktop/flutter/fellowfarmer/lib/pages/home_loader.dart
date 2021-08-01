import 'package:flutter/material.dart';

class HomeLoader extends StatefulWidget {
  @override
  _HomeLoaderState createState() => _HomeLoaderState();
}

class _HomeLoaderState extends State<HomeLoader> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Image.asset(
      'assets/images/home_loader.gif',
      fit: BoxFit.fill,
    ));
  }
}
