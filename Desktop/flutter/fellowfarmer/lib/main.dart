import 'dart:async';
import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:fellowfarmer/pages/home_loader.dart';
import 'package:fellowfarmer/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'api/api.dart';
import 'pages/product_list.dart';
import 'pages/show_product_banners.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    'This channel is used for important notifications.', // description
    importance: Importance.high,
    playSound: true);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('A bg message just showed up :  ${message.messageId}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  runApp(FellowFarmer());
}

class FellowFarmer extends StatefulWidget {
  @override
  _FellowFarmerState createState() => _FellowFarmerState();
}

class _FellowFarmerState extends State<FellowFarmer> {
  late Timer _timer;
  int _start = 3;
  bool loading = true;
  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          if (_start < 1) {
            setState(() {
              loading = false;
            });
            timer.cancel();
          } else {
            _start = _start - 1;
          }
        },
      ),
    );
  }

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FellowFarmer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: loading == true ? HomeLoader() : MyHomePage(title: "Fellow Farmer"),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var host = "http://192.168.2.107:8000";
  var product = [];
  bool isLogin = false;
  var name = "";
  var image = "";
  var desciption = "";
  var banners = [];
  var tokennew = "8334d1d63c97cc583ac50fc034afaf5f57833251";
  void initState() {
    super.initState();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channel.description,
                color: Colors.blue,
                playSound: true,
                icon: '@mipmap/ic_launcher',
              ),
            ));
      }
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Text("test title"),
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text("test body")],
                  ),
                ),
              );
            });
      }
    });

    var obj = new Api();
    obj.checklogin().then((value) {
      if (value == "") {
        setState(() {
          isLogin = false;
        });
      } else {
        setState(() {
          isLogin = true;
        });
      }
    });

    fetchBanner();
  }

  // getTokenData() async {
  //   String username = 'nikspath';
  //   String password = 'crt@1234';
  //   var url = host + "/api-token-auth";
  //   var response = await http.post(Uri.parse(url),
  //       body: {'username': username, 'password': password});

  //   setState(() {
  //     tokennew = json.decode(response.body)['token'];
  //   });
  // }
  logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('isLogin', '0');
    prefs.setString('custmobile', '');
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MyHomePage(title: 'FellowFarmer')));
  }

  showNotification() async {
    String token = tokennew;
    String basicAuth = 'Token ' + token;
    var url = Uri.parse(host + '/api/products/details/2');
    var response = await http
        .get(url, headers: <String, String>{'authorization': basicAuth});

    product = json.decode(response.body);
    setState(() {
      name = product[0]['name'];
      image = product[0]['image'];
      desciption = product[0]['desciption'];
    });
    flutterLocalNotificationsPlugin.show(
        0,
        name,
        desciption,
        NotificationDetails(
            android: AndroidNotificationDetails(
                channel.id, channel.name, channel.description,
                importance: Importance.high,
                color: Colors.blue,
                playSound: true,
                icon: '@mipmap/ic_launcher')));
  }

  fetchBanner() async {
    var url = host + "/api/banners/fetch_banners/";
    var response = await http.get(Uri.parse(url));
    var datas = json.decode(response.body);
    setState(() {
      banners = datas;
    });
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
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pop(context);
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
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        endDrawer: customeDrawer(),
        body: Column(
          children: [
            CarouselSlider(
              options: CarouselOptions(
                height: 200.0,
                autoPlay: true,
                viewportFraction: 0.9,
              ),
              items: banners.map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProductList()),
                        );
                      },
                      child: Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.symmetric(horizontal: 5.0),
                          //decoration: BoxDecoration(color: Colors.amber),
                          child: Image.network(i['banner'], fit: BoxFit.fill)),
                    );
                  },
                );
              }).toList(),
            ),
            ShowProductBanner(),
            ElevatedButton(
                onPressed: () {
                  showNotification();
                },
                child: Text("Show notification"))
          ],
        ));
  }
}
