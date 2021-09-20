import 'package:fellowfarmer/pages/footer.dart';
import 'package:fellowfarmer/pages/otppop.dart';
import 'package:fellowfarmer/widgets/customwidget.dart';
import 'package:flutter/material.dart';

class ForgetPassword extends StatefulWidget {
  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
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
        flexibleSpace: lineargradientbg(),
        title: Text("Forget password"),
      ),
      bottomNavigationBar: FooterPage(pageindex: 1),
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
                        style: ElevatedButton.styleFrom(
                          primary: const Color(0xffed1c22), // background
                          onPrimary: Colors.white, // foreground
                        ),
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            var custdata = [];
                            var custdatalist = {
                              'mobile': mobilecontroller.text,
                              'staff': 0
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
