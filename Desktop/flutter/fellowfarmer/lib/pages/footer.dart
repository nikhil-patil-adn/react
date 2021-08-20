import 'package:fellowfarmer/main.dart';
import 'package:fellowfarmer/pages/product_list.dart';
import 'package:flutter/material.dart';

class FooterPage extends StatefulWidget {
  final int pageindex;
  FooterPage({required this.pageindex});

  @override
  _FooterPageState createState() => _FooterPageState();
}

class _FooterPageState extends State<FooterPage> {
  int _selectedIndex = 0;
  @override
  void initState() {
    super.initState();
    setState(() {
      _selectedIndex = widget.pageindex;
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    print("index");
    print(index);
    if (index == 0) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MyHomePage(title: 'FellowFarmer')));
    } else if (index == 1) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => ProductList()));
    }
  }

  Widget footer() {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
          backgroundColor: Colors.red,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.business),
          label: 'Business',
          backgroundColor: Colors.green,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.school),
          label: 'School',
          backgroundColor: Colors.purple,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Settings',
          backgroundColor: Colors.pink,
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.amber[800],
      onTap: _onItemTapped,
    );
  }

  @override
  Widget build(BuildContext context) {
    return footer();
  }
}
