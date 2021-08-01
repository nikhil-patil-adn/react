import 'package:fellowfarmer/api/api.dart';
import 'package:flutter/material.dart';

import 'order_page.dart';

class ReviewPage extends StatefulWidget {
  final List customerdata;
  ReviewPage({required this.customerdata});
  @override
  _ReviewPageState createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  final _couponformKey = GlobalKey<FormState>();
  final coupontextcontroller = TextEditingController();
  var focusNode = FocusNode();
  final List customerdata = [];
  List product = [];
  var name = "";
  var image = "";
  var desciption = "";
  var qty = "";
  int discountval = 0;
  String finalamount = "0";
  double prize = double.parse('100');

  void initState() {
    print("instde order");
    super.initState();
    focusNode.addListener(() {
      print(focusNode.hasFocus);
    });
    qty = widget.customerdata[0]['quantity'];

    var obj = new Api();
    obj.insertcustomer(widget.customerdata);
    obj.fetchProduct().then((value) {
      setState(() {
        name = value[0]['name'];
        image = value[0]['image'];
        desciption = value[0]['desciption'];
        finalamount = prize.toString();
      });
    });
  }

  _checkcoupon() {
    print(coupontextcontroller.text);
    var obj = new Api();
    obj.checkouponavailable(coupontextcontroller.text).then((value) {
      if (value.length > 0) {
        discountval = value[0]['dis_count_per'];
        double decimalval = double.parse('124') / value[0]['dis_count_per'];
        double sum = prize - decimalval;
        setState(() {
          finalamount = sum.toString();
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Coupon Accepted!!!')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Coupon not accepted!!!')),
        );
      }
    });
  }

  Widget _productdetail() {
    const headerstyle = TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
    const conatentstyle = TextStyle(fontSize: 18);
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, left: 10.0),
      child: Container(
        child: Column(
          children: [
            Container(
              child: Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: Text("Product Name:", style: headerstyle),
                  ),
                  Container(
                      child: Text(
                    name,
                    style: conatentstyle,
                  )),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              child: Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: Text("Quantity:", style: headerstyle),
                  ),
                  Container(
                      child: Text(
                    qty,
                    style: conatentstyle,
                  )),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              child: Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: Text("Prize:", style: headerstyle),
                  ),
                  Container(
                      child: Text(
                    finalamount,
                    style: conatentstyle,
                  )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _couponform() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
        // decoration: BoxDecoration(border: Border.all()),
        child: Form(
            key: _couponformKey,
            child: Column(
              children: [
                Container(
                  child: TextFormField(
                    controller: coupontextcontroller,
                    decoration: InputDecoration(
                        suffixIcon: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: InkWell(
                            onTap: () => _checkcoupon(),
                            child: Image(
                              image: AssetImage("assets/images/add_to_fav.jpg"),
                              width: 2,
                              height: 2,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        border: UnderlineInputBorder(),
                        labelText: "Add Coupon"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter coupon code';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      // Validate returns true if the form is valid, or false otherwise.
                      if (_couponformKey.currentState!.validate()) {
                        List custdata = widget.customerdata;
                        custdata[0]['prize'] = finalamount;
                        //custdata.add({'prize': finalamount});
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  OrderPage(customerdata: custdata),
                            ));

                        // ScaffoldMessenger.of(context).showSnackBar(
                        // const SnackBar(content: Text('Processing Data')),
                        // );
                      }
                    },
                    child: const Text('Confirm Order'),
                  ),
                ),
              ],
            )),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Review Order"),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _productdetail(),
              _couponform(),
            ],
          ),
        ),
      ),
    );
  }
}
