import 'package:carousel_slider/carousel_slider.dart';
import 'package:fellowfarmer/api/api.dart';
import 'package:flutter/material.dart';

import 'product_detail.dart';

class ShowProductBanner extends StatefulWidget {
  ShowProductBanner({Key? key}) : super(key: key);

  @override
  _ShowProductBannerState createState() => _ShowProductBannerState();
}

class _ShowProductBannerState extends State<ShowProductBanner> {
  var products = [];
  var displaydata = '0';
  void initState() {
    super.initState();
    print("fetch product list");
    var obj = new Api();
    obj.fetchProductList().then((value) {
      setState(() {
        displaydata = '1';
        products = value;
      });
    });
  }

  //fetchProductList() async {}

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CarouselSlider(
        options: CarouselOptions(
          height: 100.0,
          autoPlay: true,
          viewportFraction: 0.9,
        ),
        items: products.map((i) {
          return Builder(
            builder: (BuildContext context) {
              return Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                  //decoration: BoxDecoration(color: Colors.amber),
                  child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProductDetail(
                                  code: i['code'], quantity: '0')),
                        );
                      },
                      child: Image.network(
                        i['image'],
                        fit: BoxFit.fill,
                      )));
            },
          );
        }).toList(),
      ),
    );
  }
}
