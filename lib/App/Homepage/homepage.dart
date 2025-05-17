import 'package:flutter/material.dart';
import 'package:foodu/App/Homepage/subfolders/favourite.dart';
import 'package:foodu/App/Homepage/subfolders/home.dart';
import 'package:foodu/App/Homepage/subfolders/order.dart';
import 'package:foodu/App/Homepage/subfolders/profile.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:image_picker/image_picker.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});
  static const homepage = 'hompage';

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int myindex = 0;
  bool hasDataLoaded = false;
  var currentPage = 0;
  var pageOptions = <Widget>[];

  @override
  void initState() {
    setState(() {
      pageOptions = [
        Home(),
        const Order(),
        Favourite(),
        Profile(changeToOrder: changeToOrder),
      ];
    });
    super.initState();
  }

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
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: Center(
          child: pageOptions.elementAt(currentPage),
        ),
        resizeToAvoidBottomInset: false,
        extendBody: true,
        bottomNavigationBar: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  blurRadius: 10,
                  color: Colors.black.withOpacity(.1),
                )
              ],
            ),
            child: GNav(
              rippleColor: Colors.grey[300]!,
              hoverColor: Colors.grey[100]!,
              gap: 5,
              curve: Curves.bounceInOut,
              activeColor: Colors.white,
              iconSize: 24,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              duration: const Duration(milliseconds: 400),
              tabBorderRadius: 15,
              tabBackgroundColor: Colors.green,
              color: Colors.black,
              tabs: [
                GButton(
                  icon: Icons.home_rounded,
                  text: "",
                  iconColor: Colors.green,
                ),
                GButton(
                  icon: Icons.book_rounded,
                  text: "",
                  iconColor: Colors.green,
                ),
                GButton(
                  icon: Icons.favorite,
                  text: "",
                  iconColor: Colors.green,
                ),
                GButton(
                  icon: Icons.person_rounded,
                  text: "",
                  iconColor: Colors.green,
                ),
              ],
              selectedIndex: currentPage,
              onTabChange: (index) {
                setState(() {
                  changeIndex(index);
                });
              },
            ),
          ),
        ),
      ),
    );
  }

  void changeIndex(int index) async {
    if (index == 1) {
      setState(() {
        currentPage = index;
      });
    } else {
      setState(() {
        currentPage = index;
      });
    }
  }
}
