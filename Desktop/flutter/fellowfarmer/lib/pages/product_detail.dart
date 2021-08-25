import 'dart:ui';
import 'package:fellowfarmer/api/api.dart';
import 'package:fellowfarmer/pages/footer.dart';
import 'package:fellowfarmer/pages/myaccount_page.dart';
import 'package:readmore/readmore.dart';
import 'package:flutter/material.dart';

import 'cart_page.dart';

class ProductDetail extends StatefulWidget {
  final int code;
  final String quantity;
  ProductDetail({Key? key, required this.code, required this.quantity})
      : super(key: key);

  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  var product = [];
  var name = "";
  var image = "";
  var desciption = "";
  bool issubscribed = true;
  TextEditingController qtyController = TextEditingController();

  void initState() {
    super.initState();
    fetchProduct(widget.code);
    qtyController.text = widget.quantity;
  }

  fetchProduct(int code) {
    var obj = new Api();
    obj.fetchProductdetail(code).then((val) {
      setState(() {
        name = val[0]['name'];
        image = val[0]['image'];
        desciption = val[0]['desciption'];
        issubscribed = val[0]['issubscribed'];
      });
    });
  }

  Widget buildText(String text) {
    final styleButton =
        TextStyle(fontSize: 20, color: Colors.red, fontWeight: FontWeight.bold);

    return ReadMoreText(
      text,
      trimMode: TrimMode.Length,
      trimLength: 50,
      trimCollapsedText: 'Read more',
      trimExpandedText: 'Read less',
      style: TextStyle(
        fontSize: 20,
      ),
      lessStyle: styleButton,
      moreStyle: styleButton,
    );
  }

  Widget qtyTextField() {
    return Container(
      width: MediaQuery.of(context).size.width * 1.0,
      child: Center(
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 70),
              child: SizedBox(
                height: 40,
                width: 80,
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      int qty = int.parse(qtyController.text);
                      if (qty > 0) {
                        qty--;
                      }

                      qtyController.text = qty.toString();
                    });
                  },
                  child: Text("-",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.black,
                      )),
                ),
              ),
            ),
            SizedBox(
              height: 40,
              width: 80,
              child: TextField(
                controller: qtyController,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: 35.0),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0))),
              ),
            ),
            SizedBox(
              child: TextButton(
                onPressed: () {
                  setState(() {
                    int qty = int.parse(qtyController.text);
                    qty++;
                    qtyController.text = qty.toString();
                  });
                },
                child: Text("+",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.black,
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Product Detail"),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
          automaticallyImplyLeading: true,
          centerTitle: true,
        ),
        bottomNavigationBar: FooterPage(pageindex: 1),
        endDrawer: MyaccountPage(),
        body: Builder(builder: (BuildContext context) {
          return SingleChildScrollView(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 70.0, top: 30.0),
                    height: 300.0,
                    //decoration: BoxDecoration(border: Border.all()),
                    width: 150.0,
                    child: Column(
                      children: [
                        Container(
                            // decoration: BoxDecoration(
                            //   boxShadow: [
                            //     BoxShadow(
                            //         blurRadius: 30,
                            //         color: Colors.grey,
                            //         offset: Offset(1, 1))
                            //   ],
                            // ),
                            child: Image.network(
                          image,
                          fit: BoxFit.fill,
                        )),
                        // Container(
                        //   width: 200,
                        //   child: Row(
                        //     children: [
                        //       Container(
                        //         margin: EdgeInsets.only(right: 40, top: 30),
                        //         width: 40,
                        //         height: 40,
                        //         child: InkWell(
                        //           onTap: () {},
                        //           child: Image.asset(
                        //             'assets/images/add_to_fav.jpg',
                        //             fit: BoxFit.fill,
                        //           ),
                        //         ),
                        //       ),
                        //       Container(
                        //         margin: EdgeInsets.only(right: 10, top: 30),
                        //         width: 40,
                        //         height: 40,
                        //         child: InkWell(
                        //           onTap: () {},
                        //           child: Image.asset(
                        //             'assets/images/add_to_fav.jpg',
                        //             fit: BoxFit.fill,
                        //           ),
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                  SingleChildScrollView(
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 50.0, top: 10.0),
                      height: 300.0,
                      width: MediaQuery.of(context).size.width * 0.5,
                      //decoration: BoxDecoration(border: Border.all()),
                      child: Column(
                        children: [
                          Text(
                            name,
                            style: TextStyle(fontSize: 30.0),
                          ),
                          Expanded(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: buildText(desciption),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Center(
                child: Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 1.0,
                      height: 50,
                      // decoration: BoxDecoration(
                      //   border: Border.all(),
                      // ),
                      child: Center(child: qtyTextField()),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Container(
                height: 50,
                // decoration: BoxDecoration(
                //   border: Border.all(),
                // ),
                child: Row(
                  children: [
                    SizedBox(
                      width: 60,
                    ),
                    if (issubscribed)
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: const Color(0xffed1c22), // background
                            onPrimary: Colors.white, // foreground
                          ),
                          onPressed: () {
                            if (int.parse(qtyController.text) > 0) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CartPage(
                                          code: widget.code,
                                          btntype: 'buynow',
                                          quantity: qtyController.text)));
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Please enter quantity')),
                              );
                            }
                          },
                          child: Text("Buy Now")),
                    SizedBox(
                      width: 80,
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: const Color(0xffed1c22), // background
                          onPrimary: Colors.white, // foreground
                        ),
                        onPressed: () {
                          if (int.parse(qtyController.text) > 0) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CartPage(
                                        code: widget.code,
                                        btntype: 'subscription',
                                        quantity: qtyController.text)));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Please enter quantity')),
                            );
                          }
                        },
                        child: Text("SubScription")),
                  ],
                ),
              ),
            ]),
          );
        }));
  }
}
