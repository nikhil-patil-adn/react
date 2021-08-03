import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Api {
  var host = "http://192.168.2.107:8000";
  var tokennew = "8334d1d63c97cc583ac50fc034afaf5f57833251";

  updatepasswordcustomer(mobile, password) async {
    print(mobile);
    print(password);
    String token = tokennew;
    String basicAuth = 'Token ' + token;
    var url = host + "/api/customers/updatepassword/";
    var response = await http.post(
      Uri.parse(url),
      headers: <String, String>{'authorization': basicAuth},
      body:
          jsonEncode(<String, String>{'mobile': mobile, 'password': password}),
    );
    List customers = json.decode(response.body);

    return customers;
  }

  fetchProductandsetcode(int code, qty) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('selectedproductcode', code);
    prefs.setString('selectedqty', qty);

    String token = tokennew;
    String basicAuth = 'Token ' + token;
    var url = host + "/api/products/details/" + code.toString();
    var response = await http.get(Uri.parse(url),
        headers: <String, String>{'authorization': basicAuth});
    List product = json.decode(response.body);

    return product;
  }

  fetchSociety(String location) async {
    String token = tokennew;
    String basicAuth = 'Token ' + token;
    var url = host + "/api/location/getsociety/" + location;
    var response = await http.get(Uri.parse(url),
        headers: <String, String>{'authorization': basicAuth});
    var society = json.decode(response.body);

    if (society.length > 0) {
      return society[0]['name'];
    } else {
      return null;
    }
  }

  fetchSocietyid(String id) async {
    String token = tokennew;
    String basicAuth = 'Token ' + token;
    var url = host + "/api/location/getsocietybyid/" + id;
    var response = await http.get(Uri.parse(url),
        headers: <String, String>{'authorization': basicAuth});
    var society = json.decode(response.body);
    if (society.length > 0) {
      return society[0]['name'];
    } else {
      return null;
    }
  }

  fetchCityid(String id) async {
    String token = tokennew;
    String basicAuth = 'Token ' + token;
    var url = host + "/api/city/getcitybyid/" + id;
    var response = await http.get(Uri.parse(url),
        headers: <String, String>{'authorization': basicAuth});
    var society = json.decode(response.body);

    if (society.length > 0) {
      return society[0]['name'];
    } else {
      return null;
    }
  }

  registercustomer(List custdata) async {
    String token = tokennew;
    String basicAuth = 'Token ' + token;
    var url = host + "/api/customers/customerregisterwithuserpass/";
    var response = await http.post(
      Uri.parse(url),
      headers: <String, String>{'authorization': basicAuth},
      body: jsonEncode(<String, String>{
        'username': custdata[0]['username'],
        'password': custdata[0]['password'],
        'name': custdata[0]['name'],
        'email': custdata[0]['email'],
        'mobile': custdata[0]['mobile'],
        'city': custdata[0]['city'],
        'society': custdata[0]['society'],
        'address': custdata[0]['address'],
        'update': custdata[0]['update'] == '1' ? custdata[0]['update'] : '0',
        'id': custdata[0]['id'].toString() != '' ? custdata[0]['id'] : '0',
      }),
    );
    var cust = json.decode(response.body);

    if (cust.length > 0) {
      return true;
    } else {
      return false;
    }
  }

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

  checklogin() async {
    var ismobile = "";
    var custname = "";
    List custdata = [];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var islogin = prefs.getString('isLogin');
    if (islogin == '1') {
      ismobile = prefs.getString('custmobile')!;
      custname =
          prefs.containsKey('custname') ? prefs.getString('custname')! : "";
      custdata = [ismobile, custname];
    }
    return custdata;
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

  fetchProductList() async {
    List products = [];
    String token = tokennew;
    String basicAuth = 'Token ' + token;
    var url = host + "/api/products/fetch_products/";
    var response = await http.get(Uri.parse(url),
        headers: <String, String>{'authorization': basicAuth});
    products = json.decode(response.body);
    return products;
  }

  checkregister(String mobile) async {
    String token = tokennew;
    String basicAuth = 'Token ' + token;
    var url = host + "/api/customers/checkregister/" + mobile;
    var response = await http.get(Uri.parse(url),
        headers: <String, String>{'authorization': basicAuth});
    var customer = json.decode(response.body);

    if (customer.length > 0) {
      return customer[0]['name'];
    } else {
      return null;
    }
  }

  login({mobile, password}) async {
    List customers = [];
    String token = tokennew;
    String basicAuth = 'Token ' + token;
    var url = host + "/api/customers/checklogin/";
    var response = await http.post(
      Uri.parse(url),
      headers: <String, String>{'authorization': basicAuth},
      body: jsonEncode(<String, String>{
        'password': password,
        'mobile': mobile,
      }),
    );
    customers = json.decode(response.body);
    if (customers.length > 0) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('isLogin', '1');
      prefs.setString('custmobile', customers[0]['mobile']);
      prefs.setString('custname', customers[0]['name']);
    }
    return customers;
  }

  getLoggedincustomerdata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var isLogin = prefs.getString('isLogin');
    var custmob = prefs.getString('custmobile');
    if (isLogin == '1' && custmob != "") {
      String token = tokennew;
      String basicAuth = 'Token ' + token;
      var url = host + "/api/customers/checkregister/" + custmob.toString();
      var response = await http.get(Uri.parse(url),
          headers: <String, String>{'authorization': basicAuth});
      var customer = json.decode(response.body);

      if (customer.length > 0) {
        return customer;
      } else {
        return null;
      }
    } else {
      return [];
    }
  }
}
