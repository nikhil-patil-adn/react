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
  String id = '0';
  void initState() {
    super.initState();
    var obj = new Api();
    obj.getLoggedincustomerdata().then((value) {
      setState(() {
        id = value[0]['id'].toString();
      });

      obj.fetchfeedbackbycustomer(id).then((value) {
        print(value);
      });
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
          padding: const EdgeInsets.only(top: 20),
          child: Column(
            children: [
              Container(
                // decoration: BoxDecoration(
                //   border: Border.all(),
                // ),
                child: Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                      // decoration: BoxDecoration(
                      //   border: Border.all(),
                      // ),
                      child: Text(
                        "Feedback date:",
                        style: headerstyle,
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                      // decoration: BoxDecoration(
                      //   border: Border.all(),
                      // ),
                      child: Text("Feedback date:"),
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
