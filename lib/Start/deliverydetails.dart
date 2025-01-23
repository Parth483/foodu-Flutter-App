import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Deliverydetails extends StatefulWidget {
  const Deliverydetails({super.key});
  static const delivery = 'delivery';

  @override
  State<Deliverydetails> createState() => _DeliverydetailsState();
}

class _DeliverydetailsState extends State<Deliverydetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/start/d1.jpg',
              width: 500,
              height: 500,
              fit: BoxFit.contain,
            ),
            const Text(
              'Fast Delivery',
              style: TextStyle(
                color: Colors.lightGreen,
                fontSize: 35,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              'We value your time.',
              style: TextStyle(
                color: Colors.lightGreen,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              'Count on us to deliver your food hot and fresh',
              style: TextStyle(
                color: Colors.lightGreen,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              ', straight to your door, faster than ever.',
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
