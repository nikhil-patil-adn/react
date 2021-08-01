import 'package:fellowfarmer/api/api.dart';
import 'package:flutter/material.dart';

class OrderPage extends StatefulWidget {
  final List customerdata;
  OrderPage({required this.customerdata});
  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  final List customerdata = [];
  List product = [];
  var name = "";
  var image = "";
  var desciption = "";
  var qty = "";
  void initState() {
    print("instde order");
    super.initState();
    var obj = new Api();
    print(widget.customerdata);
    obj.insertorder(widget.customerdata).then((value) {
      print(value);
    });
    obj.fetchProduct().then((value) {
      setState(() {
        name = value[0]['name'];
        image = value[0]['image'];
        desciption = value[0]['desciption'];
      });
    });
  }

  Widget _statusbox() {
    const statusheaderstyle =
        TextStyle(fontSize: 13.0, fontWeight: FontWeight.bold);
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Row(
        children: [
          Container(
            // decoration: BoxDecoration(
            //   border: Border.all(),
            // ),
            width: MediaQuery.of(context).size.width * 0.27,
            child: Text(
              "Order Statue : ",
              style: statusheaderstyle,
            ),
          ),
          Container(
            // decoration: BoxDecoration(
            //   border: Border.all(),
            // ),
            width: MediaQuery.of(context).size.width * 0.2,
            child: Text("Confirmed"),
          ),
          SizedBox(
            width: 10,
          ),
          Container(
            // decoration: BoxDecoration(
            //   border: Border.all(),
            // ),
            width: MediaQuery.of(context).size.width * 0.3,
            child: Text(
              "Payment Statue :",
              style: statusheaderstyle,
            ),
          ),
          Container(
            // decoration: BoxDecoration(
            //   border: Border.all(),
            // ),
            width: MediaQuery.of(context).size.width * 0.2,
            child: Text("Not Done"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Order Confirmation"),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [_statusbox(), Text(name), Text(image), Text(desciption)],
          ),
        ),
      ),
    );
  }
}
