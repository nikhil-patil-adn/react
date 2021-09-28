import 'package:fellowfarmer/api/api.dart';
import 'package:fellowfarmer/deliveryguy/loginpage.dart';
import 'package:fellowfarmer/main.dart';
import 'package:fellowfarmer/pages/buynowlist.dart';
import 'package:fellowfarmer/pages/delivery_calender.dart';
import 'package:fellowfarmer/pages/edit_customer_profile.dart';
import 'package:fellowfarmer/pages/feedback_list.dart';
import 'package:fellowfarmer/pages/feedback_page.dart';
import 'package:fellowfarmer/pages/login_page.dart';
import 'package:fellowfarmer/pages/myholidays.dart';
import 'package:fellowfarmer/pages/statementpage.dart';
import 'package:fellowfarmer/pages/subscriptionlist.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyaccountPage extends StatefulWidget {
  @override
  _MyaccountPageState createState() => _MyaccountPageState();
}

class _MyaccountPageState extends State<MyaccountPage> {
  bool isLogin = false;
  String customername = "Customer";
  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);
  void initState() {
    super.initState();
    var obj = new Api();
    obj.checklogin().then((value) {
      print(value);
      if (value.length > 0) {
        setState(() {
          isLogin = true;
          customername = capitalize(value[1]);
        });
      } else {
        setState(() {
          isLogin = false;
        });
      }
    });
  }

  logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('isLogin', '0');
    prefs.setString('custmobile', '');
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MyHomePage(title: 'FellowFarmer')));
  }

  Widget customeDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
              height: 120,
              child: DrawerHeader(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Color(0xFFecaa17), Color(0xFFbb9238)])),
                child: Text('Welcome ' + customername,
                    style: TextStyle(
                      fontSize: 20.0,
                    )),
              )),
          ListTile(
            title: const Text('Delivery Guy'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DeliveryGuyLogin(),
                  ));
            },
          ),
          if (!isLogin)
            ListTile(
              title: const Text('Login'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginPage(),
                    ));
              },
            ),
          ListTile(
            title: const Text('Home'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MyHomePage(title: 'FellowFarmer')));
            },
          ),
          if (isLogin)
            ListTile(
              title: const Text('Logout'),
              onTap: () {
                logout();
              },
            ),
          if (isLogin)
            ListTile(
              title: const Text('Edit profile'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CustomerEditProfile()));
              },
            ),
          if (isLogin)
            ListTile(
              title: const Text('Add feedback'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AddFeedback()));
              },
            ),
          if (isLogin)
            ListTile(
              title: const Text("My Feedback"),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => FeedbackList()));
              },
            ),
          if (isLogin)
            ListTile(
              title: const Text("My Calender"),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CalenderPage()));
              },
            ),
          if (isLogin)
            ListTile(
              title: const Text("My Plan"),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MyHoliday()));
              },
            ),
          if (isLogin)
            ListTile(
              title: const Text("My Subscription"),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SubscriptionList()));
              },
            ),
          if (isLogin)
            ListTile(
              title: const Text("My regular order"),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => RegularOrderList()));
              },
            ),
          if (isLogin)
            ListTile(
              title: const Text("Statement"),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => StatementPage()));
              },
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return customeDrawer();
  }
}
