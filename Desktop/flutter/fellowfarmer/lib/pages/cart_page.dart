import 'package:fellowfarmer/api/api.dart';
import 'package:fellowfarmer/pages/myaccount_page.dart';
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
  var btntype = "";
  final locationController = TextEditingController();
  final mobileController = TextEditingController();
  final nameController = TextEditingController();
  final cityController = TextEditingController();
  late DateTime selecteddate = DateTime.now();
  String socid = "";
  String cityid = "";
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

  void initState() {
    super.initState();
    setState(() {
      qty = widget.quantity;
      btntype = widget.btntype;
    });
    print(btntype);
    var obj = new Api();

    obj.fetchProductandsetcode(widget.code, widget.quantity).then((value) {
      setState(() {
        name = value[0]['name'];
        image = value[0]['image'];
        desciption = value[0]['desciption'];
      });
    });

    obj.getLoggedincustomerdata().then((value) {
      setState(() {
        mobileController.text = value[0]['mobile'];
        nameController.text = value[0]['name'];
        addresstxt = value[0]['address'];
      });

      socid = value[0]['society'].toString();
      obj.fetchSocietyid(socid).then((value) {
        setState(() {
          locationController.text = value;
        });
      });

      cityid = value[0]['city'].toString();
      obj.fetchCityid(cityid).then((value) {
        setState(() {
          cityController.text = value;
        });
      });
    });
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
              maxLength: 10,
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
              controller: cityController,
              decoration: InputDecoration(
                  labelText: "City",
                  border: InputBorder.none,
                  labelStyle: TextStyle(fontSize: 20, color: Colors.black)),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please Enter City';
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
              controller: locationController,
              decoration: InputDecoration(
                  labelText: "Location",
                  border: InputBorder.none,
                  labelStyle: TextStyle(fontSize: 20, color: Colors.black)),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please Enter Location';
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
                decoration: const InputDecoration(
                    hintStyle: TextStyle(color: Colors.black45),
                    errorStyle: TextStyle(color: Colors.redAccent),
                    //border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.event_note),
                    labelText: "Select Date"),
                autovalidateMode: AutovalidateMode.always,
                validator: (e) =>
                    (e?.day ?? 0) == 1 ? 'Please not the first day' : null,
                onDateSelected: (DateTime value) {
                  print(value);
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
              onPressed: () {
                print("checkbtn");
                print(_pressval);
                print("date==");
                print(selecteddate);
                var obj = new Api();
                obj.fetchSociety(locationController.text).then((value) {
                  if (value == "" || value == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content:
                              Text('We are not deliver product this Society ')),
                    );
                  } else {
                    obj.checkregister(mobileController.text).then((cust) {
                      var custdata = [];
                      var custdatalist = {
                        'mobile': mobileController.text,
                        'name': nameController.text,
                        'city': cityController.text,
                        'location': locationController.text,
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
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ReviewPage(customerdata: custdata)));
                      }
                    });
                  }
                });
                if (_formKey.currentState!.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Processing Data')),
                  );
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
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        automaticallyImplyLeading: true,
        centerTitle: true,
        title: Text("Cart Page"),
      ),
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
                      child: Text(name, style: datatxtstyle),
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
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: Text(qty, style: datatxtstyle),
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
