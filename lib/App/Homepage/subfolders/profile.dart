import 'dart:io';

import 'package:flutter/material.dart';
//import 'package:foodu/App/Homepage/homepage.dart';
import 'package:foodu/App/Profile/logout.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:flutter_svg/svg.dart';

class Profile extends StatefulWidget {
  const Profile({super.key, this.changeToOrder});
  static const profile = 'profile';
  final Function? changeToOrder;

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String? name;

  String? email;
  String? contact;
  String? address;
  String? gender;
  String? dob;
  String? imagepath;
  XFile? _imagefile;

  Future<void> _getprofile() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      name = prefs.getString('name');
      email = prefs.getString('email');
      contact = prefs.getString('phonenumber');
      address = prefs.getString('address');
      gender = prefs.getString('gender');
      dob = prefs.getString('date');
      imagepath = prefs.getString('image');

      if (imagepath != null) {
        _imagefile = XFile(imagepath!);
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getprofile();
  }

  void _openModalBottom() {
    showModalBottomSheet(context: context, builder: (context) => Logout());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Material(
                  elevation: 8,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(25),
                      bottomRight: Radius.circular(25)),
                  child: Container(
                    //  margin: EdgeInsets.only(top: 50),
                    padding:
                        EdgeInsets.symmetric(horizontal: 142, vertical: 50),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(25),
                        bottomRight: Radius.circular(25),
                      ),
                    ),
                    child: Container(
                      padding: EdgeInsets.only(bottom: 50),
                      child: Text(
                        'Profile',
                        style: TextStyle(color: Colors.white, fontSize: 30),
                      ),
                    ),

                    // Column(
                    //   children: [

