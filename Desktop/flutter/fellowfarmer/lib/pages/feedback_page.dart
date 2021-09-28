import 'package:fellowfarmer/api/api.dart';
import 'package:fellowfarmer/main.dart';
import 'package:fellowfarmer/pages/footer.dart';
import 'package:fellowfarmer/pages/myaccount_page.dart';
import 'package:fellowfarmer/widgets/customwidget.dart';
import 'package:flutter/material.dart';

class AddFeedback extends StatefulWidget {
  @override
  _AddFeedbackState createState() => _AddFeedbackState();
}

class _AddFeedbackState extends State<AddFeedback> {
  final formKey = new GlobalKey<FormState>();
  final typecontroller = TextEditingController();
  final emailcontroller = TextEditingController();
  final mobilecontroller = TextEditingController();
  final commentcontroller = TextEditingController();
  String _myActivity = "";
  List _question = [];

  void initState() {
    super.initState();
    var obj = new Api();
    obj.getLoggedincustomerdata().then((value) {
      setState(() {
        mobilecontroller.text = value[0]['mobile'];
        emailcontroller.text =
            value[0]['email'] == null ? "" : value[0]['email'].toString();
      });

      obj.getfeedbackquestion().then((val) {
        print(val);
        if (val.length > 0) {
          for (int i = 0; i < val.length; i++) {
            _question.add(val[i]['question']);
          }
          setState(() {
            _question = _question;
          });
        }
      });
    });
  }

  doregister() {
    var obj = new Api();
    List custdata = [
      {
        'email': emailcontroller.text,
        'mobile': mobilecontroller.text,
        'type': _myActivity,
        'comment': commentcontroller.text,
      }
    ];
    obj.insertfeedback(custdata).then((value) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Successfully insert !!!'),
        ),
      );
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MyHomePage(title: 'FellowFarmer')));
    });
  }

  Widget emailField() {
    return TextFormField(
      autofocus: false,
      decoration: InputDecoration(labelText: "Email"),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter Email';
        }
        return null;
      },
      controller: emailcontroller,
    );
  }

  Widget mobileField() {
    return TextFormField(
      autofocus: false,
      decoration: InputDecoration(labelText: "Mobile"),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter Mobile';
        }
        return null;
      },
      controller: mobilecontroller,
    );
  }

  Widget commentField() {
    return TextFormField(
      autofocus: false,
      decoration: InputDecoration(labelText: "Comment"),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter comment';
        }
        return null;
      },
      controller: commentcontroller,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: lineargradientbg(),
          title: Text("Add Feedback"),
        ),
        bottomNavigationBar: FooterPage(pageindex: 1),
        endDrawer: MyaccountPage(),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(40.0),
            child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DropdownButtonFormField(
                      hint: Text("Select Question"),
                      isExpanded: true,
                      validator: (value) =>
                          value == null ? 'Plase Select question' : null,
                      items: _question.map((valueItem) {
                        return DropdownMenuItem(
                            child: Text(valueItem), value: valueItem);
                      }).toList(),
                      onChanged: (newvalue) {
                        setState(() {
                          _myActivity = newvalue.toString();
                        });
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    emailField(),
                    SizedBox(
                      height: 20,
                    ),
                    mobileField(),
                    SizedBox(
                      height: 20,
                    ),
                    commentField(),
                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              side: BorderSide(color: Color(0xFFed1c22))),
                          primary: const Color(0xFF4a1821), // background
                          onPrimary: Colors.white, // foreground
                        ),
                        onPressed: () {
                          print(_myActivity);
                          if (formKey.currentState!.validate()) {
                            doregister();
                          }
                        },
                        child: Text("Submit"))
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
