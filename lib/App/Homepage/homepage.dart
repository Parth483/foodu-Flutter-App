import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodu/App/Homepage/subfolders/favourite.dart';
import 'package:foodu/App/Homepage/subfolders/home.dart';
import 'package:foodu/App/Homepage/subfolders/order.dart';
import 'package:foodu/App/Homepage/subfolders/profile.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});
  static const homepage = 'hompage';

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  String? imagepath;
  XFile? _imagefile;

  Future<void> getdata() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      imagepath = prefs.getString('image');
      if (imagepath != null) {
        _imagefile = XFile(imagepath!);
      }
    });
  }

  Future<void> clearPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    print('SharedPreferences cleared!');
  }

  @override
  void initState() {
    super.initState();
    // clearPreferences();

    getdata();
    // widgetlist.add(Home());
  }

  int myindex = 0;

  Future<void> changeToOrder() async {
    setState(() {
      myindex = 1;
    });
  }

  Future<bool> _onWillPop() async {
    if (myindex != 0) {
      setState(() {
        myindex = 0;
      });
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetlist = [
      Home(
        imagefile: _imagefile,
      ),
      const Order(),
      Favourite(),
      Profile(changeToOrder: changeToOrder)
    ];

    return WillPopScope(
      onWillPop: _onWillPop,
      // canPop: myindex == 0,

      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: IndexedStack(
          index: myindex,
          children: widgetlist,
        ),
        bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            onTap: (index) {
              setState(() {
                myindex = index;
              });

              if (index == 0) {
                getdata();
              }
            },
            currentIndex: myindex,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.library_books_outlined), label: 'Order'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.heart_broken_rounded), label: 'Favourite'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), label: 'Profile'),
            ]),
      ),
    );
  }
}
