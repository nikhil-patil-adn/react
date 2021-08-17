import 'package:fellowfarmer/pages/otppop.dart';
import 'package:flutter/material.dart';

class ForgetPasswordStaff extends StatefulWidget {
  @override
  _ForgetPasswordStaffState createState() => _ForgetPasswordStaffState();
}

class _ForgetPasswordStaffState extends State<ForgetPasswordStaff> {
  final formKey = new GlobalKey<FormState>();
  final mobilecontroller = TextEditingController();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Forget password"),
      ),
      body: Container(
        padding: EdgeInsets.all(40.0),
        child: Column(
          children: [
            Container(
              child: Text("Enter mobile number to verify you account"),
            ),
            SizedBox(
              height: 20,
            ),
            Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    mobileField(),
                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            var custdata = [];
                            var custdatalist = {
                              'mobile': mobilecontroller.text,
                              'staff': '1'
                            };
                            custdata.add(custdatalist);
                            showDialog(
                                context: context,
                                builder: (context) => NewCustomDialog(
                                    title: "Enter OTP",
                                    description: "asdasdasd",
                                    buttontext: "change_password",
                                    custdata: custdata));
                          }
                        },
                        child: Text("Submit"))
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
