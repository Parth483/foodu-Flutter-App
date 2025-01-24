import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foodu/App/Homepage/subfolders/order.dart';
import 'package:foodu/Model/ItemModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Address extends StatefulWidget {
  const Address({super.key});
  static const address = 'address';

  @override
  State<Address> createState() => _AddressState();
}

class _AddressState extends State<Address> {
  //to check that data come from checkout page or not
  bool isdatacomefromcheckout = false;
  List<Addresss> globalAddressList = [];

  Future<List<Addresss>> loadAddressList(List<Addresss>? dataList) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (dataList != null) {
      List<String> addressJsonList =
          dataList.map((address) => json.encode(address.toJson())).toList();

      await prefs.setStringList('addressList', addressJsonList);
    }

    List<String>? addressJsonList = prefs.getStringList('addressList');

    // If there is no saved list, return an empty list
    if (addressJsonList == null || addressJsonList.isEmpty) {
      return [];
    }

    // Convert the list of JSON strings to Addresss objects
    List<Addresss> addressList = addressJsonList
        .map((addressJson) => Addresss.fromJson(json.decode(addressJson)))
        .toList();

    setState(() {
      globalAddressList = addressList;
    });
    print('UpdateList::' + jsonEncode(globalAddressList));
    return addressList;
  }

  // Future<void> initializedAddreslist() async {
  //   List<Addresss> loadedAddressses = await loadAddressList();
  //   print('${loadedAddressses}');
  //   print('AddressList:' + jsonEncode(loadedAddressses));
  //   setState(() {
  //     addressList = loadedAddressses;
  //   });
  // }

  Future<void> deleteAddress(int index) async {
    setState(() {
      globalAddressList.removeAt(index);
    });

    loadAddressList(globalAddressList);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Address deleted')),
    );
  }

  List<String> cartItems = [];
  List<discount> cartItemDetails = [];

  Future<void> showitems() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    cartItems = prefs.getStringList('cartkey') ?? [];

    cartItemDetails = cartItems.map((id) {
      return discounts.firstWhere((item) => item.id == id);
    }).toList();
    setState(() {});
  }

  //store address
  String selectedAddress = '';

  double? totalRs;
  discount? order;

  Future openDialog({TotalRs, selectedAddress, name, rs}) async {
    final Map<String, dynamic> addressData = jsonDecode(selectedAddress);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        title: Stack(
          clipBehavior: Clip.none,
          children: [
            Center(
              child: Text('Order Details'),
            ),
            Positioned(
              top: -10,
              right: -10,
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.close),
              ),
            )
          ],
        ),
        content: Stack(
          children: [
            Container(
              padding: EdgeInsets.only(left: 110, top: 35),
              child: Image.asset(
                'assets/images/cart/order.jpg',
                height: 150,
                width: 150,
              ),
            ),
            Positioned(
              // right: 65,
              //  bottom: 70,
              child: SizedBox(
                height: 300,
                child: Column(
                  children: [
                    Container(
                      height: 2,
                      width: 240,
                      color: Colors.grey,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Address:',
                          style: TextStyle(fontSize: 15),
                        ),
                        Text(
                          addressData['address'],
                          style: TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Items:  ',
                          style: TextStyle(fontSize: 15),
                        ),
                        SizedBox(
                          height: 130,
                          child: SingleChildScrollView(
                            child: Text(
                              totalRs != null
                                  ? cartItemDetails
                                      .map((item) => item.name)
                                      .join(',\n')
                                  : name,
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    if (totalRs == null)
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Rs:',
                                style: TextStyle(fontSize: 15),
                              ),
                              Text(
                                rs,
                                style: TextStyle(fontSize: 15),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'DeliveryCharge:',
                                style: TextStyle(fontSize: 15),
                              ),
                              Text(
                                '22',
                                style: TextStyle(fontSize: 15),
                              )
                            ],
                          ),
                        ],
                      ),
                    Container(
                      height: 2,
                      width: 240,
                      color: Colors.grey,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total:',
                          style: TextStyle(fontSize: 15),
                        ),
                        Text(
                          TotalRs != null
                              ? TotalRs.toString()
                              : (int.parse(rs) + 22).toString(),
                          style: TextStyle(fontSize: 15),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    OutlinedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                WidgetStateProperty.all(Colors.green),
                            minimumSize: WidgetStateProperty.all(
                              Size(150, 50),
                            ),
                            shape: WidgetStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(22),
                              ),
                            ),
                            side: WidgetStatePropertyAll(BorderSide.none)),
                        onPressed: () {
                          Navigator.popUntil(
                              context, ModalRoute.withName('hompage'));
                        },
                        child: Text(
                          'Home',
                          style: TextStyle(color: Colors.white),
                        ))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    loadAddressList(null);
    showitems();
  }

  @override
  Widget build(BuildContext context) {
    // final previousRoute = ModalRoute.of(context)?.settings.name;

    // if (previousRoute == '/checkout') {
    //   setState(() {
    //     isdatacomefromcheckout = true;
    //     print(isdatacomefromcheckout);
    //   });
    // } else {
    //   setState(() {
    //     isdatacomefromcheckout = false;
    //     print(isdatacomefromcheckout);
    //   });
    // }

    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    if (args != null) {
      if (args['totalRs'] != null) {
        totalRs = args['totalRs'];
        print('Total Rs: $totalRs');
      } else {
        order = args['order'];
        print('name:' + order!.name);
      }
    }

    // final discount order =
    //     ModalRoute.of(context)!.settings.arguments as discount;

    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          titleSpacing: 0,
          title: Text('Address'),
          scrolledUnderElevation: 0,
          //backgroundColor: Colors.white,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 480,
                child: ListView.builder(
                  itemCount: globalAddressList.length,
                  itemBuilder: (context, index) {
                    String addressValue = jsonEncode({
                      'type': globalAddressList[index].type,
                      'address': globalAddressList[index].addresss,
                      'state': globalAddressList[index].state,
                      'city': globalAddressList[index].city,
                    });

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedAddress = jsonEncode({
                            'type': globalAddressList[index].type,
                            'address': globalAddressList[index].addresss,
                            'state': globalAddressList[index].state,
                            'city': globalAddressList[index].city,
                          });
                        });
                      },
                      child: Slidable(
                          endActionPane: ActionPane(
                            motion: StretchMotion(),
                            children: [
                              SlidableAction(
                                onPressed: (context) async {
                                  await deleteAddress(index);
                                  selectedAddress = '';
                                },
                                icon: Icons.delete,
                                label: 'Delete',
                                borderRadius: BorderRadius.circular(15),
                                backgroundColor:
                                    const Color.fromARGB(255, 245, 81, 69),
                                padding: EdgeInsets.symmetric(vertical: 10),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Stack(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.zero,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 10),
                                      //color: Colors.amber,
                                      child: Card(
                                        elevation: 0.1,
                                        color: Colors.white,
                                        shadowColor: Colors.black,
                                        margin: EdgeInsets.zero,
                                        child: Row(
                                          children: [
                                            Container(
                                              height: 90,
                                              width: 30,
                                              decoration: BoxDecoration(
                                                  color: const Color.fromARGB(
                                                      26, 94, 93, 93),
                                                  shape: BoxShape.circle),
                                              margin: EdgeInsets.only(left: 20),
                                              alignment: Alignment.center,
                                              child: Container(
                                                height: 35,
                                                width: 35,
                                                decoration: BoxDecoration(
                                                    color: Colors.green,
                                                    shape: BoxShape.circle),
                                                alignment: Alignment.center,
                                                child: SvgPicture.asset(
                                                  'assets/svg/location.svg',
                                                  height: 20,
                                                  width: 20,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Container(
                                                      padding: EdgeInsets.only(
                                                          left: 15),
                                                      child: Text(
                                                        globalAddressList[index]
                                                            .type,
                                                        style: TextStyle(
                                                            fontSize: 20),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 15,
                                                    ),
                                                    // if (index == 0)
                                                    //   Container(
                                                    //     padding: EdgeInsets.only(
                                                    //         left: 8,
                                                    //         right: 8,
                                                    //         top: 5,
                                                    //         bottom: 5),
                                                    //     decoration: BoxDecoration(
                                                    //         color: const Color
                                                    //             .fromARGB(
                                                    //             26, 93, 94, 93),
                                                    //         borderRadius:
                                                    //             BorderRadius
                                                    //                 .circular(5)),
                                                    //     child: Text(
                                                    //       'Default',
                                                    //       style: TextStyle(
                                                    //           fontSize: 10,
                                                    //           color:
                                                    //               Colors.green),
                                                    //     ),
                                                    //   ),
                                                  ],
                                                ),
                                                Container(
                                                  padding:
                                                      EdgeInsets.only(left: 15),
                                                  child: Text(
                                                    globalAddressList[index]
                                                        .addresss,
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        color: const Color
                                                            .fromARGB(255, 160,
                                                            160, 160)),
                                                  ),
                                                ),
                                                Row(
                                                  children: [
                                                    Container(
                                                      padding: EdgeInsets.only(
                                                          left: 15),
                                                      child: Text(
                                                        globalAddressList[index]
                                                            .state,
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            color: const Color
                                                                .fromARGB(255,
                                                                160, 160, 160)),
                                                      ),
                                                    ),
                                                    Container(
                                                      padding: EdgeInsets.only(
                                                          left: 15),
                                                      child: Text(
                                                        globalAddressList[index]
                                                            .city,
                                                        style: TextStyle(
                                                          fontSize: 15,
                                                          color: const Color
                                                              .fromARGB(255,
                                                              160, 160, 160),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      right: 20,
                                      top: 32,
                                      child: IconButton(
                                        onPressed: () async {
                                          final result =
                                              await Navigator.pushNamed(
                                                  context, 'editaddress',
                                                  arguments: {
                                                'address':
                                                    globalAddressList[index],
                                                'index': index,
                                              });
                                          if (result != null &&
                                              result is Addresss) {
                                            setState(() {
                                              globalAddressList[index] = result;
                                            });
                                            await loadAddressList(
                                                globalAddressList);
                                            // SharedPreferences prefs =
                                            //     await SharedPreferences.getInstance();
                                            // List<String> addressJsonList = globalAddressList
                                            //     .map((address) =>
                                            //         json.encode(address.toJson()))
                                            //     .toList();
                                            // await prefs.setStringList(
                                            //     'addressList', addressJsonList);
                                          }
                                        },
                                        icon: Icon(
                                          Icons.edit,
                                          size: 20,
                                          color: Colors.green,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(right: 20),
                                child: Radio(
                                    value: addressValue,
                                    groupValue: selectedAddress,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedAddress = value!;
                                        print(
                                            'selectedAddress:$selectedAddress');
                                      });
                                    }),
                              )
                            ],
                          )),
                    );
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 220, bottom: 20),
                child: FloatingActionButton(
                  onPressed: () {
                    Navigator.pushNamed(context, 'addaddress')
                        .then((result) async {
                      if (result != null && result is List<Addresss>) {
                        setState(() {
                          globalAddressList.addAll(result);
                        });
                        loadAddressList(globalAddressList);
                        // SharedPreferences prefs =
                        //     await SharedPreferences.getInstance();
                        // List<String> addressJsonList = globalAddressList
                        //     .map((address) => json.encode(address.toJson()))
                        //     .toList();

                        // await prefs.setStringList('addressList', addressJsonList);
                        // List<String>? dataList = prefs.getStringList('addressList');
                        // print('AddressListsss:' + jsonEncode(dataList));
                      }
                    });
                  },
                  backgroundColor: Colors.green,
                  elevation: 2,
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
              ),
              Container(
                height: 1,
                width: 400,
                color: const Color.fromARGB(255, 223, 222, 222),
              ),
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
                      borderRadius: BorderRadius.circular(22),
                    ),
                  ),
                  side: WidgetStatePropertyAll(BorderSide.none),
                ),
                onPressed: () {
                  if (selectedAddress.isNotEmpty) {
                    openDialog(
                        TotalRs: totalRs,
                        selectedAddress: selectedAddress,
                        name: order?.name,
                        rs: order?.rs);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Please Select Address'),
                      duration: Duration(seconds: 2),
                    ));
                  }
                },
                child: Text(
                  'Place Order',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ));
  }
}
