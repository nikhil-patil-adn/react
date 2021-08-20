import 'package:fellowfarmer/api/api.dart';
import 'package:fellowfarmer/pages/footer.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:fellowfarmer/pages/myaccount_page.dart';
import 'order_page.dart';

class ReviewPage extends StatefulWidget {
  final List customerdata;
  ReviewPage({required this.customerdata});
  @override
  _ReviewPageState createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  List custdata = [];
  late Razorpay _razorpay;
  final _couponformKey = GlobalKey<FormState>();
  final coupontextcontroller = TextEditingController();
  final addresscontroller = TextEditingController();
  final prepaidamtController = TextEditingController();
  String payamount = "00.00";
  var focusNode = FocusNode();
  final List customerdata = [];
  List product = [];
  var name = "";
  var image = "";
  var desciption = "";
  var qty = "";
  int discountval = 0;
  String finalamount = "00.00";
  var btntype = "";
  bool _showprepaid = false;
  bool _prepaidPressed = false;
  bool _postpaidPressed = false;
  String transactionid = "";
  String _pressval = "";
  ButtonStyle _postpaidbtnstyle = ButtonStyle(
    backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
  );
  ButtonStyle _prepaidbtnstyle = ButtonStyle(
    backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
  );
  final ButtonStyle _selectedbtnstyle = ButtonStyle(
    backgroundColor: MaterialStateProperty.all<Color>(Colors.blueAccent),
  );

  List prepaidoption = [];
  String _prepaidvalue = '1';
  String id = '0';
  List freq = [];

