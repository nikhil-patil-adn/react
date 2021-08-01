import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:date_field/date_field.dart';
import 'review_page.dart';
import 'otppop.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  final _formKey = GlobalKey<FormState>();
  var host = "http://192.168.2.107:8000";
  var tokennew = "8334d1d63c97cc583ac50fc034afaf5f57833251";
  List product = [];
  var name = "";
  var image = "";
  var desciption = "";
  var qty = "";

  final locationController = TextEditingController();
  final mobileController = TextEditingController();
  final nameController = TextEditingController();
  final cityController = TextEditingController();

  void initState() {
    super.initState();
    setState(() {
      qty = widget.quantity;
    });

    fetchProduct(widget.code);
  }

  fetchSociety() async {
    String token = tokennew;
    String basicAuth = 'Token ' + token;
    var url = host + "/api/location/getsociety/" + locationController.text;
    var response = await http.get(Uri.parse(url),
        headers: <String, String>{'authorization': basicAuth});
    var society = json.decode(response.body);

    if (society.length > 0) {
      return society[0]['name'];
    } else {
      return null;
    }
  }

  checkregister() async {
    String token = tokennew;
    String basicAuth = 'Token ' + token;
    var url = host + "/api/customers/checkregister/" + mobileController.text;
    var response = await http.get(Uri.parse(url),
        headers: <String, String>{'authorization': basicAuth});
    var customer = json.decode(response.body);

    if (customer.length > 0) {
      return customer[0]['name'];
    } else {
      return null;
    }
  }

  fetchProduct(int code) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('selectedproductcode', widget.code);
    prefs.setString('selectedqty', widget.quantity);

    String token = tokennew;
    String basicAuth = 'Token ' + token;
    var url = host + "/api/products/details/" + code.toString();
    var response = await http.get(Uri.parse(url),
        headers: <String, String>{'authorization': basicAuth});
    product = json.decode(response.body);

    setState(() {
      name = product[0]['name'];
      image = product[0]['image'];
      desciption = product[0]['desciption'];
    });
  }

  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);

  Widget formCart() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 1,
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
            width: MediaQuery.of(context).size.width * 1,
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
            width: MediaQuery.of(context).size.width * 1,
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
            width: MediaQuery.of(context).size.width * 1,
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
          Container(
            width: MediaQuery.of(context).size.width * 1,
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.blue, width: 2)),
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
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () {
                fetchSociety().then((value) {
                  if (value == "" || value == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content:
                              Text('We are not deliver product this Society ')),
                    );
                  } else {
                    checkregister().then((cust) {
                      var custdata = [];
                      var custdatalist = {
                        'mobile': mobileController.text,
                        'name': nameController.text,
                        'city': cityController.text,
                        'location': locationController.text,
                        'quantity': qty
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
    var keytxtstyle = TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
    var datatxtstyle = TextStyle(fontSize: 20, fontWeight: FontWeight.normal);
    return Scaffold(
      appBar: AppBar(
        title: Text("Cart Page"),
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          SizedBox(
            height: 20,
          ),
          Container(
            // decoration: BoxDecoration(
            //   border: Border.all(),
            // ),
            child: Row(
              children: [
                Text(capitalize("Product Name"), style: keytxtstyle),
                Text(
                  " :",
                  style: keytxtstyle,
                  textAlign: TextAlign.right,
                ),
                Container(
                  // decoration: BoxDecoration(
                  //   border: Border.all(),
                  // ),
                  width: MediaQuery.of(context).size.width * 0.5,
                  alignment: Alignment.centerRight,
                  child: Text(
                    capitalize(name),
                    style: datatxtstyle,
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            // decoration: BoxDecoration(
            //   border: Border.all(),
            // ),
            child: Row(
              children: [
                Text(capitalize("Quantiy"), style: keytxtstyle),
                Text(
                  " :",
                  style: keytxtstyle,
                  textAlign: TextAlign.right,
                ),
                Container(
                  // decoration: BoxDecoration(
                  //   border: Border.all(),
                  // ),
                  width: MediaQuery.of(context).size.width * 0.6,
                  alignment: Alignment.centerRight,
                  child: Text(
                    qty,
                    style: datatxtstyle,
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Container(
              width: MediaQuery.of(context).size.width * 1.0,
              // decoration: BoxDecoration(
              //   border: Border.all(),
              // ),
              child: formCart(),
            ),
          )
        ],
      ),
    );
  }
}
