import 'package:fellowfarmer/api/api.dart';
import 'package:fellowfarmer/deliveryguy/deliverypage.dart';
import 'package:fellowfarmer/deliveryguy/forgetpassword_d.dart';
import 'package:fellowfarmer/pages/footer.dart';
import 'package:fellowfarmer/pages/myaccount_page.dart';
import 'package:fellowfarmer/widgets/customwidget.dart';
import 'package:flutter/material.dart';

class DeliveryGuyLogin extends StatefulWidget {
  DeliveryGuyLogin({Key? key}) : super(key: key);
  @override
  _DeliveryGuyLoginState createState() => _DeliveryGuyLoginState();
}

class _DeliveryGuyLoginState extends State<DeliveryGuyLogin> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          flexibleSpace: lineargradientbg(),
          title: Text(' Satff Login Page'),
        ),
        endDrawer: MyaccountPage(),
        bottomNavigationBar: FooterPage(pageindex: 1),
        body: Padding(
            padding: EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'FellowFarmer',
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w500,
                          fontSize: 30),
                    )),
                Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Sign in',
                      style: TextStyle(fontSize: 20),
                    )),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Mobile',
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextField(
                    obscureText: true,
                    controller: passwordController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                    ),
                  ),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    primary: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ForgetPasswordStaff()));
                  },
                  child: Text(
                    'Forgot Password',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
                Container(
                    height: 50,
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: const Color(0xffed1c22), // background
                        onPrimary: Colors.white, // foreground
                      ),
                      child: Text('Login'),
                      onPressed: () {
                        var obj = new Api();
                        obj
                            .stafflogin(
                                mobile: nameController.text,
                                password: passwordController.text)
                            .then((value) {
                          print(value);
                          if (value.length > 0) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DeliveryPage()));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content:
                                    const Text('Wrong Username Password!!!'),
                              ),
                            );
                          }
                        });
                      },
                    )),
                // Container(
                //     child: Row(
                //   children: <Widget>[
                //     Text('Does not have account?'),
                //     ElevatedButton(
                //       child: Text(
                //         'Sign up',
                //         style: TextStyle(fontSize: 20),
                //       ),
                //       onPressed: () {
                //         // Navigator.push(
                //         //     context,
                //         //     MaterialPageRoute(
                //         //         builder: (context) => CustomerRegister()));
                //       },
                //     )
                //   ],
                //   mainAxisAlignment: MainAxisAlignment.center,
                // ))
              ],
            )));
  }
}
