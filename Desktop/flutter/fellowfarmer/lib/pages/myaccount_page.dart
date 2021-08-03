import 'package:fellowfarmer/main.dart';
import 'package:fellowfarmer/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyaccountPage extends StatefulWidget {
  @override
  _MyaccountPageState createState() => _MyaccountPageState();
}

class _MyaccountPageState extends State<MyaccountPage> {
  bool isLogin = false;
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
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text('Drawer Header'),
          ),
          if (!isLogin)
            ListTile(
              title: const Text('Login'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
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
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return customeDrawer();
  }
}
