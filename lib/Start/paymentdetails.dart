import 'package:flutter/material.dart';

class Paymentdetails extends StatelessWidget {
  const Paymentdetails({super.key});
  static const paymentdtl = 'paymentdtl';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/start/p1.jpg',
              width: 500,
              height: 500,
              fit: BoxFit.contain,
            ),
            const Text(
              'Easy Payment',
              style: TextStyle(
                color: Colors.lightGreen,
                fontSize: 35,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              'Experience smooth and secure transactions',
              style: TextStyle(
                color: Colors.lightGreen,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              'with multiple payment options. ',
              style: TextStyle(
                color: Colors.lightGreen,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              'Say goodbye to payment hassles and focus on enjoying your meal.',
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
