import 'package:fellowfarmer/api/api.dart';
import 'package:fellowfarmer/pages/footer.dart';
import 'package:fellowfarmer/pages/login_page.dart';
import 'package:fellowfarmer/pages/myaccount_page.dart';
import 'package:fellowfarmer/pages/myholidaylist_page.dart';
import 'package:fellowfarmer/widgets/customwidget.dart';
import 'package:flutter/material.dart';
import 'package:date_field/date_field.dart';

class MyHoliday extends StatefulWidget {
  @override
  _MyHolidayState createState() => _MyHolidayState();
}

class _MyHolidayState extends State<MyHoliday> {
  final formKey = new GlobalKey<FormState>();
  late DateTime startdate = DateTime.now();
  late DateTime enddate = DateTime.now();
  int id = 0;

  doregister() {
    var obj = new Api();

    obj.getLoggedincustomerdata().then((value) {
      if (value.length > 0) {
        setState(() {
          id = value[0]['id'];
        });
        print(startdate);
        List holidaydata = [
          {
            'custid': id,
            'startdate': startdate,
            'enddate': enddate,
          }
        ];
        print(holidaydata);
        obj.insertholiday(holidaydata).then((value) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Successfully inserted!!!'),
            ),
          );
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => MyHolidayList()));
        });
      }
    });
  }

  Widget _startdate() {
    return DateTimeFormField(
      mode: DateTimeFieldPickerMode.date,
      decoration: const InputDecoration(
          hintStyle: TextStyle(color: Colors.black45),
          errorStyle: TextStyle(color: Colors.redAccent),
          //border: OutlineInputBorder(),
          suffixIcon: Icon(Icons.event_note),
          labelText: "Start Date"),
      autovalidateMode: AutovalidateMode.always,
      validator: (val) {
        if (val != null) {
          return null;
        } else {
          return 'Start date Field is Empty';
        }
      },
      onDateSelected: (DateTime value) {
        setState(() {
          startdate = value;
        });
      },
    );
  }

  Widget _enddate() {
    return DateTimeFormField(
      mode: DateTimeFieldPickerMode.date,
      decoration: const InputDecoration(
          hintStyle: TextStyle(color: Colors.black45),
          errorStyle: TextStyle(color: Colors.redAccent),
          //border: OutlineInputBorder(),
          suffixIcon: Icon(Icons.event_note),
          labelText: "End Date"),
      autovalidateMode: AutovalidateMode.always,
      validator: (val) {
        if (val != null) {
          return null;
        } else {
          return 'End date Field is Empty';
        }
      },
      onDateSelected: (DateTime value) {
        setState(() {
          enddate = value;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        //backgroundColor: Colors.cyan.shade50,
        appBar: AppBar(
          flexibleSpace: lineargradientbg(),
          title: Text("My plan"),
        ),
        endDrawer: MyaccountPage(),
        bottomNavigationBar: FooterPage(pageindex: 1),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(40.0),
            child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _startdate(),
                    SizedBox(
                      height: 20.0,
                    ),
                    _enddate(),
                    SizedBox(
                      height: 20.0,
                    ),
                    ElevatedButton(
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
                          if (formKey.currentState!.validate()) {
                            print(startdate);

                            doregister();
                          }
                        },
                        child: Text("Submit")),
                    ElevatedButton(
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
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MyHolidayList()));
                        },
                        child: Text("My Plan"))
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
