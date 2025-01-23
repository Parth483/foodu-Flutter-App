import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Editprofile extends StatefulWidget {
  const Editprofile({super.key});
  static const editprofile = 'editprofile';

  @override
  State<Editprofile> createState() => _EditprofileState();
}

class _EditprofileState extends State<Editprofile> {
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  final TextEditingController _namecontroller = TextEditingController();
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _contactcontroller = TextEditingController();
  final TextEditingController _addresscontroller = TextEditingController();
  //final TextEditingController _gendercontroller = TextEditingController();
  final TextEditingController _datecontroller = TextEditingController();
  String? groupvalue;
  bool isGenderSelected = false;

  DateTime? selectedDate;

  Future<void> _pickdate() async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1900),
        lastDate: DateTime.now());

    // if (pickedDate != null && pickedDate != selectedDate) {
    //   setState(() {
    //     selectedDate = pickedDate;
    //   });
    // }
    if (pickedDate != null) {
      String formattedDate =
          '${pickedDate.day}-${pickedDate.month}-${pickedDate.year}';
      setState(() {
        selectedDate = pickedDate;
        _datecontroller.text = formattedDate;
      });
    }
  }

  Future<void> _getdata() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _namecontroller.text = prefs.getString('name') ?? '';
      _emailcontroller.text = prefs.getString('email') ?? '';
      _contactcontroller.text = prefs.getString('phonenumber') ?? '';
      _addresscontroller.text = prefs.getString('address') ?? '';
      groupvalue = prefs.getString('gender') ?? '';
      _datecontroller.text = prefs.getString('date') ?? '';
      imagepath = prefs.getString('image');

      if (_datecontroller.text.isNotEmpty) {
        List<String> dateparts = _datecontroller.text.split('-');

        selectedDate = DateTime(
          int.parse(dateparts[2]),
          int.parse(dateparts[1]),
          int.parse(dateparts[0]),
        );
      } else {
        selectedDate = DateTime.now();
      }
      if (imagepath != null) {
        _imageFile = XFile(imagepath!);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _getdata();
  }

  Future<void> _updatedata() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', _namecontroller.text);
    await prefs.setString('email', _emailcontroller.text);
    await prefs.setString('phonenumber', _contactcontroller.text);
    await prefs.setString('address', _addresscontroller.text);
    await prefs.setString('gender', groupvalue ?? '');
    await prefs.setString('date', _datecontroller.text);
    await prefs.setString('image', _imageFile!.path);

    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Profile Updated')));
    // Adding delay to allow UI to update before popping
    Future.delayed(Duration(seconds: 1), () {
      Navigator.of(context).pop(true);
    });
  }

  final ImagePicker _picker = ImagePicker();
  XFile? _imageFile;
  String? imagepath;

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

  Future<void> showOptionsCupertinoDialog() async {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text('Choose an Option'),
          content: Text('Select how you want to add the picture.'),
          actions: [
            CupertinoDialogAction(
              onPressed: () {
                Navigator.of(context).pop();
                _pickImage(iscamera: false); // Open Photo Gallery
              },
              child: Text('Photo Gallery'),
            ),
            CupertinoDialogAction(
              onPressed: () {
                Navigator.of(context).pop();
                _pickImage(iscamera: true); // Open Camera
              },
              child: Text('Camera'),
            ),
            CupertinoDialogAction(
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  _imageFile = null; // Remove the selected image
                });
              },
              isDestructiveAction: true,
              child: Text('Remove Picture'),
            ),
            CupertinoDialogAction(
              onPressed: () {
                Navigator.of(context).pop(); // Cancel
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  Future<void> showOptionsMaterialDialog() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Choose an Option'),
          content: Text('Select how you want to add the picture.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _pickImage(iscamera: false); // Open Photo Gallery
              },
              child: Text('Photo Gallery'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _pickImage(iscamera: true); // Open Camera
              },
              child: Text('Camera'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  _imageFile = null; // Remove the selected image
                });
              },
              child: Text(
                'Remove Picture',
                style: TextStyle(color: Colors.red), // Highlight as destructive
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cancel
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
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
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          titleSpacing: 0,
          automaticallyImplyLeading: true,
          title: Text('Edit Profile'),
          scrolledUnderElevation: 0,
          backgroundColor: Colors.white10,
        ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Center(
            child: Form(
              key: _form,
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        height: 100,
                        width: 100,
                        // color: Colors.amber,
                        // padding: EdgeInsets.only(left: 15, right: 15),
                        child: ClipOval(
                            //clipBehavior: Clip.none,
                            child: _imageFile != null &&
                                    _imageFile!.path.isNotEmpty
                                ? Image.file(
                                    File(_imageFile!.path),
                                    height: 100,
                                    width: 100,
                                    fit: BoxFit.cover,
                                  )
                                : Icon(
                                    Icons.account_circle,
                                    size: 100,
                                  )),
                      ),
                      Positioned(
                          bottom: 0,
                          right: 5,
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(10)),
                            height: 40,
                            width: 40,
                            // color: const Color.fromARGB(255, 7, 255, 48),
                            child: IconButton(
                              onPressed:
                                  //  showOptionsMaterialDialog,
                                  showOptionsCupertinoDialog,
                              // //showoptions,
                              icon: Icon(Icons.mode_edit_outline_outlined),
                            ),
                          ))
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20, right: 20),
                    child: TextFormField(
                      controller: _namecontroller,
                      decoration: InputDecoration(
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(Icons.person),
                        ),
                        filled: true,
                        fillColor: const Color.fromARGB(26, 185, 178, 178),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide.none),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter Name';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20, right: 20),
                    child: TextFormField(
                      controller: _emailcontroller,
                      decoration: InputDecoration(
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(8),
                          child: Icon(Icons.email),
                        ),
                        filled: true,
                        fillColor: const Color.fromARGB(26, 185, 178, 178),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide.none),
                      ),
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
                    height: 20,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20, right: 20),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: _contactcontroller,
                      decoration: InputDecoration(
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(8),
                          child: Icon(Icons.contacts_rounded),
                        ),
                        filled: true,
                        fillColor: const Color.fromARGB(26, 185, 178, 178),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide.none),
                      ),
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
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20, right: 20),
                    child: TextFormField(
                      controller: _addresscontroller,
                      decoration: InputDecoration(
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(8),
                          child: Icon(Icons.location_on),
                        ),
                        filled: true,
                        fillColor: const Color.fromARGB(26, 185, 178, 178),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide.none),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter Address';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  // Container(
                  //   margin: EdgeInsets.only(left: 20, right: 20),
                  //   child: TextFormField(
                  //     controller: _gendercontroller,
                  //     decoration: InputDecoration(
                  //       filled: true,
                  //       fillColor: const Color.fromARGB(26, 185, 178, 178),
                  //       border: OutlineInputBorder(
                  //           borderRadius: BorderRadius.circular(15),
                  //           borderSide: BorderSide.none),
                  //     ),
                  //   ),
                  // ),
                  Container(
                    margin: EdgeInsets.only(left: 20, right: 20),
                    child: TextFormField(
                      readOnly: true,
                      onTap: _pickdate,
                      controller: _datecontroller,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.date_range),
                        filled: true,
                        fillColor: const Color.fromARGB(26, 185, 178, 178),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide.none),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Select Date';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20,
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
                              color: const Color.fromARGB(255, 185, 39, 31)),
                        )),
                  SizedBox(
                    height: 20,
                  ),
                  OutlinedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(Colors.green),
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
                        if (groupvalue == null) {
                          setState(() {
                            isGenderSelected = true;
                          });
                        } else {
                          _updatedata();
                        }
                      }
                    },
                    child: Text(
                      'Update',
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
