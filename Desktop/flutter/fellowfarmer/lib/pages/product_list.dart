import 'package:fellowfarmer/api/api.dart';
import 'package:fellowfarmer/pages/home_loader.dart';
import 'package:fellowfarmer/pages/myaccount_page.dart';
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

  fetchProductlist() {
    var obj = new Api();
    obj.fetchProductList().then((val) {
      print(val);
      print("val");
      setState(() {
        products = val;
      });

      if (val.length > 0) {
        print("inside product");
        for (var i = 0; i < val.length; i++) {
          myController.add(TextEditingController());
          setState(() {
            myController[i].text = '0';
          });
        }
      }
    });
    print(products);
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

  Widget buildText(String text, int index, int code) {
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
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProductDetail(
                                code: code,
                                quantity: myController[index].text)));
                  },
                  child: Text("Add to Cart")))
        ],
      ),
    );
  }

  Widget _displaylist() {
    return ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final items = products[index];
          return ListTile(
              title: Text(
                items['name'],
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              subtitle: buildText(items['desciption'], index, items['code']),
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
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product List"),
      ),
      endDrawer: MyaccountPage(),
      // bottomNavigationBar: BottomNavigationBar(
      //   items: [
      //     BottomNavigationBarItem(
      //       icon: new Icon(Icons.home),
      //       title: new Text('Home'),
      //     ),
      //     BottomNavigationBarItem(
      //       icon: new Icon(Icons.mail),
      //       title: new Text('Messages'),
      //     ),
      //     BottomNavigationBarItem(
      //         icon: Icon(Icons.person), title: Text('Profile'))
      //   ],
      // ),
      body: products.length > 0 ? _displaylist() : HomeLoader(),
    );
  }
}
