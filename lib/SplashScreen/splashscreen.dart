import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
//import 'package:foodu/App/Orders/OrderPage/orderdetailes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});
  static const splashscreen = 'splashscreen';

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  bool? _isfirsttimeopen;
  bool? _isloggedin;

  Future<void> _checkopenstatus() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    _isfirsttimeopen = prefs.getBool('saveFirst') ?? true;
    _isloggedin = prefs.getBool('isLoggedIn') ?? false;
  }

  @override
  void initState() {
    super.initState();
    _navigatoraftersplash();
  }

  Future<void> _navigatoraftersplash() async {
    await _checkopenstatus();
    await Future.delayed(const Duration(seconds: 4));

    if (mounted) {
      if (_isfirsttimeopen == true) {
        Navigator.pushNamedAndRemoveUntil(context, 'first', (route) => false);
        await _setFirstTimeOpen(false);
        return;
      }
      if (_isloggedin == true) {
        Navigator.pushNamedAndRemoveUntil(context, 'otp', (route) => false);
        return;
      }
      Navigator.pushNamedAndRemoveUntil(context, 'welcome', (route) => false);
    }
  }

  Future<void> _setFirstTimeOpen(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('saveFirst', value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.only(
                  top: 170,
                ),
                child: Image.asset(
                  'assets/logo/logo6.png',
                  height: 150,
                  width: 150,
                ),
              ),
              Text(
                'Foodu',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Roboto'),
              ),
              SizedBox(
                height: 100,
              ),
              SpinKitFadingCircle(
                color: Colors.green,
                size: 50.0,
              )
            ]),
      ),
    );
  }
}
