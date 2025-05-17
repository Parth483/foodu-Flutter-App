import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foodu/getstart/first.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  static const login = 'login';

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _isChecked = false;
  bool isvisible = false;
  final TextEditingController _numbercontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  final GlobalKey<FormState> _form = GlobalKey<FormState>();

  bool _isloading = false;

  void _loading() async {
    setState(() {
      _isloading = true;
    });
  }

  Future<void> _checkLogin(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? savedNumber = prefs.getString('phonenumber');
    String? savedPassword = prefs.getString('password');

    if (savedNumber == _numbercontroller.text &&
        savedPassword == _passwordcontroller.text) {
      _loading();
      Future.delayed(Duration(seconds: 3), () {
        Navigator.pushNamedAndRemoveUntil(context, 'hompage', (route) => false);
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Invalid PhoneNumber Or Password')),
      );
    }
  }

  Future<void> _saveloginprefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 10, top: 30, right: 300),
                  child: IconButton(
                      onPressed: () {
                        Navigator.pop(context,
                            MaterialPageRoute(builder: (context) => First()));
                      },
                      icon: Icon(Icons.arrow_back)),
                ),
                SizedBox(
                  height: 50,
                ),
                Image.asset(
                  'assets/logo/logo6.png',
                  height: 120,
                  width: 120,
                ),
                const Text(
                  'Login To Your Account',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 40,
                ),
                Form(
                    key: _form,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            controller: _numbercontroller,
                            decoration: InputDecoration(
                                prefixIcon: Padding(
                                    padding: EdgeInsets.all(8),
                                    child: Icon(Icons.contacts_rounded)),
                                hintText: '000 000 0000',
                                filled: true,
                                fillColor:
                                    const Color.fromARGB(26, 185, 178, 178),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(13),
                                    borderSide: BorderSide.none)),
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(10),
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please Enter Number';
                              }
                              if (!RegExp(r'^\d+$').hasMatch(value)) {
                                return 'Please enter a valid contact number (only digits allowed)';
                              }
                              if (value.length != 10) {
                                return 'Please enter a 10-digit contact number';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          child: TextFormField(
                            obscureText: isvisible,
                            controller: _passwordcontroller,
                            decoration: InputDecoration(
                                prefixIcon: Padding(
                                    padding: EdgeInsets.all(8),
                                    child: Icon(Icons.password_outlined)),
                                hintText: 'Please Enter Password',
                                filled: true,
                                fillColor:
                                    const Color.fromARGB(26, 185, 178, 178),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(13),
                                    borderSide: BorderSide.none),
                                suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        isvisible = !isvisible;
                                      });
                                    },
                                    icon: isvisible
                                        ? Icon(Icons.visibility_off)
                                        : Icon(Icons.visibility))),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please Enter Password';
                              }

                              return null;
                            },
                          ),
                        ),
                        Container(
                          margin:
                              EdgeInsets.only(right: 220, top: 20, bottom: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Checkbox(
                                value: _isChecked,
                                onChanged: (bool? value) {
                                  setState(() {
                                    _isChecked = value ?? false;
                                  });
                                },
                                checkColor: Colors.white,
                                activeColor: Colors.blue,
                                side: BorderSide(color: Colors.green),
                              ),
                              Text('Remember Me'),
                              SizedBox(
                                height: 40,
                              ),
                            ],
                          ),
                        ),
                        _isloading
                            ? CircularProgressIndicator()
                            : OutlinedButton(
                                onPressed: () async {
                                  if (_form.currentState?.validate() ?? false) {
                                    print(
                                        'PhoneNumber: ${_numbercontroller.text}}');
                                    if (_isChecked) {
                                      _saveloginprefs();
                                    }
                                    await _checkLogin(context);
                                  }
                                },
                                style: ButtonStyle(
                                  backgroundColor:
                                      WidgetStateProperty.all(Colors.green),
                                  minimumSize:
                                      WidgetStateProperty.all(Size(310, 50)),
                                  shape: WidgetStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                  ),
                                  side: const WidgetStatePropertyAll(
                                    BorderSide(
                                      color: const Color.fromARGB(
                                          255, 207, 205, 205),
                                    ),
                                  ),
                                ),
                                child: const Text(
                                  'Sign in',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                        const SizedBox(
                          height: 40,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 50,
                              height: 1,
                              color: Colors.grey,
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Text('or continue with'),
                            ),
                            Container(
                              width: 50,
                              height: 1,
                              color: Colors.grey,
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            OutlinedButton(
                                onPressed: () {},
                                style: ButtonStyle(
                                    minimumSize: const WidgetStatePropertyAll(
                                        Size(50, 50)),
                                    shape: WidgetStatePropertyAll(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15))),
                                    side: const WidgetStatePropertyAll(
                                        BorderSide(
                                            color: const Color.fromARGB(
                                                255, 219, 219, 219),
                                            width: 1))),
                                child: SvgPicture.asset(
                                  'assets/svg/facebook.svg',
                                  height: 30,
                                  width: 30,
                                )),
                            const SizedBox(
                              width: 15,
                            ),
                            OutlinedButton(
                                onPressed: () {},
                                style: ButtonStyle(
                                  minimumSize: const WidgetStatePropertyAll(
                                      Size(50, 50)),
                                  shape: WidgetStatePropertyAll(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15))),
                                  side: const WidgetStatePropertyAll(BorderSide(
                                      color: const Color.fromARGB(
                                          255, 219, 219, 219),
                                      width: 1)),
                                ),
                                child: SvgPicture.asset('assets/svg/google.svg',
                                    height: 30, width: 30)),
                            const SizedBox(
                              width: 15,
                            ),
                            OutlinedButton(
                                onPressed: () {},
                                style: ButtonStyle(
                                    minimumSize: const WidgetStatePropertyAll(
                                        Size(50, 50)),
                                    shape: WidgetStatePropertyAll(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15))),
                                    side: const WidgetStatePropertyAll(
                                        BorderSide(
                                            color: const Color.fromARGB(
                                                255, 219, 219, 219),
                                            width: 1))),
                                child: SvgPicture.asset('assets/svg/apple.svg',
                                    height: 30, width: 30)),
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Dont have an account?',
                                style: TextStyle(
                                    color: const Color.fromARGB(
                                        59, 126, 124, 124))),
                            TextButton(
                              onPressed: () {
                                Navigator.pushReplacementNamed(
                                    context, 'signup');
                              },
                              child: const Text('Sign up',
                                  style: TextStyle(color: Colors.green)),
                            )
                          ],
                        )
                      ],
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
