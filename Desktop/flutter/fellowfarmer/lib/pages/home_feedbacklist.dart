import 'package:carousel_slider/carousel_slider.dart';
import 'package:fellowfarmer/api/api.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'product_detail.dart';

class HomeFeedback extends StatefulWidget {
  HomeFeedback({Key? key}) : super(key: key);

  @override
  _HomeFeedbackState createState() => _HomeFeedbackState();
}

class _HomeFeedbackState extends State<HomeFeedback> {
  var feedbacks = [];
  String displaydateformat = "MMMM d, y";
  void initState() {
    super.initState();
    var obj = new Api();

    obj.fetchallfeedback().then((value) {
      setState(() {
        print(value.length);
        feedbacks = value;

        // datalength = value.length - 1;
        // data = value;
        // feedbackdata = value[_initialval]['feedback_date'].toString();
        // if (feedbackdata != "") {
        //   feedbackdata = DateFormat(displaydateformat)
        //       .format(DateTime.parse(feedbackdata))
        //       .toString();
        // }
        // question = value[_initialval]['type'].toString();
        // details = value[_initialval]['details'].toString();
        // status = value[_initialval]['status'].toString();
      });
    });
  }

  //fetchProductList() async {}

  @override
  Widget build(BuildContext context) {
    // return Expanded(
    //   child: ListView.builder(
    //       itemCount: feedbacks.length,
    //       itemBuilder: (BuildContext context, int index) {
    //         return ListTile(
    //           title: Text(DateFormat(displaydateformat)
    //               .format(DateTime.parse(feedbacks[index]['feedback_date']))
    //               .toString()),
    //           subtitle: Text(feedbacks[index]['details']),
    //         );
    //       }),
    // );
    return CarouselSlider(
      options: CarouselOptions(
        height: 200.0,
        enlargeCenterPage: true,
      ),
      items: feedbacks.map((i) {
        return Builder(
          builder: (BuildContext context) {
            return SingleChildScrollView(
              child: Container(
                  width: MediaQuery.of(context).size.width * 1.0,
                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                  //decoration: BoxDecoration(color: Colors.amber),
                  child: ListTile(
                    title: Text(DateFormat(displaydateformat)
                        .format(DateTime.parse(i['feedback_date']))
                        .toString()),
                    subtitle: Text(i['details']),
                  )),
            );
          },
        );
      }).toList(),
    );
  }
}
