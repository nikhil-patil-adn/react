import 'package:fellowfarmer/api/api.dart';
import 'package:fellowfarmer/pages/login_page.dart';
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
      var obj = new Api();
      obj
          .updatepasswordcustomer(
              widget.customerdata[0]['mobile'], confirmpasswordcontroller.text)
          .then((value) {
        if (value.length > 0) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Password updated !!!'),
            ),
          );
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => LoginPage()));
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Change password"),
      ),
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