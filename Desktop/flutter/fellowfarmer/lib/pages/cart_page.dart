import 'package:fellowfarmer/api/api.dart';
import 'package:fellowfarmer/api/cityclass.dart';
import 'package:fellowfarmer/api/locationclass.dart';
import 'package:fellowfarmer/pages/footer.dart';
import 'package:fellowfarmer/pages/myaccount_page.dart';
import 'package:fellowfarmer/widgets/customwidget.dart';
import 'package:flutter/material.dart';
import 'package:date_field/date_field.dart';
import 'review_page.dart';
import 'otppop.dart';

class CartPage extends StatefulWidget {
  final int code;
  final String btntype;
  final String quantity;
  CartPage(
      {Key? key,
      required this.code,
      required this.btntype,
      required this.quantity})
      : super(key: key);
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);
  var keytxtstyle = TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
  var datatxtstyle = TextStyle(fontSize: 20, fontWeight: FontWeight.normal);
  final _formKey = GlobalKey<FormState>();
  var name = "";
  var image = "";
  var desciption = "";
  var qty = "";
  var unit = "";
  var btntype = "";
  final locationController = TextEditingController();
  final mobileController = TextEditingController();
  final nameController = TextEditingController();
  final cityController = TextEditingController();
  final pincodeController = TextEditingController();
  final emailController = TextEditingController();
  final _soctextEditingController = TextEditingController();
  final _citytextEditingController = TextEditingController();
  late DateTime selecteddate = DateTime.now();
  String socid = "";
  String cityid = "";
  String price = '00.00';
  bool _dailyPressed = false;
  bool _alernatePressed = false;
  ButtonStyle _alternatebtnstyle = ButtonStyle(
    backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
  );
  ButtonStyle _dailybtnstyle = ButtonStyle(
    backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
  );
  final ButtonStyle _selectedbtnstyle = ButtonStyle(
    backgroundColor: MaterialStateProperty.all<Color>(Colors.blueAccent),
  );
  String _pressval = "";
  String addresstxt = "";
  List<Location> _locationOptions = [];
  List<City> _cityOptions = [];
  String intiallocationval = "";
  bool islogin = false;

  void initState() {
    super.initState();
    setState(() {
      qty = widget.quantity;
      btntype = widget.btntype;
    });
    var obj = new Api();

    obj.fetchProductandsetcode(widget.code, widget.quantity).then((value) {
      setState(() {
        name = value[0]['name'];
        image = value[0]['image'];
        desciption = value[0]['desciption'];
        price = value[0]['price'];
        unit = value[0]['unit'];
      });
    });

    obj.getLoggedincustomerdata().then((value) {
      if (value.length > 0) {
        setState(() {
          islogin = true;
          mobileController.text = value[0]['mobile'];
          emailController.text = value[0]['email'].toString();
          nameController.text = value[0]['name'];
          addresstxt = value[0]['address'];
          pincodeController.text = value[0]['pincode'].toString();
        });

        socid = value[0]['society'].toString();
        obj.fetchSocietyid(socid).then((value) {
          setState(() {
            locationController.text = value.toString();
            intiallocationval = value.toString();
            _soctextEditingController.text = value.toString();
            print(_soctextEditingController.text);
          });
        });

        cityid = value[0]['city'].toString();
        obj.fetchCityid(cityid).then((value) {
          setState(() {
            cityController.text = value.toString();
            _citytextEditingController.text = value.toString();
          });
        });
      }
    });

    obj.fetchAllSociety().then((val) {
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

  // static const List<Location> _locationOptions =  newlocation;
  static String _displayStringForOptioncity(City option) => option.name;
  static String _displayStringForOption(Location option) => option.name;

  Widget cityfield() {
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
          fieldViewBuilder: (context, _citytextEditingController, focusNode,
              onFieldSubmitted) {
            //textEditingController.text = cityController.text.toString();

            return TextFormField(
              decoration: InputDecoration(hintText: cityController.text),
              focusNode: focusNode,
              controller: _citytextEditingController,
            );
          },
          optionsBuilder: (TextEditingValue textEditingValue) {
            cityController.text = textEditingValue.text.toString();
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
            cityController.text = selection.toString();
          },
        ),
      ],
    );
  }

  Widget locationfield() {
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
          fieldViewBuilder: (BuildContext context, _soctextEditingController,
              FocusNode fieldFocusNode, VoidCallback onFieldSubmitted) {
            //textEditingController.text = locationController.text.toString();

            return TextFormField(
              decoration: InputDecoration(hintText: locationController.text),
              focusNode: fieldFocusNode,
              controller: _soctextEditingController,
            );
          },
          optionsBuilder: (TextEditingValue textEditingValue) {
            locationController.text = textEditingValue.text.toString();
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
            locationController.text = selection.toString();
          },
        ),
      ],
    );
  }

  Widget formCart() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 1.0,
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.blue, width: 2)),
            ),
            child: TextFormField(
              controller: nameController,
              //maxLength: 10,
              decoration: InputDecoration(
                  labelText: "Coustomer Name",
                  border: InputBorder.none,
                  labelStyle: TextStyle(fontSize: 20, color: Colors.black)),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please Enter name';
                }
                return null;
              },
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 1.0,
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.blue, width: 2)),
            ),
            child: TextFormField(
              controller: mobileController,
              decoration: InputDecoration(
                  labelText: "Mobile Number",
                  border: InputBorder.none,
                  labelStyle: TextStyle(fontSize: 20, color: Colors.black)),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please Enter Mobile Number';
                }
                if (value.length != 10) {
                  return 'Please Enter 10 digit Mobile Number';
                }
                return null;
              },
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 1.0,
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.blue, width: 2)),
            ),
            child: TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                  labelText: "Email id",
                  border: InputBorder.none,
                  labelStyle: TextStyle(fontSize: 20, color: Colors.black)),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter email';
                }
                if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                    .hasMatch(value)) {
                  return 'Please a valid Email';
                }
                return null;
              },
            ),
          ),
          if (_cityOptions.length > 0)
            Container(
              width: MediaQuery.of(context).size.width * 1.0,
              decoration: BoxDecoration(
                border:
                    Border(bottom: BorderSide(color: Colors.blue, width: 2)),
              ),
              child: cityfield(),
              // child: TextFormField(
              //   controller: cityController,
              //   decoration: InputDecoration(
              //       labelText: "City",
              //       border: InputBorder.none,
              //       labelStyle: TextStyle(fontSize: 20, color: Colors.black)),
              //   validator: (value) {
              //     if (value == null || value.isEmpty) {
              //       return 'Please Enter City';
              //     }
              //     return null;
              //   },
              // ),
            ),
          if (_locationOptions.length > 0)
            Container(
              width: MediaQuery.of(context).size.width * 1.0,
              decoration: BoxDecoration(
                border:
                    Border(bottom: BorderSide(color: Colors.blue, width: 2)),
              ),
              child: locationfield(),
              // child: TextFormField(
              //   controller: locationController,
              //   decoration: InputDecoration(
              //       labelText: "Location",
              //       border: InputBorder.none,
              //       labelStyle: TextStyle(fontSize: 20, color: Colors.black)),
              //   validator: (value) {
              //     if (value == null || value.isEmpty) {
              //       return 'Please Enter Location';
              //     }
              //     return null;
              //   },
              // ),
            ),
          Container(
            width: MediaQuery.of(context).size.width * 1.0,
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.blue, width: 2)),
            ),
            child: TextFormField(
              controller: pincodeController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  labelText: "Pincode",
                  border: InputBorder.none,
                  labelStyle: TextStyle(fontSize: 20, color: Colors.black)),
              validator: (value) {
                if (value!.length == 0 || value.isEmpty) {
                  return 'Please Enter Pincode';
                }
                return null;
              },
            ),
          ),
          if (btntype == "subscription")
            Container(
              width: MediaQuery.of(context).size.width * 1.0,
              decoration: BoxDecoration(
                border:
                    Border(bottom: BorderSide(color: Colors.blue, width: 2)),
              ),
              child: DateTimeFormField(
                mode: DateTimeFieldPickerMode.date,
                decoration: const InputDecoration(
                    hintStyle: TextStyle(color: Colors.black45),
                    errorStyle: TextStyle(color: Colors.redAccent),
                    //border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.event_note),
                    labelText: "Subscription Start Date"),
                autovalidateMode: AutovalidateMode.always,
                // validator: (e) =>
                //   (e?.day ?? 0) == 1 ? 'Please not the first day' : null,
                onDateSelected: (DateTime value) {
                  setState(() {
                    selecteddate = value;
                  });
                },
              ),
            ),
          SizedBox(
            height: 20.0,
          ),
          if (btntype == "subscription")
            Container(
              padding: const EdgeInsets.only(left: 80),
              child: Row(
                children: [
                  ElevatedButton(
                    style: _dailyPressed ? _selectedbtnstyle : _dailybtnstyle,
                    child: new Text(
                      'Daily',
                      style: TextStyle(color: Colors.black),
                    ),
                    onPressed: () => {
                      setState(() {
                        _dailyPressed = !_dailyPressed;
                        _alernatePressed = false;
                        _pressval = 'daily';
                      })
                    },
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  ElevatedButton(
                    style: _alernatePressed
                        ? _selectedbtnstyle
                        : _alternatebtnstyle,
                    child: new Text('Alternate',
                        style: TextStyle(color: Colors.black)),
                    onPressed: () => {
                      setState(() {
                        _alernatePressed = !_alernatePressed;
                        _dailyPressed = false;
                        _pressval = 'alternate';
                      })
                    },
                  )
                ],
              ),
            ),
          Divider(
            color: Colors.black,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
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
                if (_formKey.currentState!.validate()) {
                  var obj = new Api();
                  if (locationController.text != "")
                    obj.fetchSociety(locationController.text).then((value) {
                      if (value == "" || value == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text(
                                  'We currently do not serve your society. Someone from our customer support team will get in touch with you soon')),
                        );
                      } else {
                        if (mobileController.text != "")
                          obj.checkregister(mobileController.text).then((cust) {
                            var custdata = [];
                            var custdatalist = {
                              'mobile': mobileController.text,
                              'email': emailController.text,
                              'name': nameController.text,
                              'city': cityController.text,
                              'location': locationController.text,
                              'pincode': pincodeController.text,
                              'quantity': qty,
                              'address': addresstxt,
                              'btntype': btntype,
                              'subscriptiontype': _pressval,
                              'selecteddate': selecteddate
                            };

                            custdata.add(custdatalist);
                            if (cust == null) {
                              showDialog(
                                  context: context,
                                  builder: (context) => NewCustomDialog(
                                      title: "Enter OTP",
                                      description: "asdasdasd",
                                      buttontext: "buttontext",
                                      custdata: custdata));
                            } else {
                              if (islogin == false) {
                                showDialog(
                                    context: context,
                                    builder: (context) => NewCustomDialog(
                                        title: "Enter OTP",
                                        description: "asdasdasd",
                                        buttontext: "buttontext",
                                        custdata: custdata));
                              } else {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ReviewPage(
                                            customerdata: custdata)));
                              }
                            }
                          });
                      }
                    });

                  ImageDialog();

                  // ScaffoldMessenger.of(context).showSnackBar(
                  //   const SnackBar(content: Text('Processing Data')),
                  // );
                }
              },
              child: const Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: lineargradientbg(),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        automaticallyImplyLeading: true,
        centerTitle: true,
        title: Text("Cart Page"),
      ),
      bottomNavigationBar: FooterPage(pageindex: 1),
      endDrawer: MyaccountPage(),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(top: 10.0),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: Text("Product Name:", style: keytxtstyle),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: Text(capitalize(name), style: datatxtstyle),
                    )
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: Text("Quantity:", style: keytxtstyle),
                    ),
                    Container(
                      //width: MediaQuery.of(context).size.width * 0.1,
                      child: Text(qty, style: datatxtstyle),
                    ),
                    Container(
                      // width: MediaQuery.of(context).size.width * 0.3,
                      child: Text(unit, style: datatxtstyle),
                    )
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: Text("Price:", style: keytxtstyle),
                    ),
                    Image.asset(
                      'assets/images/rupee.png',
                      fit: BoxFit.fill,
                      width: 22,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: Text(price, style: datatxtstyle),
                    )
                  ],
                ),
              ),
              Divider(color: Colors.black),
              Container(
                padding: const EdgeInsets.all(20),
                child: formCart(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
