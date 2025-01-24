import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodu/Model/ItemModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Checkout extends StatefulWidget {
  const Checkout({super.key});

  static const checkout = 'checkout';

  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  List<Addresss> globaladdresslist = [];

  bool isdiscountselected = false;

  String? discountAmount;

//edit open or not
  bool openedit = false;

  void _toggleEdit(index) {
    setState(() {
      cartItemDetails[index].toggle = !cartItemDetails[index]
          .toggle; // Toggle the value between true and false
    });
  }

  Future<void> deleteCartItem(String id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    cartItemDetails.forEach((item) {
      if (item.id == id) {
        setState(() {
          item.itemCount = 1;
        });
      }
    });

    setState(() {
      cartItems.remove(id);
      cartItemDetails.removeWhere((item) => item.id == id);
    });

    await prefs.setStringList('cartkey', cartItems);

    print('Deleted item with ID: $id');
    print('Updated cart items: $cartItems');
  }

  Future<void> setdiscount() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? discount = prefs.getString('offer');

    if (discount != null) {
      setState(() {
        discountAmount = discount;
        isdiscountselected = true;
      });
    }
  }

  double calculatediscount(double originalprice, double discount) {
    double discountamount = originalprice * (discount / 100);

    return originalprice - discountamount;
  }

  Future<void> loadaddress() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String>? addressJsonList = prefs.getStringList('addressList');

    if (addressJsonList == null || addressJsonList.isEmpty) {
      return;
    }

    List<Addresss> addressList = addressJsonList
        .map((addressjson) => Addresss.fromJson(json.decode(addressjson)))
        .toList();

    setState(() {
      globaladdresslist = addressList;
    });
  }

  // void _navigateToSpeacialOffers() async {
  //   final selectedDiscount =
  //       await Navigator.pushNamed(context, 'specialoffers');

  //   if (selectedDiscount != null) {
  //     setState(() {
  //       discountAmount = selectedDiscount as String;
  //     });
  //   }
  // }

  //item count

  //int count = 1;

  List<String> cartItems = [];
  List<discount> cartItemDetails = [];

  Future<void> showcartitem() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    cartItems = prefs.getStringList('cartkey') ?? [];

    cartItemDetails = cartItems.map((id) {
      return discounts.firstWhere((item) => item.id == id);
    }).toList();
    setState(() {});

    print(cartItemDetails[0]);
  }

  void increment(int index) {
    setState(() {
      cartItemDetails[index].itemCount++;
    });
    print(
        'New count for ${cartItemDetails[index].name}: ${cartItemDetails[index].itemCount}');
  }

  void decrementCount(int index) {
    setState(() {
      if (cartItemDetails[index].itemCount > 0) {
        cartItemDetails[index].itemCount--;
      }
    });
    print(
        'New count for ${cartItemDetails[index].name}: ${cartItemDetails[index].itemCount}');
  }

  @override
  void initState() {
    super.initState();
    loadaddress();
    setdiscount();
    showcartitem();
  }

  @override
  Widget build(BuildContext context) {
    //final discount order =
    //  ModalRoute.of(context)!.settings.arguments as discount;
    //  storeorder(order);
    // discounts.where((discount) => discount.category == 'Burger').toList();
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: Text('My Cart'),
          titleSpacing: 0,
          scrolledUnderElevation: 0,
          backgroundColor: Colors.white10,
        ),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Center(
                    child: cartItemDetails.isNotEmpty
                        ? Column(
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 70,
                                width: 300,
                                child: Card(
                                  elevation: 0,
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18)),
                                  shadowColor: Colors.grey.withOpacity(0.5),
                                  child: Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 30),
                                    child: Row(
                                      children: [
                                        Text(
                                          'Items:${cartItemDetails.length}',
                                          style: TextStyle(fontSize: 25),
                                        ),
                                        Spacer(),
                                        Text(
                                            'Total Price:${cartItemDetails.fold(0, (sum, item) => sum + (int.parse(item.rs) * item.itemCount))}',
                                            style: TextStyle(fontSize: 25))
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              // Stack(
                              //   children: [
                              //     SizedBox(
                              //       height: 180,
                              //       width: 328,
                              //       child: Card(
                              //         color: Colors.white,
                              //         shape: RoundedRectangleBorder(
                              //           borderRadius: BorderRadius.circular(18),
                              //         ),
                              //         elevation: 0,
                              //         shadowColor: Colors.grey.withOpacity(0.5),
                              //         // margin: EdgeInsets.only(left: 15),
                              //         child: Column(
                              //           children: [
                              //             Container(
                              //                 margin: EdgeInsets.only(
                              //                     right: 200, top: 15, bottom: 15),
                              //                 child: Text(
                              //                   'Deliver to',
                              //                   style: TextStyle(fontSize: 20),
                              //                 )),
                              //             Container(
                              //               height: 2,
                              //               width: 270,
                              //               color: const Color.fromARGB(255, 228, 223, 223),
                              //             ),
                              //             SizedBox(
                              //               height: 20,
                              //             ),
                              //             Row(
                              //               children: [
                              //                 Container(
                              //                   height: 50,
                              //                   width: 50,
                              //                   decoration: BoxDecoration(
                              //                       color: const Color.fromARGB(26, 94, 93, 93),
                              //                       shape: BoxShape.circle),
                              //                   margin: EdgeInsets.only(left: 20),
                              //                   alignment: Alignment.center,
                              //                   child: Container(
                              //                     height: 35,
                              //                     width: 35,
                              //                     decoration: BoxDecoration(
                              //                         color: Colors.green,
                              //                         shape: BoxShape.circle),
                              //                     alignment: Alignment.center,
                              //                     child: SvgPicture.asset(
                              //                       'assets/svg/location.svg',
                              //                       height: 20,
                              //                       width: 20,
                              //                       color: Colors.white,
                              //                     ),
                              //                   ),
                              //                 ),
                              //                 SizedBox(
                              //                   width: 20,
                              //                 ),
                              //                 Column(
                              //                   crossAxisAlignment: CrossAxisAlignment.start,
                              //                   children: [
                              //                     Row(
                              //                       children: [
                              //                         Text(
                              //                           globaladdresslist[0].type,
                              //                           style: TextStyle(
                              //                             fontSize: 20,
                              //                             //  fontWeight: FontWeight.bold,
                              //                           ),
                              //                         ),
                              //                         SizedBox(
                              //                           width: 10,
                              //                         ),
                              //                         Container(
                              //                           padding: EdgeInsets.only(
                              //                               left: 8,
                              //                               right: 8,
                              //                               top: 5,
                              //                               bottom: 5),
                              //                           decoration: BoxDecoration(
                              //                               color: const Color.fromARGB(
                              //                                   26, 93, 94, 93),
                              //                               borderRadius:
                              //                                   BorderRadius.circular(5)),
                              //                           child: Text(
                              //                             'Default',
                              //                             style: TextStyle(
                              //                                 fontSize: 10,
                              //                                 color: Colors.green),
                              //                           ),
                              //                         ),
                              //                       ],
                              //                     ),
                              //                     SizedBox(
                              //                       height: 5,
                              //                     ),
                              //                     Text(
                              //                       globaladdresslist[0].addresss,
                              //                       style: TextStyle(
                              //                           color: const Color.fromARGB(
                              //                               255, 139, 139, 139),
                              //                           fontSize: 15),
                              //                     ),
                              //                     Row(
                              //                       children: [
                              //                         Container(
                              //                           padding: EdgeInsets.only(left: 0),
                              //                           child: Text(
                              //                             globaladdresslist[0].state,
                              //                             style: TextStyle(
                              //                                 fontSize: 15,
                              //                                 color: const Color.fromARGB(
                              //                                     255, 160, 160, 160)),
                              //                           ),
                              //                         ),
                              //                         Container(
                              //                           padding: EdgeInsets.only(left: 15),
                              //                           child: Text(
                              //                             globaladdresslist[0].city,
                              //                             style: TextStyle(
                              //                               fontSize: 15,
                              //                               color: const Color.fromARGB(
                              //                                   255, 160, 160, 160),
                              //                             ),
                              //                           ),
                              //                         ),
                              //                       ],
                              //                     )
                              //                   ],
                              //                 )
                              //               ],
                              //             )
                              //           ],
                              //         ),
                              //       ),
                              //     ),
                              //     Positioned(
                              //       right: 10,
                              //       top: 100,
                              //       child: IconButton(
                              //         onPressed: () {
                              //           print('address');
                              //           Navigator.pushNamed(context, 'address').then((result) {
                              //             loadaddress();
                              //           });
                              //         },
                              //         icon: Icon(
                              //           Icons.chevron_right,
                              //           size: 30,
                              //           color: Colors.green,
                              //         ),
                              //       ),
                              //     )
                              //   ],
                              // ),
                              SizedBox(
                                height: 5,
                              ),
                              SizedBox(
                                width: 328,
                                //   height: 200,
                                child: Container(
                                  constraints: BoxConstraints(
                                      maxHeight:
                                          (cartItemDetails.length * 130)),
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18),
                                    ),
                                    elevation: 0,
                                    shadowColor: Colors.grey.withOpacity(0.5),
                                    color: Colors.white,
                                    child: Column(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.only(
                                              left: 15, top: 10),
                                          child: Row(
                                            children: [
                                              Text(
                                                'Order Summary',
                                                style: TextStyle(fontSize: 20),
                                              ),
                                              SizedBox(
                                                width: 60,
                                              ),
                                              OutlinedButton(
                                                  style: ButtonStyle(
                                                    minimumSize:
                                                        WidgetStateProperty.all(
                                                            Size(100, 40)),
                                                    side:
                                                        WidgetStatePropertyAll(
                                                      BorderSide(
                                                          color: Colors.green,
                                                          width: 2),
                                                    ),
                                                  ),
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text(
                                                    'Add Items',
                                                    style: TextStyle(
                                                        color: Colors.green),
                                                  ))
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Container(
                                          height: 2,
                                          width: 270,
                                          color: const Color.fromARGB(
                                              255, 228, 223, 223),
                                        ),
                                        // SizedBox(
                                        //   height: ,
                                        // ),
                                        Expanded(
                                          child: SingleChildScrollView(
                                            physics:
                                                NeverScrollableScrollPhysics(), // Optional if content is fixed
                                            child: Column(
                                              children: [
                                                ListView.builder(
                                                    itemCount:
                                                        cartItemDetails.length,
                                                    shrinkWrap: true,
                                                    physics:
                                                        NeverScrollableScrollPhysics(),
                                                    itemBuilder:
                                                        (context, index) {
                                                      return Stack(
                                                        children: [
                                                          Container(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 15,
                                                                    top: 15,
                                                                    bottom: 15),
                                                            child: Row(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                // Image container
                                                                Container(
                                                                  height: 70,
                                                                  width: 70,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            230,
                                                                            225,
                                                                            225),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            15),
                                                                  ),
                                                                  child: Image
                                                                      .asset(
                                                                    cartItemDetails[
                                                                            index]
                                                                        .image,
                                                                    height: 80,
                                                                    width: 80,
                                                                    fit: BoxFit
                                                                        .cover,
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                    width: 15),
                                                                // Order details
                                                                Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    // SizedBox(
                                                                    //     height: 18),
                                                                    Text(
                                                                      cartItemDetails[
                                                                              index]
                                                                          .name, // Replace with the correct name property
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              18),
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                    ),
                                                                    SizedBox(
                                                                        height:
                                                                            5),
                                                                    Text(
                                                                      'Rs.${int.parse(cartItemDetails[index].rs)}', // Replace with the correct price property
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .green,
                                                                          fontSize:
                                                                              18),
                                                                    ),
                                                                    SizedBox(
                                                                      height:
                                                                          10,
                                                                    ),
                                                                    if (cartItemDetails[index]
                                                                            .toggle ==
                                                                        true)
                                                                      Row(
                                                                        children: [
                                                                          OutlinedButton(
                                                                            style: ButtonStyle(
                                                                                backgroundColor: WidgetStateProperty.all(Colors.green),
                                                                                minimumSize: WidgetStateProperty.all(
                                                                                  Size(25, 25),
                                                                                ),
                                                                                shape: WidgetStateProperty.all(
                                                                                  RoundedRectangleBorder(
                                                                                    borderRadius: BorderRadius.circular(50),
                                                                                  ),
                                                                                ),
                                                                                side: WidgetStatePropertyAll(BorderSide.none)),
                                                                            onPressed:
                                                                                () {
                                                                              decrementCount(index);

                                                                              if (cartItemDetails[index].itemCount == 0) {
                                                                                deleteCartItem(cartItemDetails[index].id);
                                                                              }
                                                                            },
                                                                            child:
                                                                                Icon(
                                                                              Icons.exposure_minus_1,
                                                                              color: Colors.white,
                                                                            ),
                                                                          ),
                                                                          SizedBox(
                                                                            width:
                                                                                10,
                                                                          ),
                                                                          OutlinedButton(
                                                                            style: ButtonStyle(
                                                                                backgroundColor: WidgetStateProperty.all(Colors.green),
                                                                                minimumSize: WidgetStateProperty.all(
                                                                                  Size(25, 25),
                                                                                ),
                                                                                shape: WidgetStateProperty.all(
                                                                                  RoundedRectangleBorder(
                                                                                    borderRadius: BorderRadius.circular(50),
                                                                                  ),
                                                                                ),
                                                                                side: WidgetStatePropertyAll(BorderSide.none)),
                                                                            onPressed:
                                                                                () {
                                                                              increment(index);
                                                                            },
                                                                            child:
                                                                                Icon(
                                                                              Icons.plus_one,
                                                                              color: Colors.white,
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      )
                                                                  ],
                                                                ),
                                                                SizedBox(
                                                                    width: 20),
                                                              ],
                                                            ),
                                                          ),
                                                          // Positioned edit button
                                                          Positioned(
                                                            right: 15,
                                                            top: 18,
                                                            child: Column(
                                                              children: [
                                                                SizedBox(
                                                                    height: 10),
                                                                // Quantity display
                                                                Container(
                                                                  height: 30,
                                                                  width: 30,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    border: Border.all(
                                                                        color: Colors
                                                                            .green,
                                                                        width:
                                                                            1),
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(7),
                                                                  ),
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  child: Text(
                                                                    '${cartItemDetails[index].itemCount}x',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .green),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                    height: 10),
                                                                // Edit button
                                                                GestureDetector(
                                                                  onTap: () {
                                                                    print(
                                                                        'Edit button tapped');

                                                                    _toggleEdit(
                                                                        index);
                                                                  },
                                                                  child: Icon(
                                                                      Icons
                                                                          .edit,
                                                                      color: Colors
                                                                          .green),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      );
                                                    })
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              SizedBox(
                                height: 165,
                                width: 328,
                                child: Card(
                                  elevation: 0,
                                  color: Colors.white,
                                  child: Column(
                                    children: [
                                      getLayout(
                                          'assets/svg/wallet2.svg',
                                          'Payment Methods',
                                          Container(
                                            padding: EdgeInsets.only(left: 60),
                                            child: Text(
                                              'E-Wallet',
                                              style: TextStyle(
                                                  color: Colors.green,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          null),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      BaseContainer(),
                                      getLayout(
                                          'assets/svg/offer.svg',
                                          'Get Discounts',
                                          isdiscountselected
                                              ? Row(
                                                  children: [
                                                    SizedBox(
                                                      width: 12,
                                                    ),
                                                    Stack(
                                                      children: [
                                                        Container(
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          22),
                                                              color:
                                                                  Colors.green),
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 8,
                                                                  right: 10,
                                                                  top: 5,
                                                                  bottom: 5),
                                                          child: Row(
                                                            children: [
                                                              Text(
                                                                'Discount $discountAmount  ',
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 15,
                                                                ),
                                                              ),
                                                              // IconButton(
                                                              //   onPressed: () {},
                                                              //   icon: Icon(
                                                              //     Icons.close,
                                                              //   ),
                                                              //   iconSize: 10,
                                                              // )
                                                            ],
                                                          ),
                                                        ),
                                                        Positioned(
                                                            top: -8,
                                                            right: -14,
                                                            child: IconButton(
                                                              onPressed: () {
                                                                setState(() {
                                                                  isdiscountselected =
                                                                      false;
                                                                  discountAmount =
                                                                      null;
                                                                });
                                                              },
                                                              icon: Icon(
                                                                Icons.close,
                                                              ),
                                                              iconSize: 10,
                                                            ))
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    )
                                                  ],
                                                )
                                              : SizedBox(
                                                  width: 130,
                                                ),
                                          pushtooffer),
                                      // Container(
                                      //   padding: EdgeInsets.only(left: 15, top: 15),
                                      //   child: Row(
                                      //     children: [
                                      //       SvgPicture.asset(
                                      //         'assets/svg/wallet2.svg',
                                      //         color: Colors.green,
                                      //       ),
                                      //       SizedBox(
                                      //         width: 5,
                                      //       ),
                                      //       Text(
                                      //         'Payment Methods',
                                      //         style: TextStyle(fontSize: 15),
                                      //       ),
                                      //       Container(
                                      //         padding: EdgeInsets.only(left: 60),
                                      //         child: Text(
                                      //           'E-Wallet',
                                      //           style: TextStyle(
                                      //               color: Colors.green,
                                      //               fontSize: 15,
                                      //               fontWeight: FontWeight.bold),
                                      //         ),
                                      //       ),
                                      //       IconButton(
                                      //         onPressed: () {},
                                      //         icon: Icon(
                                      //           Icons.chevron_right,
                                      //           size: 30,
                                      //           color: Colors.green,
                                      //         ),
                                      //       ),
                                      //     ],
                                      //   ),
                                      // ),
                                      // SizedBox(
                                      //   height: 10,
                                      // ),
                                      // BaseContainer(),
                                      // Container(
                                      //   padding: EdgeInsets.only(left: 15, top: 15),
                                      //   child: Row(
                                      //     children: [
                                      //       SvgPicture.asset(
                                      //         'assets/svg/offer.svg',
                                      //         color: Colors.green,
                                      //       ),
                                      //       SizedBox(
                                      //         width: 5,
                                      //       ),
                                      //       Text(
                                      //         'Get Discounts',
                                      //         style: TextStyle(fontSize: 15),
                                      //       ),
                                      //       SizedBox(
                                      //         width: 12,
                                      //       ),
                                      //       Container(
                                      //         decoration: BoxDecoration(
                                      //             borderRadius: BorderRadius.circular(22),
                                      //             color: Colors.green),
                                      //         padding: EdgeInsets.only(
                                      //             left: 8, right: 8, top: 5, bottom: 5),
                                      //         child: Row(
                                      //           children: [
                                      //             Text(
                                      //               'Discount 20%  ',
                                      //               style: TextStyle(
                                      //                 color: Colors.white,
                                      //                 fontSize: 15,
                                      //               ),
                                      //             ),
                                      //             Icon(
                                      //               Icons.close,
                                      //               size: 15,
                                      //             )
                                      //           ],
                                      //         ),
                                      //       ),
                                      //       IconButton(
                                      //         onPressed: () {},
                                      //         icon: Icon(
                                      //           Icons.chevron_right,
                                      //           size: 30,
                                      //           color: Colors.green,
                                      //         ),
                                      //       ),
                                      //     ],
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                            ],
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
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
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
              ),
            ),
            SizedBox(
              height: 212,
              width: 328,
              child: Card(
                color: Colors.white,
                elevation: 0,
                child: Column(
                  children: [
                    //  getRow("Subtotal", "Rs.${int.parse(order.rs) * count}"),
                    getRow("Subtotal",
                        "Rs.${cartItemDetails.fold(0, (sum, item) => sum + (int.parse(item.rs) * item.itemCount))}"),

                    getRow("Delivery Fee", "Rs.22"),
                    getRow("Promo",
                        "-Rs.${((cartItemDetails.fold(0, (sum, item) => sum + (int.parse(item.rs) * item.itemCount))) * (double.tryParse(discountAmount?.replaceAll('%', '') ?? "0") ?? 0) / 100).toStringAsFixed(2)}"),
                    SizedBox(
                      height: 20,
                    ),
                    BaseContainer(),
                    getRow("Total",
                        "Rs:${calculatediscount((cartItemDetails.fold(0, (sum, item) => sum + (int.parse(item.rs) * item.itemCount))), double.tryParse(discountAmount?.replaceAll('%', '') ?? "0") ?? 0) + 22}"),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 2,
              width: 355,
              color: const Color.fromARGB(255, 228, 223, 223),
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
                final double totalRs = calculatediscount(
                        (cartItemDetails.fold(
                            0,
                            (sum, item) =>
                                sum + (int.parse(item.rs) * item.itemCount))),
                        double.tryParse(
                                discountAmount?.replaceAll('%', '') ?? "0") ??
                            0) +
                    22;
                Navigator.pushNamed(context, 'address', arguments: {
                  'totalRs': totalRs,
                });
              },
              child: Text(
                'Select Address -  Rs:${calculatediscount((cartItemDetails.fold(0, (sum, item) => sum + (int.parse(item.rs) * item.itemCount))), double.tryParse(discountAmount?.replaceAll('%', '') ?? "0") ?? 0) + 22} ',
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ));
  }

  Container BaseContainer() {
    return Container(
      height: 2,
      width: 270,
      color: const Color.fromARGB(255, 228, 223, 223),
    );
  }

  Widget getRow(title, price) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20, top: 20),
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 15, color: Colors.grey),
          ),
          Spacer(),
          Text(
            price,
            style: TextStyle(fontSize: 15, color: Colors.grey),
          )
        ],
      ),
    );
  }

  Widget getLayout(imagepath, pOrD, widgetClass, function) {
    return Container(
      padding: EdgeInsets.only(left: 20, top: 15),
      child: Row(
        children: [
          SvgPicture.asset(
            imagepath,
            color: Colors.green,
          ),
          SizedBox(
            width: 5,
          ),
          Text(
            pOrD,
            style: TextStyle(fontSize: 15),
          ),
          widgetClass,
          // Container(
          //   padding: EdgeInsets.only(left: 60),
          //   child: Text(
          //     'E-Wallet',
          //     style: TextStyle(
          //         color: Colors.green,
          //         fontSize: 15,
          //         fontWeight: FontWeight.bold),
          //   ),
          // ),
          IconButton(
            onPressed: function,
            icon: Icon(
              Icons.chevron_right,
              size: 30,
              color: Colors.green,
            ),
          ),
        ],
      ),
    );
  }

  void pushtooffer() {
    Navigator.pushNamed(context, 'specialoffers').then((result) {
      setdiscount();
    });
  }
}
