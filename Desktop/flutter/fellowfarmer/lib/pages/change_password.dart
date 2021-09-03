import 'package:fellowfarmer/api/api.dart';
import 'package:fellowfarmer/deliveryguy/loginpage.dart';
import 'package:fellowfarmer/pages/footer.dart';
import 'package:fellowfarmer/pages/login_page.dart';
import 'package:fellowfarmer/widgets/customwidget.dart';
import 'package:flutter/material.dart';

class ChangePassword extends StatefulWidget {
  final List customerdata;
  ChangePassword({required this.customerdata});

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final formKey = new GlobalKey<FormState>();
  final newpasswordcontroller = TextEditingController();
  final confirmpasswordcontroller = TextEditingController();
  bool _obsecurenew = true;
  bool _obsecureconfirm = true;

  Widget newpasswordField() {
    return TextFormField(
      autofocus: false,
      obscureText: _obsecurenew,
      decoration: InputDecoration(
        labelText: "New password",
        suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                _obsecurenew = !_obsecurenew;
              });
            },
            icon: Icon(
              _obsecurenew ? Icons.visibility_off : Icons.visibility,
            )),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter password';
        }
        return null;
      },
      controller: newpasswordcontroller,
    );
  }

  Widget confirmpasswordField() {
    return TextFormField(
      autofocus: false,
      obscureText: _obsecureconfirm,
      decoration: InputDecoration(
        labelText: "Confirm password",
        suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                _obsecureconfirm = !_obsecureconfirm;
              });
            },
            icon: Icon(
              _obsecureconfirm ? Icons.visibility_off : Icons.visibility,
            )),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter confirm pasword';
        }
        return null;
      },
      controller: confirmpasswordcontroller,
    );
  }

  updatepassword() {
    if (newpasswordcontroller.text != confirmpasswordcontroller.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('confirm password not match !!!'),
        ),
      );
      confirmpasswordcontroller.text = "";
    } else {
      print("staffff");
      print(widget.customerdata[0]['staff']);
      var obj = new Api();
      obj
          .updatepasswordcustomer(widget.customerdata[0]['mobile'],
              confirmpasswordcontroller.text, widget.customerdata[0]['staff'])
          .then((value) {
        print(value);
        if (value.length > 0) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Password updated !!!'),
            ),
          );

          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => widget.customerdata[0]['staff'] == '1'
                      ? DeliveryGuyLogin()
                      : LoginPage()));
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: lineargradientbg(),
        title: Text("Change password"),
      ),
      bottomNavigationBar: FooterPage(pageindex: 1),
      body: Container(
        padding: EdgeInsets.all(40.0),
        child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                newpasswordField(),
                SizedBox(
                  height: 20,
                ),
                confirmpasswordField(),
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
                        updatepassword();
                      }
                    },
                    child: Text("Submit"))
              ],
            )),
      ),
    );
  }
}
