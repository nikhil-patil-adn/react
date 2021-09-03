import 'package:fellowfarmer/pages/footer.dart';
import 'package:fellowfarmer/pages/myaccount_page.dart';
import 'package:fellowfarmer/pages/paymentstatement.dart';
import 'package:fellowfarmer/pages/subscription_delivery_statement.dart';
import 'package:fellowfarmer/widgets/customwidget.dart';
import 'package:flutter/material.dart';

class StatementPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: lineargradientbg(),
        title: Text("Statement"),
      ),
      endDrawer: MyaccountPage(),
      bottomNavigationBar: FooterPage(pageindex: 1),
      body: Container(
        child: Column(
          children: [
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: const Color(0xffed1c22), // background
                  onPrimary: Colors.white, // foreground
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PaymentStatement()));
                },
                child: Text("Payment Statement")),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: const Color(0xffed1c22), // background
                  onPrimary: Colors.white, // foreground
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SubDeliveryStatement()));
                },
                child: Text("Subscription Delivery Statement")),
          ],
        ),
      ),
    );
  }
}
