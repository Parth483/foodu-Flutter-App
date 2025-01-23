import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class Otp extends StatefulWidget {
  const Otp({super.key});
  static const otp = 'otp';

  @override
  State<Otp> createState() => _OtpState();
}

class _OtpState extends State<Otp> {
//popup
  // final GlobalKey<FormState> _form = GlobalKey<FormState>();
  late String validPin;
  late TextEditingController _popcontroller;

//validate
  final TextEditingController _pinput = TextEditingController();
  final GlobalKey<FormState> _form = GlobalKey<FormState>();

//timer
  late Timer _timer;
  int _remainingTime = 30;

//generate random pin
  String _generateRandomPin() {
    final random = Random();
    return (1000 + random.nextInt(9000)).toString();
  }

  void _startTimer() {
    _remainingTime = 30;
    validPin = _generateRandomPin();
    _popcontroller.text = validPin;

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_remainingTime > 0) {
        setState(() {
          _remainingTime--;
        });
      } else {
        setState(() {
          _remainingTime = 0;

          validPin = '';
          _popcontroller.clear();
          _pinput.clear();
        });
        timer.cancel();
      }
    });
  }

  bool isloading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    validPin = _generateRandomPin();
    _popcontroller = TextEditingController(text: validPin);

    _startTimer();
    Future.delayed(Duration.zero, () {
      openDialog();
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    if (_timer.isActive) {
      _timer.cancel();
    }
    _popcontroller.dispose();
    _pinput.dispose();
  }

  Future openDialog() async {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Center(child: Text('OTP')),
              content: SizedBox(
                height: 150,
                child: Form(
                  child: Column(
                    children: [
                      Pinput(
                        controller: _popcontroller,
                        enabled: false,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: SizedBox(
                              height: 50,
                              child: OutlinedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          WidgetStateProperty.all(Colors.green),
                                      shape: WidgetStateProperty.all(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(11),
                                        ),
                                      ),
                                      side: WidgetStateProperty.all(
                                          BorderSide.none)),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    'Cancel',
                                    style: TextStyle(color: Colors.white),
                                  )),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: SizedBox(
                              height: 50,
                              child: OutlinedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          WidgetStateProperty.all(Colors.green),
                                      shape: WidgetStateProperty.all(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(11),
                                        ),
                                      ),
                                      side: WidgetStateProperty.all(
                                          BorderSide.none)),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    'Ok',
                                    style: TextStyle(color: Colors.white),
                                  )),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('OTP Code Verification'),
        titleSpacing: 2,
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Form(
          key: _form,
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 50),
                child: Text('Code has been send to +9723321270'),
              ),
              SizedBox(
                height: 30,
              ),
              Center(
                child: Pinput(
                  controller: _pinput,
                  validator: (value) {
                    if (_remainingTime == 0) {
                      return 'OTP has expired.Please resend the code';
                    }
                    if (value == null || value.isEmpty) {
                      return 'Please enter OTP';
                    } else if (value != validPin) {
                      return 'Invalid OTP';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                _remainingTime > 0
                    ? 'Time remaining:$_remainingTime seconds'
                    : 'Time expired,resend code!',
                style: TextStyle(
                  color: _remainingTime > 0 ? Colors.black : Colors.red,
                ),
              ),
              TextButton(
                onPressed: _remainingTime == 0
                    ? () {
                        _startTimer();
                        openDialog();
                      }
                    : null,
                child: Text('Send Code'),
              ),
              SizedBox(
                height: 30,
              ),
              isloading
                  ? CircularProgressIndicator()
                  : OutlinedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              WidgetStateProperty.all(Colors.green),
                          minimumSize: WidgetStatePropertyAll(Size(310, 50)),
                          shape: WidgetStatePropertyAll(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          side: WidgetStatePropertyAll(
                              BorderSide(color: Colors.green))),
                      onPressed: () {
                        if (_remainingTime == 0) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content:
                                Text('OTP has expired.Please resend the code.'),
                          ));
                          return;
                        }

                        if (_pinput.length == 4) {
                          if (_form.currentState?.validate() ?? false) {
                            if (_pinput.text == (_popcontroller.text)) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar((SnackBar(
                                content: Text('Valid OTP'),
                              )));
                              isloading = true;
                              Future.delayed(Duration(seconds: 3), () {
                                Navigator.pushReplacementNamed(
                                    context, 'hompage');
                              });
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text('Invalid OTP'),
                              ));
                            }
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar((SnackBar(
                            content: Text('Pls Enter digits'),
                          )));
                        }
                      },
                      child: Text(
                        'Verify',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
