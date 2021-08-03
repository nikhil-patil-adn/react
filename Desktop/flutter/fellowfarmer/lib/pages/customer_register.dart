import 'package:fellowfarmer/api/api.dart';
import 'package:fellowfarmer/pages/login_page.dart';
import 'package:flutter/material.dart';

class CustomerRegister extends StatefulWidget {
  @override
  _CustomerRegisterState createState() => _CustomerRegisterState();
}

class _CustomerRegisterState extends State<CustomerRegister> {
  final formKey = new GlobalKey<FormState>();
  final usernamecontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  final namecontroller = TextEditingController();
  final emailcontroller = TextEditingController();
  final mobilecontroller = TextEditingController();
  final citycontroller = TextEditingController();
  final societycontroller = TextEditingController();
  final addresscontroller = TextEditingController();

  doregister() {
    var obj = new Api();
    List custdata = [
      {
        'username': usernamecontroller.text,
        'password': passwordcontroller.text,
        'name': namecontroller.text,
        'email': emailcontroller.text,
        'mobile': mobilecontroller.text,
        'city': citycontroller.text,
        'society': societycontroller.text,
        'address': addresscontroller.text,
      }
    ];
    obj.registercustomer(custdata).then((value) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Successfully register!!!'),
        ),
      );
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
    });
  }

  Widget usernameField() {
    return TextFormField(
      autofocus: false,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter username';
        }
        return null;
      },
      controller: usernamecontroller,
      decoration: InputDecoration(labelText: "Username"),
    );
  }

  Widget passwordField() {
    return TextFormField(
      autofocus: false,
      obscureText: true,
      decoration: InputDecoration(labelText: "Password"),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter password';
        }
        return null;
      },
      controller: passwordcontroller,
    );
  }

  Widget nameField() {
    return TextFormField(
      autofocus: false,
      decoration: InputDecoration(labelText: "Name"),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter name';
        }
        return null;
      },
      controller: namecontroller,
    );
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

  Widget cityField() {
    return TextFormField(
      autofocus: false,
      decoration: InputDecoration(labelText: "City"),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter City';
        }
        return null;
      },
      controller: citycontroller,
    );
  }

  Widget societyField() {
    return TextFormField(
      autofocus: false,
      decoration: InputDecoration(labelText: "Society"),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter Society';
        }
        return null;
      },
      controller: societycontroller,
    );
  }

  Widget addressField() {
    return TextFormField(
      autofocus: false,
      decoration: InputDecoration(labelText: "Address"),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter Address';
        }
        return null;
      },
      controller: addresscontroller,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Register"),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(40.0),
            child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    usernameField(),
                    SizedBox(
                      height: 20,
                    ),
                    passwordField(),
                    SizedBox(
                      height: 20,
                    ),
                    nameField(),
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
                    cityField(),
                    SizedBox(
                      height: 20,
                    ),
                    societyField(),
                    SizedBox(
                      height: 20,
                    ),
                    addressField(),
                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                        onPressed: () {
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
