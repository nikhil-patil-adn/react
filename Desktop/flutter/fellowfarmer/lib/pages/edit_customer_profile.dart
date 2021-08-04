import 'package:fellowfarmer/api/api.dart';
import 'package:fellowfarmer/main.dart';
import 'package:fellowfarmer/pages/myaccount_page.dart';
import 'package:flutter/material.dart';

class CustomerEditProfile extends StatefulWidget {
  @override
  _CustomerEditProfileState createState() => _CustomerEditProfileState();
}

class _CustomerEditProfileState extends State<CustomerEditProfile> {
  final formKey = new GlobalKey<FormState>();
  final usernamecontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  final namecontroller = TextEditingController();
  final emailcontroller = TextEditingController();
  final mobilecontroller = TextEditingController();
  final citycontroller = TextEditingController();
  final societycontroller = TextEditingController();
  final addresscontroller = TextEditingController();
  String socid = "";
  String cityid = "";
  int id = 0;

  void initState() {
    super.initState();
    var obj = new Api();
    obj.getLoggedincustomerdata().then((value) {
      setState(() {
        print(value);
        mobilecontroller.text = value[0]['mobile'];
        namecontroller.text = value[0]['name'];
        passwordcontroller.text =
            value[0]['password'] == null ? "" : value[0]['password'].toString();
        usernamecontroller.text =
            value[0]['username'] == null ? "" : value[0]['username'].toString();
        emailcontroller.text =
            value[0]['email'] == null ? "" : value[0]['email'].toString();
        addresscontroller.text =
            value[0]['address'] == null ? "" : value[0]['address'].toString();
        id = value[0]['id'];
      });

      socid = value[0]['society'].toString();
      obj.fetchSocietyid(socid).then((value) {
        setState(() {
          societycontroller.text = value;
        });
      });

      cityid = value[0]['city'].toString();
      obj.fetchCityid(cityid).then((value) {
        setState(() {
          citycontroller.text = value;
        });
      });
    });
  }

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
        'update': '1',
        'id': id.toString(),
      }
    ];
    obj.registercustomer(custdata).then((value) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Successfully update!!!'),
        ),
      );
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MyHomePage(title: 'FellowFarmer')));
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
          title: Text("Edit Profile"),
        ),
        endDrawer: MyaccountPage(),
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
