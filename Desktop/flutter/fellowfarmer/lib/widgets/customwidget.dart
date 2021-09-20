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

_elevatedBtnStyle() {
  return ElevatedButton.styleFrom(
    padding: EdgeInsets.symmetric(horizontal: 16),
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
        side: BorderSide(color: Color(0xFFed1c22))),
    // primary: Colors.transparent,
    primary: const Color(0xffed1c22), // background
    onPrimary: Colors.black, // foreground
  );
}

Widget elevatedBtnStyle() {
  return _elevatedBtnStyle();
}

class ImageDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: 20,
        height: 40,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: ExactAssetImage('assets/images/home_loader.gif'),
                fit: BoxFit.fill)),
      ),
    );
  }
}
