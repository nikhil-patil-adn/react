import 'package:fellowfarmer/api/api.dart';
import 'package:fellowfarmer/pages/footer.dart';
import 'package:fellowfarmer/pages/myaccount_page.dart';
import 'package:fellowfarmer/widgets/customwidget.dart';
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
  var orderstatus = "";
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

            product = _capitalstring(value[_initialval]['product'].toString());
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

            orderstatus = properorderstatusstring(
                value[_initialval]['order_status'].toString());

            paymentstatus =
                _capitalstring(value[_initialval]['payment_status'].toString());
            orderamount = value[_initialval]['order_amount'].toString();
          });
        } else {
          _noresultfound();
        }
      });
    });
  }

  properorderstatusstring(data) {
    data = _capitalstring(data);
    data = data.replaceAll('_', ' ');
    return data;
  }

  _capitalstring(data) {
    return data[0].toUpperCase() + data.substring(1);
  }

  _nextfeedback() {
    setState(() {
      _initialval = _initialval + 1;
      product = _capitalstring(data[_initialval]['product'].toString());
      orderdate = data[_initialval]['order_date'].toString();
      orderdate =
          DateFormat(displaydateformat).format(DateTime.parse(orderdate));
      sheduledeliverydate =
          data[_initialval]['schedule_delivery_date'].toString();
      sheduledeliverydate = DateFormat(displaydateformat)
          .format(DateTime.parse(sheduledeliverydate))
          .toString();
      orderstatus =
          properorderstatusstring(data[_initialval]['order_status'].toString());
      paymentstatus =
          _capitalstring(data[_initialval]['payment_status'].toString());
      orderamount = data[_initialval]['order_amount'].toString();
    });
  }

  _previousfeedback() {
    setState(() {
      _initialval = _initialval - 1;
      product = _capitalstring(data[_initialval]['product'].toString());
      orderdate = data[_initialval]['order_date'].toString();
      orderdate =
          DateFormat(displaydateformat).format(DateTime.parse(orderdate));
      sheduledeliverydate =
          data[_initialval]['schedule_delivery_date'].toString();
      sheduledeliverydate = DateFormat(displaydateformat)
          .format(DateTime.parse(sheduledeliverydate))
          .toString();
      orderstatus =
          properorderstatusstring(data[_initialval]['order_status'].toString());
      paymentstatus =
          _capitalstring(data[_initialval]['payment_status'].toString());
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
                Image.asset(
                  'assets/images/rupee.png',
                  fit: BoxFit.fill,
                  width: 20,
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
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              side: BorderSide(color: Color(0xFFed1c22))),
                          // primary: Colors.transparent,
                          primary: const Color(0xFF4a1821), // background
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
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              side: BorderSide(color: Color(0xFFed1c22))),
                          // primary: Colors.transparent,
                          primary: const Color(0xFF4a1821), // background
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          flexibleSpace: lineargradientbg(),
          title: Text("My regular orders"),
          // leading: IconButton(
          //     onPressed: () {},
          //     icon: Image.asset(
          //       'assets/images/home_loader.gif',
          //       fit: BoxFit.fill,
          //     )),
        ),
        bottomNavigationBar: FooterPage(pageindex: 1),
        endDrawer: MyaccountPage(),
        body: subscriptionlength > 0 ? _regularOrderList() : ImageDialog());
  }
}
