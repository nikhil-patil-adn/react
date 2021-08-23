import 'package:fellowfarmer/api/api.dart';
import 'package:fellowfarmer/pages/myaccount_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RegularOrderList extends StatefulWidget {
  @override
  _RegularOrderListState createState() => _RegularOrderListState();
}

class _RegularOrderListState extends State<RegularOrderList> {
  var headerstyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );
  var datastyle = TextStyle(
    fontSize: 18,
  );
  String id = '0';
  String orderstatus = "";
  String product = "";
  String paymentstatus = "";
  int _initialval = 0;
  String orderdate = "";
  String sheduledeliverydate = "";
  int datalength = 0;
  int subscriptionlength = 0;
  String displaydateformat = "MMMM d, y";
  String orderamount = "";
  List data = [];
  void initState() {
    super.initState();
    var obj = new Api();
    obj.getLoggedincustomerdata().then((value) {
      setState(() {
        id = value[0]['id'].toString();
      });

      obj.fetchbuynowbycustomer(id).then((value) {
        if (value.length > 0) {
          setState(() {
            subscriptionlength = value.length;
            datalength = value.length - 1;
            data = value;

            product = value[_initialval]['product'].toString();
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

            orderstatus = value[_initialval]['order_status'].toString();
            paymentstatus = value[_initialval]['payment_status'].toString();
            orderamount = value[_initialval]['order_amount'].toString();
          });
        }
      });
    });
  }

  _nextfeedback() {
    setState(() {
      _initialval = _initialval + 1;
      product = data[_initialval]['product'].toString();
      orderdate = data[_initialval]['order_date'].toString();
      orderdate =
          DateFormat(displaydateformat).format(DateTime.parse(orderdate));
      sheduledeliverydate =
          data[_initialval]['schedule_delivery_date'].toString();
      sheduledeliverydate = DateFormat(displaydateformat)
          .format(DateTime.parse(sheduledeliverydate))
          .toString();
      orderstatus = data[_initialval]['order_status'].toString();
      paymentstatus = data[_initialval]['payment_status'].toString();
      orderamount = data[_initialval]['order_amount'].toString();
    });
  }

  _previousfeedback() {
    setState(() {
      _initialval = _initialval - 1;
      product = data[_initialval]['product'].toString();
      orderdate = data[_initialval]['order_date'].toString();
      orderdate =
          DateFormat(displaydateformat).format(DateTime.parse(orderdate));
      sheduledeliverydate =
          data[_initialval]['schedule_delivery_date'].toString();
      sheduledeliverydate = DateFormat(displaydateformat)
          .format(DateTime.parse(sheduledeliverydate))
          .toString();
      orderstatus = data[_initialval]['order_status'].toString();
      paymentstatus = data[_initialval]['payment_status'].toString();
      orderamount = data[_initialval]['order_amount'].toString();
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

  Widget _regularOrderList() {
    return Container(
      padding: const EdgeInsets.only(top: 20, left: 20),
      child: Column(
        children: [
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
                    "Order date :",
                    style: headerstyle,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: Text(
                    orderdate,
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
                    "Order status :",
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
            child: Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: Text(
                    "Payment Status :",
                    style: headerstyle,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: Text(
                    paymentstatus,
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
                    "Order amount :",
                    style: headerstyle,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: Text(
                    orderamount,
                    style: datastyle,
                  ),
                )
              ],
            ),
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("My regular orders"),
          // leading: IconButton(
          //     onPressed: () {},
          //     icon: Image.asset(
          //       'assets/images/home_loader.gif',
          //       fit: BoxFit.fill,
          //     )),
        ),
        endDrawer: MyaccountPage(),
        body: subscriptionlength > 0 ? _regularOrderList() : _noresultfound());
  }
}