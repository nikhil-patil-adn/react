import 'package:fellowfarmer/api/api.dart';
import 'package:fellowfarmer/pages/myaccount_page.dart';
import 'package:flutter/material.dart';

class OrderPage extends StatefulWidget {
  final List customerdata;
  OrderPage({required this.customerdata});
  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  final List customerdata = [];

  Color statusheadercolor = const Color(0xffeeeeee);
  final successcolor = const Color(0xFF013220);
  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);
  var productheaderstyle = TextStyle(
    fontSize: 18,
  );
  List product = [];
  var order_status = "";
  var payment_status = "";
  var order_amount = "";
  var productname = "";
  var image = "";
  var desciption = "";
  var qty = "";
  var custname = "";
  var custaddress = "";
  var custmobile = "";
  void initState() {
    print("instde order");
    super.initState();
    var obj = new Api();
    print(widget.customerdata);
    obj.insertorder(widget.customerdata).then((value) {
      setState(() {
        order_status = capitalize(value['order_status'].replaceAll('_', " "));
        payment_status =
            capitalize(value['payment_status'].replaceAll('_', " "));
        productname = capitalize(value['product']);
        qty = value['quantity'].toString();
        order_amount = value['order_amount'];
        custname = widget.customerdata[0]['name'];
        custaddress = widget.customerdata[0]['location'] +
            ", " +
            widget.customerdata[0]['city'];
        custmobile = widget.customerdata[0]['mobile'];
      });
      print(value);
    });

    // obj.fetchProduct().then((value) {
    //   setState(() {
    //     name = value[0]['name'];
    //     image = value[0]['image'];
    //     desciption = value[0]['desciption'];
    //   });
    //  });
  }

  Widget _statusbox() {
    const statusheaderstyle =
        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold);
    return Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: Container(
          width: MediaQuery.of(context).size.width * 1.0,
          decoration: BoxDecoration(
            border: Border.all(),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: Text("Order Status :", style: statusheaderstyle),
                    ),
                    Container(
                      child: Text(order_status,
                          style: TextStyle(
                            fontSize: 20.0,
                            color: successcolor,
                            fontWeight: FontWeight.bold,
                          )),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: Text("Payment Status :", style: statusheaderstyle),
                    ),
                    Container(
                      child: Text(payment_status,
                          style: TextStyle(
                            fontSize: 20.0,
                            color: successcolor,
                            fontWeight: FontWeight.bold,
                          )),
                    )
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  Widget _productbox() {
    return Container(
        width: MediaQuery.of(context).size.width * 1.0,
        decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: Text(
                      "Product Name :",
                      style: productheaderstyle,
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: Text(
                      productname,
                      style: productheaderstyle,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: Text(
                      "Quantity :",
                      style: productheaderstyle,
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: Text(
                      qty,
                      style: productheaderstyle,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: Text(
                      "Prize :",
                      style: productheaderstyle,
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: Text(
                      order_amount,
                      style: productheaderstyle,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }

  Widget _customerbox() {
    return Container(
        width: MediaQuery.of(context).size.width * 1.0,
        decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: Text(
                      "Customer Name :",
                      style: productheaderstyle,
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: Text(
                      custname,
                      style: productheaderstyle,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: Text(
                      "Address :",
                      style: productheaderstyle,
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: Text(
                      custaddress,
                      style: productheaderstyle,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: Text(
                      "Mobile  :",
                      style: productheaderstyle,
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: Text(
                      custmobile,
                      style: productheaderstyle,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Order Confirmation"),
      ),
      endDrawer: MyaccountPage(),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _statusbox(),
              SizedBox(height: 10),
              _productbox(),
              SizedBox(height: 10),
              _customerbox(),
            ],
          ),
        ),
      ),
    );
  }
}
