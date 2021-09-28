import 'package:fellowfarmer/api/api.dart';
import 'package:fellowfarmer/pages/footer.dart';
import 'package:fellowfarmer/pages/myaccount_page.dart';
import 'package:fellowfarmer/widgets/customwidget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ViewDeliveryStatement extends StatefulWidget {
  final String subid;
  ViewDeliveryStatement({Key? key, required this.subid}) : super(key: key);
  @override
  _ViewDeliveryStatementState createState() => _ViewDeliveryStatementState();
}

class _ViewDeliveryStatementState extends State<ViewDeliveryStatement> {
  var headerstyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );
  var datastyle = TextStyle(
    fontSize: 18,
  );
  String id = '0';
  String price = "";
  String quantity = '0';
  String product = "";
  String frequencytype = "";
  int _initialval = 0;
  String startdate = "";
  String enddate = "";
  int datalength = 0;
  int subscriptionlength = 0;
  String displaydateformat = "MMMM d, y";
  List data = [];
  void initState() {
    super.initState();
    var obj = new Api();
    obj.getLoggedincustomerdata().then((value) {
      setState(() {
        id = value[0]['id'].toString();
      });

      obj.fetchsubscriptionbyid(widget.subid).then((value) {
        if (value.length > 0) {
          setState(() {
            subscriptionlength = value.length;
            datalength = value.length - 1;
            data = value;
            print(value);

            product = value[_initialval]['product']['name'].toString();
            startdate = value[_initialval]['subscription_start'].toString();
            if (startdate != "") {
              startdate = DateFormat(displaydateformat)
                  .format(DateTime.parse(startdate))
                  .toString();
            }
            enddate = value[_initialval]['subscription_end'].toString();
            if (enddate != "") {
              enddate = DateFormat(displaydateformat)
                  .format(DateTime.parse(enddate))
                  .toString();
            }

            price = value[_initialval]['price'].toString();
            quantity = value[_initialval]['quantity'].toString();
            frequencytype = value[_initialval]['frequency_type'].toString();
          });
        }
      });
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

  Widget _viewDeliveryStatement() {
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
                    "Start date :",
                    style: headerstyle,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: Text(
                    startdate,
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
                    "End date :",
                    style: headerstyle,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: Text(
                    enddate,
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
                    "Amount :",
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
                    price,
                    style: datastyle,
                  ),
                )
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
          title: Text("delivery statement "),
          // leading: IconButton(
          //     onPressed: () {},
          //     icon: Image.asset(
          //       'assets/images/home_loader.gif',
          //       fit: BoxFit.fill,
          //     )),
        ),
        endDrawer: MyaccountPage(),
        bottomNavigationBar: FooterPage(pageindex: 1),
        body: subscriptionlength > 0
            ? _viewDeliveryStatement()
            : _noresultfound());
  }
}
