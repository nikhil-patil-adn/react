import 'dart:ui';

import 'package:fellowfarmer/api/api.dart';
import 'package:fellowfarmer/deliveryguy/staff_myaccount.dart';
import 'package:fellowfarmer/pages/footer.dart';
import 'package:fellowfarmer/widgets/customwidget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DeliveryPage extends StatefulWidget {
  @override
  _DeliveryPageState createState() => _DeliveryPageState();
}

class _DeliveryPageState extends State<DeliveryPage> {
  var headerstyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );
  var datastyle = TextStyle(
    fontSize: 18,
  );
  String id = '0';
  final searchcontroller = TextEditingController();
  String orderstatus = "";
  String product = "";
  String orderid = "";
  String paymentstatus = "";
  int _initialval = 0;
  String orderdate = "";
  String customername = "";
  String deliveryaddress = "";
  String sheduledeliverydate = "";
  int datalength = 0;
  int subscriptionlength = 0;
  String displaydateformat = "MMMM d, y";
  String quantity = "";
  final _formKey = GlobalKey<FormState>();
  List data = [];
  void initState() {
    super.initState();
    var obj = new Api();
    obj.getLoggedinstaffdata().then((val) {
      setState(() {
        id = val[0]['id'].toString();
      });

      obj.fetchstaffdelivery(id).then((value) {
        print(value);
        if (value.length > 0) {
          setState(() {
            subscriptionlength = value.length;
            datalength = value.length - 1;
            data = value;

            orderid = value[_initialval]['id'].toString();
            product = value[_initialval]['product'].toString();
            customername = value[_initialval]['customer']['name'].toString();
            deliveryaddress = value[_initialval]['delivery_address'].toString();
            orderdate = value[_initialval]['order_date'].toString();
            if (orderdate != "") {
              orderdate = DateFormat(displaydateformat)
                  .format(DateTime.parse(orderdate))
                  .toString();
            }
            sheduledeliverydate =
                value[_initialval]['schedule_delivery_date'].toString();
            if (sheduledeliverydate != "") {
              sheduledeliverydate = DateFormat(displaydateformat)
                  .format(DateTime.parse(sheduledeliverydate))
                  .toString();
            }

            orderstatus = value[_initialval]['order_status']
                .toString()
                .replaceAll("_", " ");
            paymentstatus = value[_initialval]['payment_status'].toString();
            quantity = value[_initialval]['quantity'].toString();
          });
        }
      });
    });
  }

  _nextfeedback() {
    setState(() {
      _initialval = _initialval + 1;
      orderid = data[_initialval]['id'].toString();
      deliveryaddress = data[_initialval]['delivery_address'].toString();
      product = data[_initialval]['product'].toString();
      customername = data[_initialval]['customer']['name'].toString();
      orderdate = data[_initialval]['order_date'].toString();
      orderdate =
          DateFormat(displaydateformat).format(DateTime.parse(orderdate));
      sheduledeliverydate =
          data[_initialval]['schedule_delivery_date'].toString();
      sheduledeliverydate = DateFormat(displaydateformat)
          .format(DateTime.parse(sheduledeliverydate))
          .toString();
      orderstatus =
          data[_initialval]['order_status'].toString().replaceAll("_", " ");
      paymentstatus = data[_initialval]['payment_status'].toString();
      quantity = data[_initialval]['quantity'].toString();
    });
  }

  _searchbycustomer(cust) {
    for (int i = 0; i < data.length; i++) {
      if (data[i]['customer']['name']
              .toString()
              .replaceAll(new RegExp(r"\s+"), "") ==
          cust.toString().replaceAll(new RegExp(r"\s+"), "")) {
        print("index");
        print(cust);
        setState(() {
          _initialval = i;
          orderid = data[_initialval]['id'].toString();
          deliveryaddress = data[_initialval]['delivery_address'].toString();
          product = data[_initialval]['product'].toString();
          orderdate = data[_initialval]['order_date'].toString();
          customername = data[_initialval]['customer']['name'].toString();
          orderdate =
              DateFormat(displaydateformat).format(DateTime.parse(orderdate));
          sheduledeliverydate =
              data[_initialval]['schedule_delivery_date'].toString();
          sheduledeliverydate = DateFormat(displaydateformat)
              .format(DateTime.parse(sheduledeliverydate))
              .toString();
          orderstatus =
              data[_initialval]['order_status'].toString().replaceAll("_", " ");
          paymentstatus = data[_initialval]['payment_status'].toString();
          quantity = data[_initialval]['quantity'].toString();
        });
      }
    }
  }

  _previousfeedback() {
    setState(() {
      _initialval = _initialval - 1;
      orderid = data[_initialval]['id'].toString();
      deliveryaddress = data[_initialval]['delivery_address'].toString();
      product = data[_initialval]['product'].toString();
      orderdate = data[_initialval]['order_date'].toString();
      customername = data[_initialval]['customer']['name'].toString();
      orderdate =
          DateFormat(displaydateformat).format(DateTime.parse(orderdate));
      sheduledeliverydate =
          data[_initialval]['schedule_delivery_date'].toString();
      sheduledeliverydate = DateFormat(displaydateformat)
          .format(DateTime.parse(sheduledeliverydate))
          .toString();
      orderstatus =
          data[_initialval]['order_status'].toString().replaceAll("_", " ");
      paymentstatus = data[_initialval]['payment_status'].toString();
      quantity = data[_initialval]['quantity'].toString();
    });
  }

  Widget _noresultfound() {
    return Container(
        padding: const EdgeInsets.all(40),
        child: Text(
          'No result found!!!!',
          style: TextStyle(fontSize: 20.0),
        ));
  }

  Widget _deliveryPage() {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.only(top: 20, left: 20),
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: searchcontroller,
                      decoration: InputDecoration(
                        labelText: "Search",
                        hintText: "customer name",
                        suffixIcon: IconButton(
                          onPressed: () {
                            _searchbycustomer(searchcontroller.text);
                          },
                          icon: Icon(Icons.search),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Container(
              child: Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: Text(
                      "Customer :",
                      style: headerstyle,
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: Text(
                      customername,
                      style: datastyle,
                    ),
                  )
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
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: Text(
                      "Delivery address :",
                      style: headerstyle,
                    ),
                  ),
                  SizedBox(
                    height: 100,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: Text(
                      deliveryaddress,
                      style: datastyle,
                    ),
                  )
                ],
              ),
            ),
            Container(
              child: Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: Text(
                      "Product :",
                      style: headerstyle,
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: Text(
                      product,
                      style: datastyle,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 30),
            Container(
              child: Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: Text(
                      "Delivery date :",
                      style: headerstyle,
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: Text(
                      sheduledeliverydate,
                      style: datastyle,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 30),
            Container(
              child: Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: Text(
                      "Quantity :",
                      style: headerstyle,
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: Text(
                      quantity,
                      style: datastyle,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 30),
            Container(
              child: Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: Text(
                      "Status :",
                      style: headerstyle,
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: Text(
                      orderstatus,
                      style: datastyle,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 30),
            Container(
              width: MediaQuery.of(context).size.width * 0.2,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: const Color(0xffed1c22), // background
                    onPrimary: Colors.white, // foreground
                  ),
                  onPressed: () {
                    var obj = new Api();
                    obj.updatedeliverystatus(orderid, 'delivered').then((res) {
                      setState(() {
                        orderstatus = res[0]['order_status']
                            .toString()
                            .replaceAll("_", " ");
                        data[_initialval]['order_status'] =
                            res[0]['order_status'];
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Status updated!!!')),
                      );
                    });
                  },
                  child: Text("Done")),
            ),
            SizedBox(height: 30),
            Container(
              padding: const EdgeInsets.all(30.0),
              child: Row(
                children: [
                  if (_initialval > 0)
                    Container(
                      width: MediaQuery.of(context).size.width * 0.3,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: const Color(0xffed1c22), // background
                            onPrimary: Colors.white, // foreground
                          ),
                          onPressed: () {
                            _previousfeedback();
                          },
                          child: Text("Previous")),
                    ),
                  SizedBox(width: 20),
                  if (_initialval < datalength)
                    Container(
                      width: MediaQuery.of(context).size.width * 0.3,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: const Color(0xffed1c22), // background
                            onPrimary: Colors.white, // foreground
                          ),
                          onPressed: () {
                            _nextfeedback();
                          },
                          child: Text("Next")),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          flexibleSpace: lineargradientbg(),
          title: Text("My Deliveries"),
          // leading: IconButton(
          //     onPressed: () {},
          //     icon: Image.asset(
          //       'assets/images/home_loader.gif',
          //       fit: BoxFit.fill,
          //     )),
        ),
        endDrawer: StaffMyaccount(),
        bottomNavigationBar: FooterPage(pageindex: 1),
        body: subscriptionlength > 0 ? _deliveryPage() : _noresultfound());
  }
}