                    //     SizedBox(
                    //       height: 50,
                    //     ),
                    //     // ClipOval(
                    //     //   child: Image.asset(
                    //     //     'assets/images/getstart/g1.png',
                    //     //     height: 100,
                    //     //     width: 100,
                    //     //   ),
                    //     // ),
                    //     SizedBox(
                    //       height: 110,
                    //     ),
                    //     // Row(
                    //     //   mainAxisAlignment: MainAxisAlignment.center,
                    //     //   children: [
                    //     //     // Text(
                    //     //     //   'Name:',
                    //     //     //   style: TextStyle(
                    //     //     //       fontSize: 20, fontWeight: FontWeight.bold),
                    //     //     // ),
                    //     //     // SizedBox(
                    //     //     //   width: 10,
                    //     //     // ),
                    //     //     // Text(
                    //     //     //   'Parth',
                    //     //     //   style: TextStyle(
                    //     //     //       fontSize: 20, fontWeight: FontWeight.bold),
                    //     //     // ),
                    //     //     SizedBox(
                    //     //       height: 100,
                    //     //     ),
                    //     //   ],
                    //     // ),
                    //   ],
                    // ),
                  ),
                ),
                Positioned(
                  bottom: -280,
                  left: 30,
                  right: 30,
                  child: Stack(
                    children: [
                      Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(22),
                        ),
                        // margin: EdgeInsets.only(top: 50),
                        child: Material(
                          borderRadius: BorderRadius.circular(22),
                          elevation: 5,
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    //  color: Colors.amber,
                                    borderRadius: BorderRadius.circular(22)),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 60, vertical: 10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Stack(
                                      clipBehavior: Clip.none,
                                      children: [
                                        ClipOval(
                                          child: _imagefile != null &&
                                                  _imagefile!.path.isNotEmpty
                                              ? Image.file(
                                                  File(_imagefile!.path),
                                                  height: 100,
                                                  width: 100,
                                                  fit: BoxFit.cover,
                                                )
                                              : Icon(
                                                  Icons.account_circle,
                                                  size: 100,
                                                ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      '$name',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                //padding: EdgeInsets.only(l: 0),
                                margin: EdgeInsets.only(left: 20),
                                child: Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Email:',
                                          style: TextStyle(fontSize: 15),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text('Contact:',
                                            style: TextStyle(fontSize: 15)),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text('Address:',
                                            style: TextStyle(fontSize: 15)),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text('Gender:',
                                            style: TextStyle(fontSize: 15)),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text('DOB:',
                                            style: TextStyle(fontSize: 15)),
                                        SizedBox(
                                          height: 20,
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('$email',
                                            style: TextStyle(fontSize: 15)),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text('$contact',
                                            style: TextStyle(fontSize: 15)),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text('$address',
                                            softWrap: true,
                                            style: TextStyle(fontSize: 15)),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text('$gender',
                                            style: TextStyle(fontSize: 15)),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text('$dob',
                                            style: TextStyle(fontSize: 15)),
                                        SizedBox(
                                          height: 20,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: 230,
                        top: 20,
                        child: IconButton(
                          onPressed: () async {
                            print('Edit');
                            Navigator.pushNamed(context, 'editprofile')
                                .then((result) {
                              if (result == true) {
                                _getprofile();
                              }
                            });
                          },
                          icon: Icon(Icons.edit),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 110,
            ),
            // Container(
            //   margin: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            //   decoration: BoxDecoration(
            //       color: Colors.grey, borderRadius: BorderRadius.circular(22)),
            //   child: Material(
            //     borderRadius: BorderRadius.circular(22),
            //     elevation: 5,
            //     child: Container(
            //       decoration:
            //           BoxDecoration(borderRadius: BorderRadius.circular(22)),
            //       padding: EdgeInsets.symmetric(vertical: 30, horizontal: 35),
            //       child: Row(
            //         children: [
            //           Column(
            //             crossAxisAlignment: CrossAxisAlignment.start,
            //             children: [
            //               Text(
            //                 'Email:',
            //                 style: TextStyle(fontSize: 15),
            //               ),
            //               Text('Contact:', style: TextStyle(fontSize: 15)),
            //               SizedBox(
            //                 height: 10,
            //               ),
            //               Text('Address:', style: TextStyle(fontSize: 15)),
            //               SizedBox(
            //                 height: 10,
            //               ),
            //               Text('Gender:', style: TextStyle(fontSize: 15)),
            //               SizedBox(
            //                 height: 10,
            //               ),
            //               Text('DOB:', style: TextStyle(fontSize: 15)),
            //             ],
            //           ),
            //           SizedBox(
            //             width: 20,
            //           ),
            //           Column(
            //             crossAxisAlignment: CrossAxisAlignment.start,
            //             children: [
            //               Text('parthgamit483@gmail.com',
            //                   style: TextStyle(fontSize: 15)),
            //               SizedBox(
            //                 height: 10,
            //               ),
            //               Text('9723321270', style: TextStyle(fontSize: 15)),
            //               SizedBox(
            //                 height: 10,
            //               ),
            //               Text('27/B SaritaNagarSociety,Vyara',
            //                   softWrap: true, style: TextStyle(fontSize: 15)),
            //               SizedBox(
            //                 height: 10,
            //               ),
            //               Text('Male', style: TextStyle(fontSize: 15)),
            //               SizedBox(
            //                 height: 10,
            //               ),
            //               Text('18/04/2000', style: TextStyle(fontSize: 15)),
            //             ],
            //           ),
            //         ],
            //       ),
            //     ),
            //   ),
            // )
            SizedBox(
              height: 190,
            ),
            OutlinedButton(
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(Colors.green),
                minimumSize: WidgetStateProperty.all(
                  Size(310, 50),
                ),
                shape: WidgetStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                side: WidgetStatePropertyAll(
                  BorderSide(
                    color: Color.fromARGB(255, 207, 205, 205),
                  ),
                ),
              ),
              onPressed: () {
                widget.changeToOrder!();
              },
              child: Text(
                'Order',
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            OutlinedButton(
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(Colors.green),
                minimumSize: WidgetStateProperty.all(
                  Size(310, 50),
                ),
                shape: WidgetStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                side: WidgetStatePropertyAll(
                  BorderSide(
                    color: Color.fromARGB(255, 207, 205, 205),
                  ),
                ),
              ),
              onPressed: () {
                Navigator.pushNamed(context, 'editpassword').then((result) {
                  if (result == true) {
                    _getprofile();
                  }
                });
              },
              child: Text(
                'Change Password',
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            OutlinedButton(
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(Colors.green),
                minimumSize: WidgetStateProperty.all(
                  Size(310, 50),
                ),
                shape: WidgetStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                side: WidgetStatePropertyAll(
                  BorderSide(
                    color: Color.fromARGB(255, 207, 205, 205),
                  ),
                ),
              ),
              onPressed: _openModalBottom,
              child: Text(
                'Log Out',
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
