import 'package:fellowfarmer/api/api.dart';
import 'package:fellowfarmer/pages/footer.dart';
import 'package:fellowfarmer/pages/myaccount_page.dart';
import 'package:fellowfarmer/widgets/customwidget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FeedbackList extends StatefulWidget {
  @override
  _FeedbackListState createState() => _FeedbackListState();
}

class _FeedbackListState extends State<FeedbackList> {
  var headerstyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );
  var datastyle = TextStyle(
    fontSize: 18,
  );
  String id = '0';
  int _initialval = 0;
  String feedbackdata = "";
  String displaydateformat = "MMMM d, y";
  String question = "";
  var feedbacklength = '0';
  String details = "";
  String status = "";
  int datalength = 0;
  List data = [];
  void initState() {
    super.initState();
    var obj = new Api();
    obj.getLoggedincustomerdata().then((value) {
      setState(() {
        id = value[0]['id'].toString();
      });

      obj.fetchfeedbackbycustomer(id).then((value) {
        if (value.length > 0) {
          setState(() {
            feedbacklength = value.length.toString();
            datalength = value.length - 1;
            data = value;
            feedbackdata = value[_initialval]['feedback_date'].toString();
            if (feedbackdata != "") {
              feedbackdata = DateFormat(displaydateformat)
                  .format(DateTime.parse(feedbackdata))
                  .toString();
            }
            question = value[_initialval]['type'].toString();
            details = value[_initialval]['details'].toString();
            status = value[_initialval]['status'].toString();
          });
        } else {
          _noresultfound();
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

  _nextfeedback() {
    setState(() {
      _initialval = _initialval + 1;
      feedbackdata = data[_initialval]['feedback_date'].toString();
      if (feedbackdata != "") {
        feedbackdata = DateFormat(displaydateformat)
            .format(DateTime.parse(feedbackdata))
            .toString();
      }
      question = data[_initialval]['type'].toString();
      details = data[_initialval]['details'].toString();
      status = data[_initialval]['status'].toString();
    });
  }

  _previousfeedback() {
    setState(() {
      _initialval = _initialval - 1;
      feedbackdata = data[_initialval]['feedback_date'].toString();
      if (feedbackdata != "") {
        feedbackdata = DateFormat(displaydateformat)
            .format(DateTime.parse(feedbackdata))
            .toString();
      }
      question = data[_initialval]['type'].toString();
      details = data[_initialval]['details'].toString();
      status = data[_initialval]['status'].toString();
    });
  }

  _feedbacklist() {
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
                    "Feedback date :",
                    style: headerstyle,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: Text(
                    feedbackdata,
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
                    "Question :",
                    style: headerstyle,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: Text(
                    question,
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
                    "Comments :",
                    style: headerstyle,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: Text(
                    details,
                    style: datastyle,
                  ),
                ),
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
                    status,
                    style: datastyle,
                  ),
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
          title: Text("My Feedback"),
          // leading: IconButton(
          //     onPressed: () {},
          //     icon: Image.asset(
          //       'assets/images/home_loader.gif',
          //       fit: BoxFit.fill,
          //     )),
        ),
        bottomNavigationBar: FooterPage(pageindex: 1),
        endDrawer: MyaccountPage(),
        body: feedbacklength != '0' ? _feedbacklist() : _noresultfound());
  }
}
