import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math';

class Api {
  //var host = "http://fellowfarmer.pythonanywhere.com";
  //var tokennew = "a69eb53cb825906b7fdf5cccaeef6d0a58e377f0";
  //var host = "http://192.168.2.104:8000";

  var host = "http://192.168.2.200:8000";
  var tokennew = "8334d1d63c97cc583ac50fc034afaf5f57833251";
  fetchbannerlist() async {
    var url = host + "/api/banners/fetch_banners/";
    var response = await http.get(Uri.parse(url));
    var datas = json.decode(response.body);
    return datas;
  }

  sendotp(cust) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Random random = new Random();
    int randomNumber = random.nextInt(10000);
    print(randomNumber);

    prefs.setString("otp_" + cust[0]['mobile'], randomNumber.toString());
    String token = tokennew;
    String basicAuth = 'Token ' + token;
    var url = host + "/api/sendsmsemails/sendsmsapi/";
    var response = await http.post(Uri.parse(url),
        headers: <String, String>{'authorization': basicAuth},
        body: jsonEncode(<String, String>{
          'mobile': cust[0]['mobile'].toString(),
          'otp': randomNumber.toString()
        }));
    var sms = json.decode(response.body);
    print(sms);

    return sms;
  }

  checkOTP(cust, newotp) async {
    print("insode api");
    print(cust);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var setotp = prefs.getString(
      "otp_" + cust[0]['mobile'],
    );
    print("setotp");
    print(setotp);
    print("newotp");
    print(newotp);

    if (newotp == setotp) {
      return true;
    } else {
      return false;
    }
  }

  updatepasswordcustomer(mobile, password, isStaff) async {
    print(mobile);
    print(password);
    print(isStaff);
    String token = tokennew;
    String basicAuth = 'Token ' + token;
    var url = "";

    if (isStaff == '1') {
      print("staff inside wwwwwwwwwwww");
      url = host + "/api/staffpersons/updatepasswordstaff/";
    } else {
      url = host + "/api/customers/updatepassword/";
    }
    print(url);
    var response = await http.post(
      Uri.parse(url),
      headers: <String, String>{'authorization': basicAuth},
      body:
          jsonEncode(<String, String>{'mobile': mobile, 'password': password}),
    );
    List customers = json.decode(response.body);
    print(customers);

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

  fetchProductdetail(int code) async {
    String token = tokennew;
    String basicAuth = 'Token ' + token;
    var url = host + "/api/products/details/" + code.toString();
    var response = await http.get(Uri.parse(url),
        headers: <String, String>{'authorization': basicAuth});
    List product = json.decode(response.body);

    return product;
  }

  stopResumeSubscription(String code, String status) async {
    String token = tokennew;
    String basicAuth = 'Token ' + token;
    var url = host +
        "/api/subscriptions/stopsubscription/" +
        code.toString() +
        "/" +
        status;
    var response = await http.get(Uri.parse(url),
        headers: <String, String>{'authorization': basicAuth});
    List subscriptiondata = json.decode(response.body);

    return subscriptiondata;
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

  fetchfeedbackbycustomer(String id) async {
    String token = tokennew;
    String basicAuth = 'Token ' + token;
    var url = host + "/api/feedbacks/fetchfeedbackbycustomer/" + id.toString();
    var response = await http.get(Uri.parse(url),
        headers: <String, String>{'authorization': basicAuth});
    var feedbacks = json.decode(response.body);
    return feedbacks;
  }

  fetchallfeedback() async {
    String token = tokennew;
    //token =
    //    "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNjMxMDkwNDY3LCJqdGkiOiJjN2YwNDZkY2RlNzY0OTk0YTJiNDA0YzM1MDNmNWFkZiIsInVzZXJfaWQiOjF9.7Pv8pce3Z_562Qo8Co-wM35ADSJ3jl2oRZ9HAaNpj5s";
    String basicAuth = 'Token ' + token;
    var url = host + "/api/feedbacks/fetchallfeedback/";
    var response = await http.get(Uri.parse(url),
        headers: <String, String>{'authorization': basicAuth});
    var feedbacks = json.decode(response.body);
    return feedbacks;
  }

  fetchholidaybycustomer(String id) async {
    String token = tokennew;
    String basicAuth = 'Token ' + token;
    var url = host + "/api/myholidays/fetchholidaybycustomer/" + id.toString();
    var response = await http.get(Uri.parse(url),
        headers: <String, String>{'authorization': basicAuth});
    var holidays = json.decode(response.body);
    return holidays;
  }

  getfeedbackquestion() async {
    String token = tokennew;
    String basicAuth = 'Token ' + token;
    var url = host + "/api/feedbacks/fetchquestions/";
    var response = await http.get(Uri.parse(url),
        headers: <String, String>{'authorization': basicAuth});
    var feedbacks = json.decode(response.body);
    return feedbacks;
  }

  fetchPaymentStatementByCustomer(String id) async {
    String token = tokennew;
    String basicAuth = 'Token ' + token;
    var url = host + "/api/paymentlogs/fetchlogsbycustomer/" + id.toString();
    var response = await http.get(Uri.parse(url),
        headers: <String, String>{'authorization': basicAuth});
    var logs = json.decode(response.body);
    return logs;
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
        'pincode': custdata[0]['pincode'],
        'address': custdata[0]['address'],
        'update': custdata[0]['update'] == '1' ? custdata[0]['update'] : '0',
        'id': custdata[0]['id'] != null ? custdata[0]['id'] : '0',
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
        'email': custdata[0]['email'],
        'city': custdata[0]['city'],
        'society': custdata[0]['location'],
        'pincode': custdata[0]['pincode']
      }),
    );
    var cust = json.decode(response.body);
    print(cust);

    if (cust.length > 0) {
      return true;
    } else {
      return false;
    }
  }

  checkmobile(mob) {
    checklogin().then((val) {
      print("check login");
      print(val);
      if (val.length > 0) {
        // setState(() {
        //   ischeckmobile = true;
        // });
        return true;
      } else {
        ismobileregister(mob).then((custval) {
          print("in return custdata");
          print(custval);
          if (custval.length > 0) {
            return false;
          } else {
            return true;
          }
        });
      }
    });
  }

  ismobileregister(mob) async {
    String token = tokennew;
    String basicAuth = 'Token ' + token;
    var url = host + "/api/customers/checkmobile/" + mob.toString();
    var response = await http.get(Uri.parse(url),
        headers: <String, String>{'authorization': basicAuth});
    var mobile = json.decode(response.body);
    return mobile;
  }

  insertfeedback(List custdata) async {
    String token = tokennew;
    String basicAuth = 'Token ' + token;
    var url = host + "/api/feedbacks/insertfeedback/";
    var response = await http.post(
      Uri.parse(url),
      headers: <String, String>{'authorization': basicAuth},
      body: jsonEncode(<String, String>{
        'email': custdata[0]['email'],
        'mobile': custdata[0]['mobile'],
        'type': custdata[0]['type'],
        'comment': custdata[0]['comment'],
      }),
    );
    var cust = json.decode(response.body);
    if (cust.length > 0) {
      return true;
    } else {
      return false;
    }
  }

  frequencyprepaidbyproduct(id) async {
    String token = tokennew;
    String basicAuth = 'Token ' + token;
    var url = host + "/api/frequency/fetchfrquencybyproduct/" + id.toString();
    var response = await http.get(Uri.parse(url),
        headers: <String, String>{'authorization': basicAuth});
    var frequency = json.decode(response.body);
    return frequency;
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

  fetchAllSociety() async {
    List society = [];
    String token = tokennew;
    String basicAuth = 'Token ' + token;
    var url = host + "/api/location/allsociety/";
    var response = await http.get(Uri.parse(url),
        headers: <String, String>{'authorization': basicAuth});
    society = json.decode(response.body);
    return society;
  }

  fetchAllCity() async {
    List city = [];
    String token = tokennew;
    String basicAuth = 'Token ' + token;
    var url = host + "/api/city/allcity/";
    var response = await http.get(Uri.parse(url),
        headers: <String, String>{'authorization': basicAuth});
    city = json.decode(response.body);
    return city;
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

  updatedeliverystatus(orderid, status) async {
    print(orderid);
    List orders = [];
    String token = tokennew;
    String basicAuth = 'Token ' + token;
    var url = host +
        "/api/orders/updatestatus/" +
        orderid.toString() +
        "/" +
        status.toString();
    var response = await http.get(Uri.parse(url),
        headers: <String, String>{'authorization': basicAuth});
    orders = json.decode(response.body);
    return orders;
  }

  checkstafflogin() async {
    var ismobile = "";
    var staffname = "";
    List staffdata = [];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var islogin = prefs.getString('isstaffLogin');
    if (islogin == '1') {
      ismobile = prefs.getString('staffmobile')!;
      staffname =
          prefs.containsKey('staffname') ? prefs.getString('staffname')! : "";
      staffdata = [ismobile, staffname];
    }
    return staffdata;
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
        'email': custdata[0]['email'].toString(),
        'city': custdata[0]['city'],
        'society': custdata[0]['location'],
        'prize': custdata[0]['prize'],
        'quantity': custdata[0]['quantity'],
        'address': custdata[0]['address'],
        'pincode': custdata[0]['pincode'],
        'transactionid': custdata[0]['transactionid'],
        'fetchorder': '1',
        'btntype': custdata[0]['btntype'],
        'selecteddate': custdata[0]['selecteddate'].toString(),
        'subscriptiontype': custdata[0]['subscriptiontype'].toString(),
        'subscriptionpaymenttype':
            custdata[0]['subscriptionpaymenttype'].toString(),
        'prepaidoption': custdata[0]['prepaidoption'].toString(),
        'selectedproductcode': selectedproductcode.toString(),
      }),
    );
    var orders = json.decode(response.body);
    print(orders);
    return orders;
  }

  getdelivery(custid) async {
    List delivery = [];
    String token = tokennew;
    String basicAuth = 'Token ' + token;
    var url = host + "/api/orders/getordersbycust/" + custid.toString();
    var response = await http.get(Uri.parse(url),
        headers: <String, String>{'authorization': basicAuth});
    delivery = json.decode(response.body);
    return delivery;
  }

  fetchsubscriptionbycustomer(custid) async {
    List sub = [];
    String token = tokennew;
    String basicAuth = 'Token ' + token;
    var url = host +
        "/api/subscriptions/fetchsubscriptionbycustomer/" +
        custid.toString();
    var response = await http.get(Uri.parse(url),
        headers: <String, String>{'authorization': basicAuth});
    sub = json.decode(response.body);
    return sub;
  }

  fetchsubscriptionbyid(subid) async {
    List sub = [];
    String token = tokennew;
    String basicAuth = 'Token ' + token;
    var url =
        host + "/api/subscriptions/fetchsubscriptionbyid/" + subid.toString();
    var response = await http.get(Uri.parse(url),
        headers: <String, String>{'authorization': basicAuth});
    sub = json.decode(response.body);
    return sub;
  }

  fetchbuynowbycustomer(custid) async {
    List sub = [];
    String token = tokennew;
    String basicAuth = 'Token ' + token;
    var url = host + "/api/orders/fetchbuynowbycustomer/" + custid.toString();
    var response = await http.get(Uri.parse(url),
        headers: <String, String>{'authorization': basicAuth});
    sub = json.decode(response.body);
    return sub;
  }

  fetchstaffdelivery(custid) async {
    print(custid);
    List sub = [];
    String token = tokennew;
    String basicAuth = 'Token ' + token;
    var url = host + "/api/orders/deliveryguyorders/" + custid.toString();
    var response = await http.get(Uri.parse(url),
        headers: <String, String>{'authorization': basicAuth});
    sub = json.decode(response.body);
    return sub;
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

  insertholiday(holidaydata) async {
    String token = tokennew;
    String basicAuth = 'Token ' + token;
    var url = host + "/api/myholidays/insertholidays/";
    await http.post(
      Uri.parse(url),
      headers: <String, String>{'authorization': basicAuth},
      body: jsonEncode(<String, String>{
        'custid': holidaydata[0]['custid'].toString(),
        'startdate': holidaydata[0]['startdate'].toString(),
        'enddate': holidaydata[0]['enddate'].toString()
      }),
    );
    return holidaydata;
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

  stafflogin({mobile, password}) async {
    List staffs = [];
    String token = tokennew;
    String basicAuth = 'Token ' + token;
    var url = host + "/api/staffpersons/checklogin/";
    var response = await http.post(
      Uri.parse(url),
      headers: <String, String>{'authorization': basicAuth},
      body: jsonEncode(<String, String>{
        'password': password,
        'mobile': mobile,
      }),
    );
    staffs = json.decode(response.body);
    if (staffs.length > 0) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('isstaffLogin', '1');
      prefs.setString('staffmobile', staffs[0]['mobile']);
      prefs.setString('staffname', staffs[0]['name']);
    }
    return staffs;
  }

  getLoggedinstaffdata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var isstaffLogin = prefs.getString('isstaffLogin');
    var staffmob = prefs.getString('staffmobile');

    if (isstaffLogin == '1' && staffmob != "") {
      String token = tokennew;
      String basicAuth = 'Token ' + token;
      var url = host + "/api/staffpersons/checkregister/" + staffmob.toString();
      var response = await http.get(Uri.parse(url),
          headers: <String, String>{'authorization': basicAuth});
      var staff = json.decode(response.body);

      if (staff.length > 0) {
        return staff;
      } else {
        return [];
      }
    } else {
      return [];
    }
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
