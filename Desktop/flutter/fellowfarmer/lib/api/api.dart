import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Api {
  var host = "http://192.168.2.107:8000";
  var tokennew = "8334d1d63c97cc583ac50fc034afaf5f57833251";

  insertcustomer(List custdata) async {
    String token = tokennew;
    String basicAuth = 'Token ' + token;
    var url = host + "/api/customers/customerregister/";
    var response = await http.post(
      Uri.parse(url),
      headers: <String, String>{'authorization': basicAuth},
      body: jsonEncode(<String, String>{
        'name': custdata[0]['name'],
        'mobile': custdata[0]['mobile'],
        'city': custdata[0]['city'],
        'society': custdata[0]['location']
      }),
    );
    var cust = json.decode(response.body);

    if (cust.length > 0) {
      return true;
    } else {
      return false;
    }
  }

  Future<List> fetchProduct() async {
    List product = [];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var selectedproductcode = prefs.getInt('selectedproductcode');
    String token = tokennew;
    String basicAuth = 'Token ' + token;
    var url = host + "/api/products/details/" + selectedproductcode.toString();
    var response = await http.get(Uri.parse(url),
        headers: <String, String>{'authorization': basicAuth});
    product = json.decode(response.body);
    return product;
  }

  insertorder(custdata) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var selectedproductcode = prefs.getInt('selectedproductcode');
    String token = tokennew;
    String basicAuth = 'Token ' + token;
    var url = host + "/api/orders/insertorder/";
    var response = await http.post(
      Uri.parse(url),
      headers: <String, String>{'authorization': basicAuth},
      body: jsonEncode(<String, String>{
        'name': custdata[0]['name'],
        'mobile': custdata[0]['mobile'],
        'city': custdata[0]['city'],
        'society': custdata[0]['location'],
        'prize': custdata[0]['prize'],
        'quantity': custdata[0]['quantity'],
        'fetchorder': '1',
        'selectedproductcode': selectedproductcode.toString()
      }),
    );
    var orders = json.decode(response.body);
    print(orders);
    return orders;
  }

  checkouponavailable(String coupon) async {
    List coupons = [];
    String token = tokennew;
    String basicAuth = 'Token ' + token;
    var url = host + "/api/coupons/checkcoupon/" + coupon.toString();
    var response = await http.get(Uri.parse(url),
        headers: <String, String>{'authorization': basicAuth});
    coupons = json.decode(response.body);
    return coupons;
  }
}
