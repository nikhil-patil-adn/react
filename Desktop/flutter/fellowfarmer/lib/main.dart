import 'dart:async';
import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:fellowfarmer/api/api.dart';
import 'package:fellowfarmer/pages/footer.dart';
import 'package:fellowfarmer/pages/home_feedbacklist.dart';
import 'package:fellowfarmer/pages/home_loader.dart';
import 'package:fellowfarmer/pages/myaccount_page.dart';
import 'package:fellowfarmer/pages/product_detail.dart';
import 'package:fellowfarmer/widgets/customwidget.dart';
//import 'package:fellowfarmer/razorpay/razorpay.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'pages/product_list.dart';

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
    Map<int, Color> color = {
      50: Color.fromRGBO(255, 92, 87, .1),
      100: Color.fromRGBO(255, 92, 87, .2),
      200: Color.fromRGBO(255, 92, 87, .3),
      300: Color.fromRGBO(255, 92, 87, .4),
      400: Color.fromRGBO(255, 92, 87, .5),
      500: Color.fromRGBO(255, 92, 87, .6),
      600: Color.fromRGBO(255, 92, 87, .7),
      700: Color.fromRGBO(255, 92, 87, .8),
      800: Color.fromRGBO(255, 92, 87, .9),
      900: Color.fromRGBO(255, 92, 87, 1),
    };
    MaterialColor colorCustom = MaterialColor(0xFFcea335, color);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FellowFarmer',
      theme: ThemeData(primarySwatch: colorCustom),
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
  var host = "http://192.168.2.103:8000";
  var product = [];
  bool isLogin = false;
  var name = "";
  var image = "";
  var desciption = "";
  var displaydata = '0';
  var banners = [];
  var products = [];
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

  fetchBanner() {
    var obj = new Api();
    obj.fetchbannerlist().then((datas) {
      if (datas.length > 0) {
        setState(() {
          banners = datas;
        });
      }
    });

    obj.fetchProductList().then((value) {
      setState(() {
        displaydata = '1';
        products = value;
      });
    });
  }

  Widget displayproduct() {
    return Container(
      //margin: const EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
        // borderRadius: BorderRadius.vertical(top: Radius.circular(30.0)),

        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(0.0, 1.0), //(x,y)
            blurRadius: 5.0,
          ),
        ],
      ),
      child: CarouselSlider(
        options: CarouselOptions(
          height: 150.0,
          autoPlay: true,
          viewportFraction: 0.9,
          enlargeCenterPage: true,
        ),
        items: products.map((i) {
          return Builder(
            builder: (BuildContext context) {
              return Container(
                  width: MediaQuery.of(context).size.width * 1.0,
                  //margin: EdgeInsets.symmetric(horizontal: 5.0),
                  //decoration: BoxDecoration(color: Colors.amber),
                  child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProductDetail(
                                  code: i['code'], quantity: '0')),
                        );
                      },
                      child: Image.network(
                        i['image'],
                        fit: BoxFit.fill,
                      )));
            },
          );
        }).toList(),
      ),
    );
  }

  Widget displayhomedata() {
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: 200.0,
            autoPlay: true,
            viewportFraction: 0.9,
            enlargeCenterPage: true,
          ),
          items: banners.map((i) {
            return Builder(
              builder: (BuildContext context) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProductList()),
                    );
                  },
                  child: Container(
                    width: 1000.0,
                    // decoration: BoxDecoration(border: Border.all()),
                    margin: EdgeInsets.only(top: 5),
                    // borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    child: Image.network(
                      i['banner'],
                      fit: BoxFit.fill,
                      width: 1000.0,
                    ),
                  ),
                );
              },
            );
          }).toList(),
        ),
        SizedBox(
          height: 10,
        ),
        displayproduct(),
        SizedBox(
          height: 10,
        ),

        HomeFeedback(),

        // ElevatedButton(
        //     onPressed: () {
        //       showNotification();
        //     },
        //     child: Text("Show notification")),
        // ElevatedButton(
        //     onPressed: () {
        //       Navigator.push(context,
        //           MaterialPageRoute(builder: (context) => RazorPayPage()));
        //     },
        //     child: Text("razor pay"))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          flexibleSpace: lineargradientbg(),
          title: Text(widget.title),
        ),
        endDrawer: MyaccountPage(),
        bottomNavigationBar: FooterPage(pageindex: 0),
        body: displaydata == '1' ? displayhomedata() : ImageDialog());
  }
}
