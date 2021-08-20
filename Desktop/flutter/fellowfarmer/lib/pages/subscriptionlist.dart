import 'package:fellowfarmer/api/api.dart';
import 'package:fellowfarmer/pages/footer.dart';
import 'package:fellowfarmer/pages/myaccount_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SubscriptionList extends StatefulWidget {
  @override
  _SubscriptionListState createState() => _SubscriptionListState();
}

class _SubscriptionListState extends State<SubscriptionList> {
  var headerstyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );
  var datastyle = TextStyle(
    fontSize: 18,
  );
  String id = '0';
  String subscriptiontype = "";
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

      obj.fetchsubscriptionbycustomer(id).then((value) {
        if (value.length > 0) {
          setState(() {
            subscriptionlength = value.length;
            datalength = value.length - 1;
            data = value;

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

            subscriptiontype =
                value[_initialval]['subscription_type'].toString();
            frequencytype = value[_initialval]['frequency_type'].toString();
          });
        }
      });
    });
  }

  _nextfeedback() {
    setState(() {
      _initialval = _initialval + 1;
      product = data[_initialval]['product']['name'].toString();
      startdate = data[_initialval]['subscription_start'].toString();
      startdate =
          DateFormat(displaydateformat).format(DateTime.parse(startdate));
      enddate = data[_initialval]['subscription_end'].toString();
      enddate = DateFormat(displaydateformat)
          .format(DateTime.parse(enddate))
          .toString();
      subscriptiontype = data[_initialval]['subscription_type'].toString();
      frequencytype = data[_initialval]['frequency_type'].toString();
    });
  }

  _previousfeedback() {
    setState(() {
      _initialval = _initialval - 1;
      product = data[_initialval]['product']['name'].toString();
      startdate = data[_initialval]['subscription_start'].toString();
      startdate =
          DateFormat(displaydateformat).format(DateTime.parse(startdate));
      enddate = data[_initialval]['subscription_end'].toString();
      enddate = DateFormat(displaydateformat)
          .format(DateTime.parse(enddate))
          .toString();
      subscriptiontype = data[_initialval]['subscription_type'].toString();
      frequencytype = data[_initialval]['frequency_type'].toString();
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

  Widget _subscriptionlist() {
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
                    "Frequency Type :",
                    style: headerstyle,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: Text(
                    subscriptiontype,
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
                    "Subscription Type :",
                    style: headerstyle,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: Text(
                    frequencytype,
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
          title: Text("My Subscriptions"),
          // leading: IconButton(
          //     onPressed: () {},
          //     icon: Image.asset(
          //       'assets/images/home_loader.gif',
          //       fit: BoxFit.fill,
          //     )),
        ),
        endDrawer: MyaccountPage(),
        bottomNavigationBar: FooterPage(pageindex: 1),
        body: subscriptionlength > 0 ? _subscriptionlist() : _noresultfound());
  }
}