  void initState() {
    super.initState();

    setState(() {
      custdata = widget.customerdata;
    });

    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    focusNode.addListener(() {
      print(focusNode.hasFocus);
    });
    addresscontroller.text = widget.customerdata[0]['address'];
    qty = widget.customerdata[0]['quantity'];
    btntype = widget.customerdata[0]['btntype'];

    var obj = new Api();
    obj.insertcustomer(widget.customerdata);
    obj.fetchProduct().then((value) {
      setState(() {
        name = value[0]['name'];
        id = value[0]['id'].toString();
        image = value[0]['image'];
        desciption = value[0]['desciption'];
        finalamount = value[0]['price'].toString();
        payamount = finalamount;
      });

      obj.frequencyprepaidbyproduct(id).then((val) {
        if (val.length > 0) {
          setState(() {
            prepaidoption = val;
          });
        }
      });
    });
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Do something when payment succeeds
    print(response);

    Fluttertoast.showToast(
        msg: "SUCCESS: " + response.paymentId!, toastLength: Toast.LENGTH_LONG);
    setState(() {
      transactionid = response.paymentId.toString();
    });
    custdata[0]['transactionid'] = transactionid;
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OrderPage(customerdata: custdata),
        ));

    //var responsedata = jsonDecode(response)['events'];
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
    Fluttertoast.showToast(
        msg: "ERROR: " + response.code.toString() + " - " + response.message!,
        toastLength: Toast.LENGTH_SHORT);
    setState(() {
      transactionid = "";
    });
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet was selected
    print(response);
    Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET: " + response.walletName!,
        toastLength: Toast.LENGTH_SHORT);
    setState(() {
      transactionid = "";
    });
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  openCheckout() {
    var options = {
      'key': 'rzp_test_gqIXbVvdcyfrlx',
      'amount': num.parse(payamount) * 100,
      'name': 'Acme Corp.',
      'description': 'Fine T-Shirt',
      'prefill': {'contact': '8888888888', 'email': 'test@razorpay.com'},
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: e');
    }
  }

  _checkcoupon() {
    var obj = new Api();
    if (coupontextcontroller.text == "") {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter coupon!!!')),
      );
    } else {
      obj.checkouponavailable(coupontextcontroller.text).then((value) {
        if (value.length > 0) {
          discountval = value[0]['dis_count_per'];
          double decimalval =
              double.parse(finalamount) / value[0]['dis_count_per'];
          double sum = double.parse(finalamount) - decimalval;
          setState(() {
            payamount = sum.toStringAsFixed(2);
          });
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Coupon Accepted!!!')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Coupon not accepted!!!')),
          );
        }
      });
    }
  }

  Widget _productdetail() {
    const headerstyle = TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
    const conatentstyle = TextStyle(fontSize: 18);
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, left: 10.0),
      child: Container(
        child: Column(
          children: [
            Container(
              child: Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: Text("Product :", style: headerstyle),
                  ),
                  Container(
                      child: Text(
                    name,
                    style: conatentstyle,
                  )),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              child: Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: Text("Quantity:", style: headerstyle),
                  ),
                  Container(
                      child: Text(
                    qty,
                    style: conatentstyle,
                  )),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              child: Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: Text("Price:", style: headerstyle),
                  ),
                  Container(
                      child: Text(
                    finalamount,
                    style: conatentstyle,
                  )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _prepaidform() {
    return Container(
      child: Column(
        children: [
          for (int i = 0; i < prepaidoption.length; i++)
            ListTile(
              title: Text(
                prepaidoption[i]['label_name'] +
                    ' (' +
                    prepaidoption[i]['number_of_days'] +
                    ' days) ',
              ),
              leading: Radio(
                  value: prepaidoption[i]['number_of_days'].toString(),
                  groupValue: _prepaidvalue.toString(),
                  onChanged: (value) {
                    setState(() {
                      _prepaidvalue = value.toString();
                      double tempval =
                          double.parse(payamount) * double.parse(_prepaidvalue);
                      payamount = tempval.toStringAsFixed(2);
                    });
                  }),
            ),
        ],
      ),
    );
  }

  Widget _couponform() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
        // decoration: BoxDecoration(border: Border.all()),
        child: Form(
            key: _couponformKey,
            child: Column(
              children: [
                Container(
                  child: TextFormField(
                    controller: coupontextcontroller,
                    decoration: InputDecoration(
                        suffixIcon: TextButton(
                            style: TextButton.styleFrom(
                              primary: Colors.pink,
                            ),
                            onPressed: _checkcoupon,
                            child: Text(
                              "Apply Coupon",
                              style: TextStyle(fontSize: 15.0),
                            )),
                        border: UnderlineInputBorder(),
                        labelText: "Add Coupon"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter coupon code';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  child: TextFormField(
                    controller: addresscontroller,
                    decoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: "Flat / Wing"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter address';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 20.0),
                if (btntype == 'subscription')
                  Container(
                    padding: const EdgeInsets.only(left: 80),
                    child: Row(
                      children: [
                        ElevatedButton(
                          style: _prepaidPressed
                              ? _selectedbtnstyle
                              : _prepaidbtnstyle,
                          child: new Text(
                            'Prepaid',
                            style: TextStyle(color: Colors.black),
                          ),
                          onPressed: () => {
                            setState(() {
                              _prepaidPressed = !_prepaidPressed;
                              _postpaidPressed = false;
                              _pressval = 'prepaid';
                              _showprepaid = !_showprepaid;
                            })
                          },
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        ElevatedButton(
                          style: _postpaidPressed
                              ? _selectedbtnstyle
                              : _postpaidbtnstyle,
                          child: new Text('Postpaid',
                              style: TextStyle(color: Colors.black)),
                          onPressed: () => {
                            setState(() {
                              _postpaidPressed = !_postpaidPressed;
                              _prepaidPressed = false;
                              _pressval = 'postpaid';
                              _showprepaid = false;
                            })
                          },
                        )
                      ],
                    ),
                  ),
                if (_showprepaid) _prepaidform(),
                SizedBox(height: 20),
                Container(
                  child: Row(
                    children: [
                      Container(
                        child: Text(
                          "Pay Now:",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 20),
                        child: Text(
                          payamount,
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                // Container(
                //   child: RazorPayPage(),
                // ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_couponformKey.currentState!.validate()) {
                        print("review");
                        print(custdata);
                        setState(() {
                          custdata[0]['prize'] = payamount;
                          custdata[0]['address'] = addresscontroller.text;
                          custdata[0]['subscriptionpaymenttype'] = _pressval;
                          if (btntype == 'subscription' &&
                              _pressval == 'prepaid') {
                            custdata[0]['prepaidoption'] = _prepaidvalue;
                          } else {
                            custdata[0]['prepaidoption'] = '0';
                          }
                        });

                        openCheckout();

                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //       builder: (context) =>
                        //           OrderPage(customerdata: custdata),
                        //     ));

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Processing Data')),
                        );
                      }
                    },
                    child: const Text('Confirm Order'),
                  ),
                ),
              ],
            )),
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
        title: Text("Review Order"),
      ),
      bottomNavigationBar: FooterPage(pageindex: 1),
      endDrawer: MyaccountPage(),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _productdetail(),
              _couponform(),
            ],
          ),
        ),
      ),
    );
  }
}
