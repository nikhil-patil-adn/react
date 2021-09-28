import 'package:fellowfarmer/api/api.dart';
import 'package:fellowfarmer/api/cityclass.dart';
import 'package:fellowfarmer/api/locationclass.dart';
import 'package:fellowfarmer/pages/footer.dart';
import 'package:fellowfarmer/pages/login_page.dart';
import 'package:fellowfarmer/pages/myaccount_page.dart';
import 'package:fellowfarmer/widgets/customwidget.dart';
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
  final pincodecontroller = TextEditingController();
  List<Location> _locationOptions = [];
  List<City> _cityOptions = [];

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
        'pincode': pincodecontroller.text,
      }
    ];
    print(custdata);
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

  void initState() {
    super.initState();
    var obj = new Api();
    obj.fetchAllSociety().then((val) {
      print(val);
      for (int i = 0; i < val.length; i++) {
        setState(() {
          _locationOptions.add(Location(name: val[i]['name']));
        });
      }
    });

    obj.fetchAllCity().then((val) {
      for (int i = 0; i < val.length; i++) {
        setState(() {
          _cityOptions.add(City(name: val[i]['name']));
        });
      }
    });
  }

  static String _displayStringForOptioncity(City option) => option.name;
  static String _displayStringForOption(Location option) => option.name;

  Widget cityField() {
    return Column(
      children: [
        SizedBox(
          height: 10.0,
        ),
        Container(
          width: MediaQuery.of(context).size.width * 1.0,
          // decoration: BoxDecoration(
          //   border: Border.all(),
          // ),
          child: Text(
            "City",
            textAlign: TextAlign.left,
          ),
        ),
        Autocomplete<City>(
          displayStringForOption: _displayStringForOptioncity,
          fieldViewBuilder: (BuildContext context, citycontroller,
              FocusNode fieldFocusNode, VoidCallback onFieldSubmitted) {
            //textEditingController.text = locationController.text.toString();

            return TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter city';
                }
                return null;
              },
              focusNode: fieldFocusNode,
              controller: citycontroller,
            );
          },
          optionsBuilder: (TextEditingValue textEditingValue) {
            if (textEditingValue.text.toString() == '') {
              return const Iterable<City>.empty();
            }
            return _cityOptions.where((City option) {
              return option
                  .toString()
                  .contains(textEditingValue.text.toLowerCase());
            });
          },
          onSelected: (City selection) {
            citycontroller.text = selection.toString();
          },
        ),
      ],
    );
  }

  Widget societyField() {
    return Column(
      children: [
        SizedBox(
          height: 10.0,
        ),
        Container(
          width: MediaQuery.of(context).size.width * 1.0,
          // decoration: BoxDecoration(
          //   border: Border.all(),
          // ),
          child: Text(
            "Society",
            textAlign: TextAlign.left,
          ),
        ),
        Autocomplete<Location>(
          displayStringForOption: _displayStringForOption,
          fieldViewBuilder: (BuildContext context, societycontroller,
              FocusNode fieldFocusNode, VoidCallback onFieldSubmitted) {
            //textEditingController.text = locationController.text.toString();

            return TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter Society';
                }
                return null;
              },
              focusNode: fieldFocusNode,
              controller: societycontroller,
            );
          },
          optionsBuilder: (TextEditingValue textEditingValue) {
            if (textEditingValue.text.toString() == '') {
              return const Iterable<Location>.empty();
            }
            return _locationOptions.where((Location option) {
              return option
                  .toString()
                  .contains(textEditingValue.text.toLowerCase());
            });
          },
          onSelected: (Location selection) {
            societycontroller.text = selection.toString();
          },
        ),
      ],
    );
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
        if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
          return 'Please a valid Email';
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
        if (value.length != 10) {
          return 'Please Enter 10 digit Mobile Number';
        }
        return null;
      },
      controller: mobilecontroller,
    );
  }

  // Widget cityField() {
  //   return TextFormField(
  //     autofocus: false,
  //     decoration: InputDecoration(labelText: "City"),
  //     validator: (value) {
  //       if (value == null || value.isEmpty) {
  //         return 'Please enter City';
  //       }
  //       return null;
  //     },
  //     controller: citycontroller,
  //   );
  // }

  // Widget societyField() {
  //   return TextFormField(
  //     autofocus: false,
  //     decoration: InputDecoration(labelText: "Society"),
  //     validator: (value) {
  //       if (value == null || value.isEmpty) {
  //         return 'Please enter Society';
  //       }
  //       return null;
  //     },
  //     controller: societycontroller,
  //   );
  // }

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

  Widget pincodeField() {
    return TextFormField(
      autofocus: false,
      decoration: InputDecoration(labelText: "Pincode"),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter pincode';
        }
        if (value.length != 6) {
          return 'Please Enter 6 digit pincode ';
        }
        return null;
      },
      controller: pincodecontroller,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: lineargradientbg(),
          title: Text("Register"),
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
                    pincodeField(),
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
