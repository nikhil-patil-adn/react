import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'product_detail.dart';

class ProductList extends StatefulWidget {
  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  List products = [];
  List myController = [];
  final int qtyval = 0;

  void initState() {
    super.initState();
    fetchProductlist();
    // qtyController.text = qtyval.toString();
  }

  fetchProductlist() async {
    var url = "http://192.168.2.107:8000/api/products/fetch_products/";
    var response = await http.get(Uri.parse(url));
    var product = json.decode(response.body);
    for (var i = 0; i < product.length; i++) {
      myController.add(TextEditingController());
      setState(() {
        myController[i].text = '0';
      });
    }
    setState(() {
      products = product;
    });
  }

  Widget qtyTextField(int index) {
    return Container(
      child: Row(
        children: [
          SizedBox(
            height: 40,
            width: 50,
            child: TextButton(
              onPressed: () {
                setState(() {
                  var qtyController = myController[index];
                  int qty = int.parse(qtyController.text);
                  qty--;
                  qtyController.text = qty.toString();
                });
              },
              child: Text("-",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.black,
                  )),
            ),
          ),
          SizedBox(
            height: 40,
            width: 80,
            child: TextField(
              controller: myController[index],
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(left: 35.0),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0))),
            ),
          ),
          SizedBox(
            child: TextButton(
              onPressed: () {
                setState(() {
                  int qty = int.parse(myController[index].text);
                  qty++;
                  myController[index].text = qty.toString();
                });
              },
              child: Text("+",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.black,
                  )),
            ),
          )
        ],
      ),
    );
  }

  Widget buildText(String text, int index) {
    final styleButton =
        TextStyle(fontSize: 20, color: Colors.red, fontWeight: FontWeight.bold);

    return Container(
      height: 200,
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: ReadMoreText(
                text,
                trimMode: TrimMode.Length,
                trimLength: 60,
                trimCollapsedText: 'Read more',
                trimExpandedText: 'Read less',
                style: TextStyle(
                  fontSize: 20,
                ),
                lessStyle: styleButton,
                moreStyle: styleButton,
              ),
            ),
          ),
          Center(
            child: Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.6,
                  height: 50,
                  // decoration: BoxDecoration(
                  //   border: Border.all(),
                  // ),
                  child: Center(child: qtyTextField(index)),
                ),
              ],
            ),
          ),
          Container(
              width: MediaQuery.of(context).size.width * 0.5,
              //decoration: BoxDecoration(
              // border: Border.all(),
              // ),
              child:
                  ElevatedButton(onPressed: () {}, child: Text("Add to Cart")))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product List"),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.home),
            title: new Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.mail),
            title: new Text('Messages'),
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.person), title: Text('Profile'))
        ],
      ),
      body: ListView.builder(
          itemCount: products.length,
          itemBuilder: (context, index) {
            final items = products[index];
            return ListTile(
                title: Text(
                  items['name'],
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                subtitle: buildText(items['desciption'], index),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProductDetail(
                              code: items['code'],
                              quantity: myController[index].text)));
                },
                leading: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProductDetail(
                                code: items['code'],
                                quantity: myController[index].text)));
                  },
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minWidth: 100,
                      minHeight: 100,
                      maxWidth: 100,
                      maxHeight: 100,
                    ),
                    child: Image.network(items['image_url'], fit: BoxFit.fill),
                  ),
                ));
          }),
    );
  }
}
