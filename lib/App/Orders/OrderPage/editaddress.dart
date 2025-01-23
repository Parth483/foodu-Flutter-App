import 'package:flutter/material.dart';
import 'package:foodu/Model/ItemModel.dart';

class Editaddress extends StatefulWidget {
  const Editaddress({super.key});

  static const editaddress = 'editaddress';

  @override
  State<Editaddress> createState() => _EditaddressState();
}

class _EditaddressState extends State<Editaddress> {
  bool isDetailsSelected = false;

  late String groupvalue;

  late TextEditingController _statecontroller;

  late TextEditingController _citycontroller;

  late TextEditingController _addresscontroller;
  late Addresss address;
  late int index;
  final GlobalKey<FormState> _form = GlobalKey<FormState>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final arguments = ModalRoute.of(context)?.settings.arguments as Map?;
    address = arguments?['address'];
    index = arguments?['index'];

    groupvalue = address.type;
    _statecontroller = TextEditingController(text: address.state);
    _citycontroller = TextEditingController(text: address.city);
    _addresscontroller = TextEditingController(text: address.addresss);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Address'),
        titleSpacing: 0,
        automaticallyImplyLeading: true,
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
                      if (_form.currentState?.validate() ?? false) {
                        Navigator.pop(
                            context,
                            Addresss(
                                id: '',
                                state: _statecontroller.text,
                                city: _citycontroller.text,
                                addresss: _addresscontroller.text,
                                type: groupvalue));
                      }
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
                      'Save Address',
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
