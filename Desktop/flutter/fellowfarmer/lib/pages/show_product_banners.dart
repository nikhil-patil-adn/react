import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'product_detail.dart';

class ShowProductBanner extends StatefulWidget {
  ShowProductBanner({Key? key}) : super(key: key);

  @override
  _ShowProductBannerState createState() => _ShowProductBannerState();
}

class _ShowProductBannerState extends State<ShowProductBanner> {
  var products = [];
  void initState() {
    super.initState();
    fetchProduct();
  }

  fetchProduct() async {
    var url = "http://192.168.2.107:8000/api/products/fetch_products/";
    var response = await http.get(Uri.parse(url));
    products = json.decode(response.body);
  }

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
