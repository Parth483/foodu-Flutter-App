import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:foodu/Model/ItemModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Cart extends StatefulWidget {
  const Cart({
    super.key,
  });
  static const cart = 'cart';

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  List<String> cartItems = [];
  List<discount> cartItemDetails = [];

  Future<void> showcartitem() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    cartItems = prefs.getStringList('cartkey') ?? [];
    cartItemDetails = cartItems.map((id) {
      return discounts.firstWhere((item) => item.id == id);
    }).toList();
    setState(() {});

    /// print(("DATA::${json.encode(cartItems)}"));
    //print(("cartItemDetails::${json.encode(cartItemDetails)}"));
  }

  Future<void> deleteCartItem(String id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      cartItems.remove(id);
      cartItemDetails.removeWhere((item) => item.id == id);
    });

    await prefs.setStringList('cartkey', cartItems);

    print('Deleted item with ID: $id');
    print('Updated cart items: $cartItems');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    showcartitem();
  }

  //final bool _isempty = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white10,
        automaticallyImplyLeading: true,
        titleSpacing: 0,
        toolbarHeight: 80,
        title: Text('My Cart'),
      ),
      body: Center(
          child: cartItemDetails.isNotEmpty
              ? ListView.builder(
                  itemCount: cartItemDetails.length,
                  itemBuilder: (context, index) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Slidable(
                          endActionPane:
                              ActionPane(motion: StretchMotion(), children: [
                            SlidableAction(
                              onPressed: (context) async {
                                await deleteCartItem(cartItemDetails[index].id);
                                print('Item Delete');
                              },
                              icon: Icons.delete,
                              label: 'Delete',
                              borderRadius: BorderRadius.circular(15),
                              backgroundColor:
                                  const Color.fromARGB(255, 245, 81, 69),
                            )
                          ]),
                          child: Stack(
                            children: [
                              Card(
                                elevation: 0,
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                margin: EdgeInsets.only(left: 15, right: 15),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: 10, right: 10, top: 10, bottom: 10),
                                  child: Stack(
                                    children: [
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Container(
                                          //  color: Colors.blue,
                                          padding: EdgeInsets.all(10),
                                          width: 100,
                                          height: 100,
                                          decoration: BoxDecoration(
                                              color: const Color.fromARGB(
                                                  255, 230, 225, 225),
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          child: Image.asset(
                                            cartItemDetails[index].image,
                                            fit: BoxFit.cover,
                                            width: 90,
                                            height: 90,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                child: Column(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(left: 135),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 25,
                                          ),
                                          Text(
                                            cartItemDetails[index].name,
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w900),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            '${cartItemDetails[index].items}item | ${cartItemDetails[index].km}'
                                            'km',
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w900),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            'Rs.${cartItemDetails[index].rs}',
                                            style: TextStyle(
                                                color: const Color.fromARGB(
                                                    255, 99, 240, 71),
                                                fontSize: 15,
                                                fontWeight: FontWeight.w900),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    );
                    // ignore: dead_code
                  },
                )
              : Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 150),
                      child: Image.asset(
                        'assets/images/cart/cart.png',
                      ),
                    ),
                    Text(
                      'Empty',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'You dont have any foods in cart at this time',
                      style: TextStyle(color: Colors.grey),
                    )
                  ],
                )),
    );
  }
}
