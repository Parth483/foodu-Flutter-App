import 'package:flutter/material.dart';
import 'package:foodu/Start/deliverydetails.dart';
import 'package:foodu/Start/fooddetails.dart';
import 'package:foodu/Start/paymentdetails.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Bottomnav extends StatefulWidget {
  const Bottomnav({super.key});
  static const bottomnav = 'bottomnav';

  @override
  State<Bottomnav> createState() => _BottomnavState();
}

class _BottomnavState extends State<Bottomnav> {
  final _controller = PageController();
  int _currentpage = 0;

  Future<void> _savefirsttimelog() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setBool('saveFirst', true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(children: [
        Expanded(
          child: PageView(
            scrollDirection: Axis.horizontal,
            controller: _controller,
            onPageChanged: (index) {
              setState(() {
                _currentpage = index;
              });
            },
            children: [Fooddetails(), Paymentdetails(), Deliverydetails()],
          ),
        ),
        SmoothPageIndicator(
          controller: _controller,
          count: 3,
          effect: ExpandingDotsEffect(
            activeDotColor: Colors.lightGreenAccent,
            dotColor: const Color.fromARGB(77, 66, 65, 65),
            dotHeight: 10,
            dotWidth: 10,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        ElevatedButton(
          onPressed: () {
            if (_currentpage < 2) {
              _controller.nextPage(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut);
            } else {
              Navigator.pushReplacementNamed(context, 'first');
              _savefirsttimelog();
            }
          },
          style: ElevatedButton.styleFrom(
            minimumSize: Size(300, 50),
          ),
          child: Text(
            _currentpage < 2 ? 'Next' : 'Get Started!',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 20,
        )
      ]),
    );
  }
}
