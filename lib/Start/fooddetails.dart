import 'package:flutter/material.dart';

class Fooddetails extends StatelessWidget {
  const Fooddetails({super.key});
  static const fooddtl = 'fooddtl';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/start/f1.jpg',
              width: 500,
              height: 500,
              fit: BoxFit.contain,
            ),
            Text(
              'Order for Food',
              style: TextStyle(
                color: Colors.lightGreen,
                fontSize: 35,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Explore an extensive menu of cuisines,',
              style: TextStyle(
                color: Colors.lightGreen,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              ' Place your order in seconds and ',
              style: TextStyle(
                color: Colors.lightGreen,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'enjoy the convenience of dining your way',
              style: TextStyle(
                color: Colors.lightGreen,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
