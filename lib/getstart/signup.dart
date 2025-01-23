import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodu/getstart/first.dart';
import 'package:image_picker/image_picker.dart';

import 'package:shared_preferences/shared_preferences.dart'; // Add intl package for date formatting

class Signup extends StatefulWidget {
  const Signup({super.key});

  static const signup = 'signup';

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final TextEditingController _numbercontroller = TextEditingController();
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _namecontroller = TextEditingController();
  final TextEditingController _addresscontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  final TextEditingController _confirmpasswordcontroller =
      TextEditingController();
  final TextEditingController _datecontroller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  final GlobalKey<FormState> _form = GlobalKey<FormState>();

  String? groupvalue;
  bool isGenderSelected = false;

  DateTime? selectedDate;

  bool isvisible = false;
  bool isvisible2 = false;

  bool isloading = false;

  void _loading() async {
    setState(() {
      isloading = true;
    });
  }

  Future<void> _pickDate() async {
    DateTime? pickedDate = await showDatePicker(
        context: context, firstDate: DateTime(2000), lastDate: DateTime.now());

    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
      });
    }

    if (pickedDate != null) {
      String formattedDate =
          '${pickedDate.day}-${pickedDate.month}-${pickedDate.year}';
      setState(() {
        _datecontroller.text = formattedDate;
      });
    }
  }

  Future<void> _SaveSharedprefData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', _namecontroller.text);
    await prefs.setString('email', _emailcontroller.text);
    await prefs.setString('phonenumber', _numbercontroller.text);
    await prefs.setString('address', _addresscontroller.text);
    await prefs.setString('date', _datecontroller.text);
    await prefs.setString('gender', groupvalue ?? 'Other');
    await prefs.setString('password', _confirmpasswordcontroller.text);
    await prefs.setString('image', _imageFile != null ? _imageFile!.path : "");
    // await prefs.setBool('isloggedin', true);
    _loading();

    print('savedpref stored');
  }

