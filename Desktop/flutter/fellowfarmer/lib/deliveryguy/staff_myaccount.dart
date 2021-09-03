import 'package:fellowfarmer/api/api.dart';
import 'package:fellowfarmer/deliveryguy/deliverypage.dart';
import 'package:fellowfarmer/main.dart';
import 'package:fellowfarmer/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StaffMyaccount extends StatefulWidget {
  @override
  _StaffMyaccountState createState() => _StaffMyaccountState();
}

class _StaffMyaccountState extends State<StaffMyaccount> {
  bool isstaffLogin = false;
  String staffname = "Staff";
  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);
  void initState() {
    super.initState();
    var obj = new Api();
    obj.checkstafflogin().then((value) {
      print(value);
      if (value.length > 0) {
        setState(() {
          isstaffLogin = true;
          staffname = capitalize(value[1]);
        });
      } else {
        setState(() {
          isstaffLogin = false;
        });
      }
    });
  }

  logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('isstaffLogin', '0');
    prefs.setString('staffmobile', '');
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MyHomePage(title: 'FellowFarmer')));
  }

  Widget staffDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
              height: 100,
              child: DrawerHeader(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Color(0xFFcea335), Color(0xFFed1c22)])),
                child: Text('Welcome ' + staffname,
                    style: TextStyle(
                      fontSize: 20.0,
                    )),
              )),

          if (!isstaffLogin)
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
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => DeliveryPage()));
            },
          ),
          if (isstaffLogin)
            ListTile(
              title: const Text('Logout'),
              onTap: () {
                logout();
              },
            ),
          // if (isstaffLogin)
          //   ListTile(
          //     title: const Text('Edit profile'),
          //     onTap: () {
          //       Navigator.push(
          //           context,
          //           MaterialPageRoute(
          //               builder: (context) => CustomerEditProfile()));
          //     },
          //   ),
          // if (isstaffLogin)
          //   ListTile(
          //     title: const Text('Add feedback'),
          //     onTap: () {
          //       Navigator.push(context,
          //           MaterialPageRoute(builder: (context) => AddFeedback()));
          //     },
          //   ),
          // if (isstaffLogin)
          //   ListTile(
          //     title: const Text("My Feedback"),
          //     onTap: () {
          //       Navigator.push(context,
          //           MaterialPageRoute(builder: (context) => FeedbackList()));
          //     },
          //   ),
          // if (isstaffLogin)
          //   ListTile(
          //     title: const Text("My Calender"),
          //     onTap: () {
          //       Navigator.push(context,
          //           MaterialPageRoute(builder: (context) => CalenderPage()));
          //     },
          //   ),
          // if (isstaffLogin)
          //   ListTile(
          //     title: const Text("My Plan"),
          //     onTap: () {
          //       Navigator.push(context,
          //           MaterialPageRoute(builder: (context) => MyHoliday()));
          //     },
          //   ),
          // if (isstaffLogin)
          //   ListTile(
          //     title: const Text("My Subscription"),
          //     onTap: () {
          //       Navigator.push(
          //           context,
          //           MaterialPageRoute(
          //               builder: (context) => SubscriptionList()));
          //     },
          //   ),
          // if (isstaffLogin)
          //   ListTile(
          //     title: const Text("My regular order"),
          //     onTap: () {
          //       Navigator.push(
          //           context,
          //           MaterialPageRoute(
          //               builder: (context) => RegularOrderList()));
          //     },
          //   ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return staffDrawer();
  }
}
