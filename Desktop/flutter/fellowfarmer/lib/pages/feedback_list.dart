import 'package:fellowfarmer/api/api.dart';
import 'package:fellowfarmer/pages/myaccount_page.dart';
import 'package:flutter/material.dart';

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
  String question = "";
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
        setState(() {
          datalength = value.length - 1;
          data = value;
          feedbackdata = value[_initialval]['feedback_date'].toString();
          question = value[_initialval]['type'].toString();
          details = value[_initialval]['details'].toString();
          status = value[_initialval]['status'].toString();
        });
      });
    });
  }

  _nextfeedback() {
    setState(() {
      _initialval = _initialval + 1;
      feedbackdata = data[_initialval]['feedback_date'].toString();
      question = data[_initialval]['type'].toString();
      details = data[_initialval]['details'].toString();
      status = data[_initialval]['status'].toString();
    });
  }

  _previousfeedback() {
    setState(() {
      _initialval = _initialval - 1;
      feedbackdata = data[_initialval]['feedback_date'].toString();
      question = data[_initialval]['type'].toString();
      details = data[_initialval]['details'].toString();
      status = data[_initialval]['status'].toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("My Feedback"),
          // leading: IconButton(
          //     onPressed: () {},
          //     icon: Image.asset(
          //       'assets/images/home_loader.gif',
          //       fit: BoxFit.fill,
          //     )),
        ),
        endDrawer: MyaccountPage(),
        body: Container(
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
        ));
  }
}
