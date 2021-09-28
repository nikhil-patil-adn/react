import 'package:fellowfarmer/api/api.dart';
import 'package:fellowfarmer/pages/footer.dart';
import 'package:fellowfarmer/pages/myaccount_page.dart';
import 'package:fellowfarmer/widgets/customwidget.dart';
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
  String subid = '0';
  String subscriptiontype = "";
  String product = "";
  String frequencytype = "";
  int _initialval = 0;
  String startdate = "";
  String enddate = "";
  int datalength = 0;
  int subscriptionlength = 0;
  String substatus = "";
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

            product = _capitalstring(
                value[_initialval]['product']['name'].toString());
            startdate = value[_initialval]['subscription_start'].toString();
            subid = value[_initialval]['id'].toString();
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

            subscriptiontype = _capitalstring(
                value[_initialval]['subscription_type'].toString());
            frequencytype =
                _capitalstring(value[_initialval]['frequency_type'].toString());
            substatus = _capitalstring(value[_initialval]['status'].toString());
          });
        } else {
          _noresultfound();
        }
      });
    });
  }

  _nextfeedback() {
    setState(() {
      _initialval = _initialval + 1;
      product = _capitalstring(data[_initialval]['product']['name'].toString());
      subid = data[_initialval]['id'].toString();
      startdate = data[_initialval]['subscription_start'].toString();
      startdate =
          DateFormat(displaydateformat).format(DateTime.parse(startdate));
      enddate = data[_initialval]['subscription_end'].toString();
      enddate = DateFormat(displaydateformat)
          .format(DateTime.parse(enddate))
          .toString();
      subscriptiontype =
          _capitalstring(data[_initialval]['subscription_type'].toString());
      frequencytype =
          _capitalstring(data[_initialval]['frequency_type'].toString());
      substatus = _capitalstring(data[_initialval]['status'].toString());
    });
  }

  _previousfeedback() {
    setState(() {
      _initialval = _initialval - 1;
      product = _capitalstring(data[_initialval]['product']['name'].toString());
      subid = data[_initialval]['id'].toString();
      startdate = data[_initialval]['subscription_start'].toString();
      startdate =
          DateFormat(displaydateformat).format(DateTime.parse(startdate));
      enddate = data[_initialval]['subscription_end'].toString();
      enddate = DateFormat(displaydateformat)
          .format(DateTime.parse(enddate))
          .toString();
      subscriptiontype =
          _capitalstring(data[_initialval]['subscription_type'].toString());
      frequencytype =
          _capitalstring(data[_initialval]['frequency_type'].toString());
      substatus = _capitalstring(data[_initialval]['status'].toString());
    });
  }

  stopsubscription() {
    var obj = Api();
    obj.stopResumeSubscription(subid, 'stop').then((val) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => SubscriptionList()));
    });
  }

  resumesubscription() {
    var obj = Api();
    obj.stopResumeSubscription(subid, 'resume').then((val) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => SubscriptionList()));
    });
  }

  _capitalstring(data) {
    return data[0].toUpperCase() + data.substring(1);
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
                    frequencytype,
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
                    "status:",
                    style: headerstyle,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: Text(
                    substatus,
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
                if (substatus.toLowerCase() == 'active')
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
                          stopsubscription();
                        },
                        child: Text("Stop")),
                  ),
                SizedBox(width: 20),
                if (substatus.toLowerCase() == 'stop')
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
                          resumesubscription();
                        },
                        child: Text("Resume")),
                  ),
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
        body: subscriptionlength > 0 ? _subscriptionlist() : ImageDialog());
  }
}
