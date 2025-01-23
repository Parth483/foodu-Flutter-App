import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Editpassword extends StatefulWidget {
  const Editpassword({super.key});
  static const editpassword = 'editpassword';

  @override
  State<Editpassword> createState() => _EditpasswordState();
}

class _EditpasswordState extends State<Editpassword> {
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  final TextEditingController _passwordcontroller = TextEditingController();
  final TextEditingController _confirmpasswordcontroller =
      TextEditingController();

  bool isvisible = false;
  bool isviible2 = false;

  Future<void> _getdata() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _passwordcontroller.text = prefs.getString('password') ?? '';
      _confirmpasswordcontroller.text = prefs.getString('password') ?? '';
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getdata();
  }

  Future<void> _updatepassword() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('password', _confirmpasswordcontroller.text);

    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Password Updated')));

    Future.delayed(Duration(seconds: 1), () {
      Navigator.of(context).pop(true);
    });

    String? pasword = prefs.getString('password');
    print(pasword);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          titleSpacing: 0,
          // title: Text('Edit Password'),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Form(
              key: _form,
              child: Column(
                children: [
                  Container(
                      padding: EdgeInsets.only(left: 20, right: 20, top: 60),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Reset Your Password',
                            style: TextStyle(
                                fontSize: 35,
                                fontWeight: FontWeight.bold,
                                color: Colors.green),
                          ),
                          SizedBox(
                            height: 60,
                          ),
                          Container(
                              padding: EdgeInsets.only(left: 10, right: 220),
                              child: Text('Enter Password')),
                          TextFormField(
                            obscureText: isvisible,
                            controller: _passwordcontroller,
                            decoration: InputDecoration(
                              prefixIcon: Padding(
                                padding: EdgeInsets.all(8),
                                child: Icon(Icons.password_outlined),
                              ),
                              filled: true,
                              fillColor: Color.fromARGB(26, 185, 178, 178),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide.none),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    isvisible = !isvisible;
                                  });
                                },
                                icon: isvisible
                                    ? Icon(Icons.visibility_off)
                                    : Icon(Icons.visibility),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please Enter Password';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                              padding: EdgeInsets.only(left: 10, right: 210),
                              child: Text('Re-Enter Password')),
                          TextFormField(
                            obscureText: isviible2,
                            controller: _confirmpasswordcontroller,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.password_outlined),
                              filled: true,
                              fillColor: Color.fromARGB(26, 185, 178, 178),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide.none),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    isviible2 = !isviible2;
                                  });
                                },
                                icon: isviible2
                                    ? Icon(Icons.visibility_off)
                                    : Icon(Icons.visibility),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please Re-Enter Password';
                              }
                              if (value != _passwordcontroller.text) {
                                return 'Password does not match';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          OutlinedButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  WidgetStateProperty.all(Colors.green),
                              minimumSize: WidgetStateProperty.all(
                                Size(310, 50),
                              ),
                              shape: WidgetStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              side: WidgetStatePropertyAll(
                                BorderSide(
                                  color: Color.fromARGB(255, 207, 205, 205),
                                ),
                              ),
                            ),
                            onPressed: () {
                              if (_form.currentState?.validate() ?? false) {
                                print('Password:${_passwordcontroller.text}');
                                print(
                                    'Password:${_confirmpasswordcontroller.text}');
                                _updatepassword();
                              }
                            },
                            child: Text(
                              'Update Password',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            ),
                          )
                        ],
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
