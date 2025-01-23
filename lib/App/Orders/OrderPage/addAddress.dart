import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:foodu/Model/ItemModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Addaddress extends StatefulWidget {
  const Addaddress({super.key});

  static const addaddress = 'addaddress';

  @override
  State<Addaddress> createState() => _AddaddressState();
}

class _AddaddressState extends State<Addaddress> {
  bool isDetailsSelected = false;

  String? groupvalue;

  final TextEditingController _statecontroller = TextEditingController();

  final TextEditingController _citycontroller = TextEditingController();

  final TextEditingController _addresscontroller = TextEditingController();

  final GlobalKey<FormState> _form = GlobalKey<FormState>();

  final List<Addresss> addressList = [];

  Future<void> _addAddressToList() async {
    if (_form.currentState?.validate() ?? false) {
      if (groupvalue == null) {
        setState(() {
          isDetailsSelected = true;
        });
      } else {
        print('State:${_statecontroller.text}');
        print('City:${_citycontroller.text}');
        print('Address:${_addresscontroller.text}');
        print('Type:$groupvalue');

        final newAddress = Addresss(
          id: DateTime.now().toString(),
          state: _statecontroller.text,
          city: _citycontroller.text,
          addresss: _addresscontroller.text,
          type: groupvalue!,
        );

        setState(() {
          addressList.add(newAddress);
        });
        saveAddressList(addressList);

        _statecontroller.clear();
        _citycontroller.clear();
        _addresscontroller.clear();
        groupvalue = null;

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Address added successfully!')),
        );

        Navigator.of(context).pop(addressList);
      }
    }
  }

  Future<void> saveAddressList(List<Addresss> addressList) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String> addressJsonList =
        addressList.map((address) => json.encode(address.toJson())).toList();

    await prefs.setStringList('addressList', addressJsonList);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Address'),
        automaticallyImplyLeading: true,
        titleSpacing: 0,
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: Center(
            child: Form(
              key: _form,
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 20, right: 20, top: 50),
                    child: TextFormField(
                      controller: _statecontroller,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color.fromARGB(26, 185, 178, 178),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide.none),
                          hintText: 'Enter State'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter State';
                        }
                        return null;
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                    child: TextFormField(
                      controller: _citycontroller,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color.fromARGB(26, 185, 178, 178),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide.none),
                          hintText: 'Enter City'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter City';
                        }
                        return null;
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                    child: TextFormField(
                      controller: _addresscontroller,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color.fromARGB(26, 185, 178, 178),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide.none),
                          hintText: 'Enter Address'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter Address';
                        }
                        return null;
                      },
                    ),
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
                            Text('Type:'),
                            Radio(
                              value: 'Office',
                              groupValue: groupvalue,
                              onChanged: (value) {
                                setState(() {
                                  groupvalue = value!;
                                  isDetailsSelected = false;
                                  print('$groupvalue');
                                });
                              },
                            ),
                            Text('Office'),
                            Radio(
                              value: 'Home',
                              groupValue: groupvalue,
                              onChanged: (value) {
                                setState(
                                  () {
                                    groupvalue = value!;
                                    isDetailsSelected = false;
                                    print('$groupvalue');
                                  },
                                );
                              },
                            ),
                            Text('Home'),
                          ],
                        ),
                      ),
                    ],
                  ),
                  if (isDetailsSelected)
                    Container(
                        padding: EdgeInsets.only(right: 190),
                        child: Text(
                          'Please Select The Type',
                          style: TextStyle(
                              fontSize: 12,
                              color: const Color.fromARGB(255, 185, 39, 31)),
                        )),
                  OutlinedButton(
                    onPressed: () {
                      _addAddressToList();
                    },
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(Colors.green),
                      minimumSize: WidgetStateProperty.all(Size(310, 50)),
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
                      'Add Address',
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
