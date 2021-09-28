import 'package:fellowfarmer/api/api.dart';
import 'package:fellowfarmer/pages/footer.dart';
import 'package:fellowfarmer/pages/home_loader.dart';
import 'package:fellowfarmer/pages/myaccount_page.dart';
import 'package:fellowfarmer/widgets/customwidget.dart';
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
      setState(() {
        products = val;
      });

      if (val.length > 0) {
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

  Widget buildText(String text, int index, int code, String amt) {
    final styleButton = TextStyle(
        fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold);

    return Container(
      height: 120,
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: ReadMoreText(
                text,
                trimMode: TrimMode.Length,
                trimLength: 40,
                trimCollapsedText: 'Read more',
                trimExpandedText: 'Read less',
                style: TextStyle(fontSize: 14, color: Colors.black),
                lessStyle: styleButton,
                moreStyle: styleButton,
              ),
            ),
          ),
          // Container(
          //   padding: const EdgeInsets.all(10),
          //   child: Row(
          //     children: [
          //       Container(
          //         width: MediaQuery.of(context).size.width * 0.1,
          //         child: Text("Price:"),
          //       ),
          //       Container(
          //         width: MediaQuery.of(context).size.width * 0.1,
          //         child: Text(amt),
          //       )
          //     ],
          //   ),
          // ),
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
              width: MediaQuery.of(context).size.width * 0.4,
              margin: const EdgeInsets.only(right: 60),
              height: 30,
              // decoration: BoxDecoration(
              //     gradient: LinearGradient(
              //         begin: Alignment.topLeft,
              //         end: Alignment.bottomRight,
              //         colors: [Color(0xFFcea335), Color(0xFFed1c22)])),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        side: BorderSide(color: Color(0xFF4a1821))),
                    // primary: Colors.transparent,
                    primary: const Color(0xFF4a1821), // background
                    onPrimary: Colors.white, // foreground
                  ),
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
        scrollDirection: Axis.vertical,
        itemCount: products.length,
        itemBuilder: (context, index) {
          final items = products[index];
          return Container(
            margin: EdgeInsets.symmetric(vertical: 0.2),
            padding: EdgeInsets.only(bottom: 2.0),
            decoration: BoxDecoration(
                // gradient: LinearGradient(
                //     begin: Alignment.topLeft,
                //     end: Alignment.bottomRight,
                //     colors: [Color(0xFFcea335), Color(0xFFed1c22)]),
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(color: Color(0xFF4a1821), spreadRadius: 1),
                ],
                border: Border.all(color: Colors.white)
                // border: Border(

                //   bottom: BorderSide(width: 5.0, color: Colors.grey.shade200),
                // ),
                ),
            child: ListTile(
                title: Text(
                  items['name'].toUpperCase(),
                  style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                subtitle: buildText(
                    items['desciption'], index, items['code'], items['price']),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProductDetail(
                              code: items['code'],
                              quantity: myController[index].text)));
                },
                leading: CircleAvatar(
                  radius: 50,
                  child: InkWell(
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
                      child:
                          Image.network(items['image_url'], fit: BoxFit.fill),
                    ),
                  ),
                )),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF4a1821),
      appBar: AppBar(
        flexibleSpace: lineargradientbg(),
        // iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          "Product List",
          //  style: TextStyle(color: Colors.white),
        ),
      ),
      bottomNavigationBar: FooterPage(pageindex: 1),
      endDrawer: MyaccountPage(),
      body: products.length > 0 ? _displaylist() : HomeLoader(),
    );
  }
}
