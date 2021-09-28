import 'package:fellowfarmer/api/api.dart';
import 'package:fellowfarmer/pages/footer.dart';
import 'package:fellowfarmer/pages/myaccount_page.dart';
import 'package:fellowfarmer/widgets/customwidget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyHolidayList extends StatefulWidget {
  @override
  _MyHolidayListState createState() => _MyHolidayListState();
}

class _MyHolidayListState extends State<MyHolidayList> {
  var headerstyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );
  var datastyle = TextStyle(
    fontSize: 18,
  );
  String id = '0';
  int _initialval = 0;
  String startdate = "";
  String enddate = "";
  int datalength = 0;
  int holidaylength = 0;
  String displaydateformat = "MMMM d, y";
  List data = [];
  void initState() {
    super.initState();
    var obj = new Api();
    obj.getLoggedincustomerdata().then((value) {
      setState(() {
        id = value[0]['id'].toString();
      });

      obj.fetchholidaybycustomer(id).then((value) {
        if (value.length > 0) {
          setState(() {
            holidaylength = value.length;
            datalength = value.length - 1;
            data = value;

            startdate = value[_initialval]['startdate'].toString();
            print(startdate);
            if (startdate != "") {
              startdate = DateFormat(displaydateformat)
                  .format(DateTime.parse(startdate))
                  .toString();
            }
            enddate = value[_initialval]['enddate'].toString();
            if (enddate != "") {
              enddate = DateFormat(displaydateformat)
                  .format(DateTime.parse(enddate))
                  .toString();
            }
          });
        }
      });
    });
  }

  _nextfeedback() {
    setState(() {
      _initialval = _initialval + 1;
      startdate = data[_initialval]['startdate'].toString();
      startdate =
          DateFormat(displaydateformat).format(DateTime.parse(startdate));
      enddate = data[_initialval]['enddate'].toString();
      enddate = DateFormat(displaydateformat)
          .format(DateTime.parse(enddate))
          .toString();
    });
  }

  _previousfeedback() {
    setState(() {
      _initialval = _initialval - 1;
      startdate = data[_initialval]['startdate'].toString();
      startdate =
          DateFormat(displaydateformat).format(DateTime.parse(startdate));
      enddate = data[_initialval]['enddate'].toString();
      enddate = DateFormat(displaydateformat)
          .format(DateTime.parse(enddate))
          .toString();
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

  Widget _holidaylist() {
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
          SizedBox(height: 30),
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
          title: Text("My plan"),
          // leading: IconButton(
          //     onPressed: () {},
          //     icon: Image.asset(
          //       'assets/images/home_loader.gif',
          //       fit: BoxFit.fill,
          //     )),
        ),
        endDrawer: MyaccountPage(),
        bottomNavigationBar: FooterPage(pageindex: 1),
        body: holidaylength > 0 ? _holidaylist() : _noresultfound());
  }
}
