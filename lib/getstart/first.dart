import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class First extends StatefulWidget {
  const First({super.key});
  static const first = 'first';

  @override
  State<First> createState() => _FirstState();
}

class _FirstState extends State<First> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/getstart/g1.png',
              height: 200,
              width: 200,
            ),
            Text(
              'Lets you in',
              style: TextStyle(fontSize: 30),
            ),
            SizedBox(
              height: 20,
            ),
            OutlinedButton(
              onPressed: () {},
              style: ButtonStyle(
                minimumSize: WidgetStateProperty.all(Size(300, 50)),
                shape: WidgetStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                side: WidgetStatePropertyAll(
                  BorderSide(
                    color: const Color.fromARGB(255, 207, 205, 205),
                  ),
                ),
              ),
              child: SizedBox(
                width: 200,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/svg/facebook.svg',
                      height: 30,
                      width: 30,
                    ),
                    Text(
                      ' Continue with Facebook',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w200,
                          fontSize: 15),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            OutlinedButton(
              onPressed: () {},
              style: ButtonStyle(
                minimumSize: WidgetStateProperty.all(Size(300, 50)),
                shape: WidgetStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                side: WidgetStatePropertyAll(
                  BorderSide(
                    color: const Color.fromARGB(255, 207, 205, 205),
                  ),
                ),
              ),
              child: SizedBox(
                width: 200,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/svg/google.svg',
                      height: 30,
                      width: 30,
                    ),
                    Text(
                      ' Continue with Google',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w200,
                          fontSize: 15),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            OutlinedButton(
              onPressed: () {},
              style: ButtonStyle(
                minimumSize: WidgetStateProperty.all(Size(300, 50)),
                shape: WidgetStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                side: WidgetStatePropertyAll(
                  BorderSide(
                    color: const Color.fromARGB(255, 207, 205, 205),
                  ),
                ),
              ),
              child: SizedBox(
                width: 200,
                child: Row(
                  children: [
                    SizedBox(
                      width: 25,
                    ),
                    SvgPicture.asset(
                      'assets/svg/apple.svg',
                      height: 30,
                      width: 30,
                    ),
                    Text(
                      ' Continue with Apple',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w200,
                          fontSize: 15),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 135,
                  height: 1,
                  color: Colors.grey,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text('Or'),
                ),
                Container(
                  width: 135,
                  height: 1,
                  color: Colors.grey,
                )
              ],
            ),
            SizedBox(
              height: 40,
            ),
            OutlinedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, 'login');
              },
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(Colors.green),
                minimumSize: WidgetStateProperty.all(Size(300, 50)),
                shape: WidgetStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                side: WidgetStatePropertyAll(
                  BorderSide(
                    color: const Color.fromARGB(255, 207, 205, 205),
                  ),
                ),
              ),
              child: Text(
                'Signin with Phone Number',
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Dont have an account?',
                  style:
                      TextStyle(color: const Color.fromARGB(59, 126, 124, 124)),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, 'signup');
                  },
                  child: Text(
                    'Sign up',
                    style: TextStyle(color: Colors.green),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