//for remember me
  bool _isChecked = false;

  final ImagePicker _picker = ImagePicker();
  XFile? _imageFile;

  Future<void> _pickImage({iscamera}) async {
    final XFile? image = await _picker.pickImage(
        source: iscamera == true ? ImageSource.camera : ImageSource.gallery);
    if (image != null) {
      print('Picked Image Path:${image.path}');
      setState(() {
        _imageFile = image;
      });
    } else {
      print('No image selected');
    }
  }

  Future showOptions() async {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        actions: [
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.of(context).pop();

              _pickImage(iscamera: false);
            },
            child: Text('Photo Gallery'),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.of(context).pop();

              _pickImage(iscamera: true);
            },
            child: Text('Camera'),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.of(context).pop();
              setState(() {
                _imageFile = null;
              });
            },
            child: Text('Remove Picture'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          controller: _scrollController,
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
                Image.asset(
                  'assets/logo/logo6.png',
                  height: 120,
                  width: 120,
                ),
                Text(
                  'Create New Account',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20,
                ),
                Form(
                    key: _form,
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: showOptions,
                          child: Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              // border: Border.all(color: Colors.grey,),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: _imageFile == null
                                ? Icon(
                                    Icons.account_circle,
                                    size: 100,
                                  )
                                // ? Container(
                                //     alignment: Alignment.center,
                                //     child: const Column(
                                //       crossAxisAlignment:
                                //           CrossAxisAlignment.center,
                                //       mainAxisAlignment:
                                //           MainAxisAlignment.center,
                                //       children: [
                                //         Icon(
                                //           Icons.image,
                                //           size: 40,
                                //           color: Colors.grey,
                                //         ),
                                //         Text(
                                //           'No image selected.',
                                //           textAlign: TextAlign.center,
                                //         ),
                                //       ],
                                //     ))
                                : ClipOval(
                                    child: Image.file(
                                      File(_imageFile!.path),
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                          ),
                        ),

                        // ClipOval(
                        //   child: Image.file(
                        //     File(_imageFile!.path),
                        //     width: 100,
                        //     height: 100,
                        //     fit: BoxFit.cover,
                        //   ),
                        // ),

                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          child: TextFormField(
                            controller: _namecontroller,
                            decoration: InputDecoration(
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(Icons.person),
                                ),
                                hintText: 'Full Name',
                                filled: true,
                                fillColor:
                                    const Color.fromARGB(26, 185, 178, 178),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(13),
                                    borderSide: BorderSide.none)),
                            // onChanged: (value) {
                            //   setState(() {
                            //      _form.currentState?.validate();
                            //   });
                            // },
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please Enter Name';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0, right: 15),
                          child: TextFormField(
                            controller: _emailcontroller,
                            decoration: InputDecoration(
                                prefixIcon: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(Icons.email)),
                                hintText: 'Email',
                                filled: true,
                                fillColor:
                                    const Color.fromARGB(26, 185, 178, 178),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(13),
                                    borderSide: BorderSide.none)),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please Enter Email';
                              }
                              String pattern =
                                  r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
                              RegExp regex = RegExp(pattern);

                              if (!regex.hasMatch(value)) {
                                return 'Please enter a valid email address';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
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
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
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
                        SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          child: TextFormField(
                            controller: _addresscontroller,
                            decoration: InputDecoration(
                              prefixIcon: Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Icon(Icons.location_on)),
                              hintText: 'Please Enter Your Address',
                              filled: true,
                              fillColor:
                                  const Color.fromARGB(26, 185, 178, 178),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(13),
                                  borderSide: BorderSide.none),
                            ),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please Enter Address';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(
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
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please Enter Password';
                              }

                              return null;
                            },
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          child: TextFormField(
                            obscureText: isvisible2,
                            controller: _confirmpasswordcontroller,
                            decoration: InputDecoration(
                                prefixIcon: Padding(
                                    padding: EdgeInsets.all(8),
                                    child: Icon(Icons.password)),
                                hintText: 'Please Re-Enter Password',
                                filled: true,
                                fillColor:
                                    const Color.fromARGB(26, 185, 178, 178),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(13),
                                    borderSide: BorderSide.none),
                                suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        isvisible2 = !isvisible2;
                                      });
                                    },
                                    icon: isvisible2
                                        ? Icon(Icons.visibility_off)
                                        : Icon(Icons.visibility))),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please Re-Enter Password';
                              }
                              if (value != _passwordcontroller.text) {
                                return 'password does not match';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 15, right: 15),
                          child: TextFormField(
                            controller: _datecontroller,
                            readOnly: true,
                            onTap: _pickDate,
                            decoration: InputDecoration(
                              prefixIcon: Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Icon(Icons.date_range)),
                              hintText: 'Please Select Date',
                              filled: true,
                              fillColor:
                                  const Color.fromARGB(26, 185, 178, 178),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(13),
                                  borderSide: BorderSide.none),
                            ),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please Select Date';
                              }
                              return null;
                            },
                          ),
                        )
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: [
                        //     Container(
                        //       height: 60,
                        //       width: 330,
                        //       padding: EdgeInsets.only(
                        //           left: 25, right: 25, top: 5, bottom: 5),
                        //       decoration: BoxDecoration(
                        //           color: const Color.fromARGB(26, 185, 178, 178),
                        //           borderRadius: BorderRadius.circular(13)),
                        //       child: Row(
                        //         mainAxisAlignment: MainAxisAlignment.start,
                        //         children: [
                        //           Text('DOB:'),
                        //           //    Text(formattedDate),
                        //           // SizedBox(
                        //           //   width: 70,
                        //           // ),
                        //           TextButton(
                        //               onPressed: _pickDate,
                        //               child: Text(
                        //                 formattedDate,
                        //                 style: TextStyle(
                        //                     color: Colors.grey, fontSize: 20),
                        //               ))
                        //         ],
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        ,
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.only(
                                  left: 25, right: 25, top: 5, bottom: 5),
                              decoration: BoxDecoration(
                                //color: const Color.fromARGB(26, 185, 178, 178),
                                borderRadius: BorderRadius.circular(13),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Gender:'),
                                  Radio(
                                    value: 'Male',
                                    groupValue: groupvalue,
                                    onChanged: (value) {
                                      setState(() {
                                        groupvalue = value!;
                                        isGenderSelected = false;
                                        print('$groupvalue');
                                      });
                                    },
                                  ),
                                  Text('Male'),
                                  Radio(
                                    value: 'Female',
                                    groupValue: groupvalue,
                                    onChanged: (value) {
                                      setState(
                                        () {
                                          groupvalue = value!;
                                          isGenderSelected = false;
                                          print('$groupvalue');
                                        },
                                      );
                                    },
                                  ),
                                  Text('Female'),
                                  Radio(
                                      value: 'Other',
                                      groupValue: groupvalue,
                                      onChanged: (value) {
                                        setState(() {
                                          groupvalue = value!;
                                          isGenderSelected = false;
                                          print('$groupvalue');
                                        });
                                      }),
                                  Text('Other')
                                ],
                              ),
                            ),
                          ],
                        ),
                        if (isGenderSelected)
                          Container(
                              padding: EdgeInsets.only(right: 190),
                              child: Text(
                                'Please Select The Gender',
                                style: TextStyle(
                                    fontSize: 12,
                                    color:
                                        const Color.fromARGB(255, 185, 39, 31)),
                              )),
                        Row(
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
                              height: 10,
                            ),
                          ],
                        ),
                        isloading
                            ? CircularProgressIndicator()
                            : OutlinedButton(
                                onPressed: () {
                                  if (_form.currentState?.validate() ?? false) {
                                    if (groupvalue == null) {
                                      setState(() {
                                        isGenderSelected = true;
                                      });

                                      print('please select the gender');
                                    } else {
                                      print('Signup Data:');
                                      print('Name: ${_namecontroller.text}');
                                      print('Email: ${_emailcontroller.text}');
                                      print(
                                          'PhoneNumber: ${_numbercontroller.text}');
                                      print(
                                          'Address:${_addresscontroller.text}');
                                      print('Gender:$groupvalue');
                                      print('DOB:${_datecontroller.text}');
                                      print(
                                          'Password:${_passwordcontroller.text}');
                                      print(
                                          'Confirm Password:${_confirmpasswordcontroller.text}');
                                      if (_isChecked) {
                                        _SaveSharedprefData();
                                      }
                                      Future.delayed(Duration(seconds: 3), () {
                                        Navigator.pushReplacementNamed(
                                            context, 'login');
                                      });
                                    }
                                  } else {
                                    final contextList = [
                                      _namecontroller,
                                      _emailcontroller,
                                      _numbercontroller,
                                      _addresscontroller,
                                      _datecontroller,
                                      _passwordcontroller,
                                      _confirmpasswordcontroller,
                                    ];

                                    // Loop through the controllers and find the first invalid one
                                    for (var controller in contextList) {
                                      if (controller.text.isEmpty) {
                                        _scrollController.animateTo(
                                 
                                 
                                 
                                          200.0, // Adjust this based on your form layout
                                          duration: Duration(milliseconds: 300),
                                          curve: Curves.easeInOut,
                                        );
                                        break;
                                      }
                                    }
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
                                  side: WidgetStatePropertyAll(
                                    BorderSide(
                                      color: const Color.fromARGB(
                                          255, 207, 205, 205),
                                    ),
                                  ),
                                ),
                                child: Text(
                                  'Signup',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 50,
                              height: 1,
                              color: Colors.grey,
                            ),
                            Padding(
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
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            OutlinedButton(
                                onPressed: () {},
                                style: ButtonStyle(
                                    minimumSize:
                                        WidgetStatePropertyAll(Size(50, 50)),
                                    shape: WidgetStatePropertyAll(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15))),
                                    side: WidgetStatePropertyAll(BorderSide(
                                        color: const Color.fromARGB(
                                            255, 219, 219, 219),
                                        width: 1))),
                                child: SvgPicture.asset(
                                  'assets/svg/facebook.svg',
                                  height: 30,
                                  width: 30,
                                )),
                            SizedBox(
                              width: 15,
                            ),
                            OutlinedButton(
                                onPressed: () {},
                                style: ButtonStyle(
                                  minimumSize:
                                      WidgetStatePropertyAll(Size(50, 50)),
                                  shape: WidgetStatePropertyAll(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15))),
                                  side: WidgetStatePropertyAll(BorderSide(
                                      color: const Color.fromARGB(
                                          255, 219, 219, 219),
                                      width: 1)),
                                ),
                                child: SvgPicture.asset('assets/svg/google.svg',
                                    height: 30, width: 30)),
                            SizedBox(
                              width: 15,
                            ),
                            OutlinedButton(
                                onPressed: () {},
                                style: ButtonStyle(
                                    minimumSize:
                                        WidgetStatePropertyAll(Size(50, 50)),
                                    shape: WidgetStatePropertyAll(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15))),
                                    side: WidgetStatePropertyAll(BorderSide(
                                        color: const Color.fromARGB(
                                            255, 219, 219, 219),
                                        width: 1))),
                                child: SvgPicture.asset('assets/svg/apple.svg',
                                    height: 30, width: 30)),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Already have an account?',
                                style: TextStyle(
                                    color: const Color.fromARGB(
                                        59, 126, 124, 124))),
                            TextButton(
                              onPressed: () {
                                Navigator.pushReplacementNamed(
                                    context, 'login');
                              },
                              child: Text('Sign in',
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
