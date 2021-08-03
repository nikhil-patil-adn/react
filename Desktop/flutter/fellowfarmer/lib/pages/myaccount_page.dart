import 'package:fellowfarmer/api/api.dart';
import 'package:fellowfarmer/main.dart';
import 'package:fellowfarmer/pages/edit_customer_profile.dart';
import 'package:fellowfarmer/pages/login_page.dart';
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
              height: 100,
              child: DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text('Welcome ' + customername,
                    style: TextStyle(
                      fontSize: 20.0,
                    )),
              )),
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
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return customeDrawer();
  }
}
