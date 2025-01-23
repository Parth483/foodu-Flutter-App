import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:foodu/Model/ItemModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Orderdetailsscreen extends StatefulWidget {
  const Orderdetailsscreen({super.key});
  static const orderdetails = 'orderdetails';

  @override
  State<Orderdetailsscreen> createState() => _OrderdetailsscreenState();
}

class _OrderdetailsscreenState extends State<Orderdetailsscreen> {
  // Retrieve the passed argument (Order model)

  Future<void> storeuniqueid(String id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String> cardIds = prefs.getStringList('cartkey') ?? [];
    print('Initial cart IDs: $cardIds');

    if (!cardIds.contains(id)) {
      cardIds.add(id);
      await prefs.setStringList('cartkey', cardIds);

      print('Added unique ID to cart: $id');
    } else {
      print('ID already exists in the cart: $id');
    }

    print('Updated cart IDs: ${prefs.getStringList('cartkey')}');
  }

  Widget getoutlinebutton(text, {routeto, id, order}) {
    return Expanded(
      child: SizedBox(
        height: 50,
        child: OutlinedButton(
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(Colors.green),
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(22),
              ),
            ),
            side: WidgetStateProperty.all(BorderSide.none),
          ),
          onPressed: () async {
            if (text == 'Add To Cart' && id != null) {
              await storeuniqueid(id);

              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('Added to Cart'),
                duration: Duration(seconds: 2),
              ));
            }

            // Navigate and pass 'order' if text is 'Order'
            if (text == 'Order' && routeto != null && routeto.isNotEmpty) {
              Navigator.pushNamed(context, routeto, arguments: order);
            }
            // Navigate if routeto is provided
            else if (routeto != null && routeto.isNotEmpty) {
              Navigator.pushNamed(context, routeto);
            }
          },
          child: Text(
            text,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final discount order =
        ModalRoute.of(context)!.settings.arguments as discount;

    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //   statusBarColor: Colors.transparent,
    //   statusBarIconBrightness: Brightness.light,
    // ));

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Image.asset(
                        order.image,
                        height: 300,
                        width: 400,
                        fit: BoxFit.cover,
                      ),
                      Positioned(
                          left: 10,
                          top: 30,
                          child: Row(
                            children: [
                              IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: Icon(
                                    Icons.arrow_back,
                                    color: Colors.white,
                                  )),
                              SizedBox(
                                width: 200,
                              ),
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    'assets/svg/heart.svg',
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  SvgPicture.asset(
                                    'assets/svg/message.svg',
                                    color: Colors.white,
                                  )
                                ],
                              ),
                            ],
                          ))
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        // color: Colors.amber,
                        margin: EdgeInsets.only(left: 20),
                        padding: EdgeInsets.only(bottom: 10),
                        // color: Colors.amber,
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                order.name,
                                style: TextStyle(fontSize: 30),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                          right: 10,
                          child: IconButton(
                            onPressed: () {
                              // Navigator.pushNamed(context, 'overview');
                            },
                            icon: Icon(
                              Icons.chevron_right,
                              size: 30,
                              color: Colors.grey,
                            ),
                          ))
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    height: 1,
                    width: 320,
                    color: const Color.fromARGB(255, 206, 205, 205),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        // color: Colors.amber,
                        margin: EdgeInsets.only(left: 20),
                        padding: EdgeInsets.only(bottom: 10),
                        // color: Colors.amber,
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              'assets/svg/star.svg',
                              height: 20,
                              width: 20,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              '4.8',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              '(4.8k Reviews)',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                          top: -10,
                          right: 12,
                          child: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.chevron_right,
                              size: 30,
                              color: Colors.grey,
                            ),
                          ))
                    ],
                  ),
                  // Container(
                  //   margin: EdgeInsets.only(
                  //     left: 20,
                  //     top: 5,
                  //   ),
                  //   child: Row(
                  //     children: [
                  //       SvgPicture.asset(
                  //         'assets/svg/star.svg',
                  //         height: 20,
                  //         width: 20,
                  //       ),
                  //       SizedBox(
                  //         width: 10,
                  //       ),
                  //       Text(
                  //         '4.8',
                  //         style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  //       ),
                  //       SizedBox(
                  //         width: 10,
                  //       ),
                  //       Text(
                  //         '(4.8k Reviews)',
                  //         style: TextStyle(color: Colors.grey),
                  //       ),
                  //       SizedBox(
                  //         width: 145,
                  //       ),
                  //       IconButton(
                  //         onPressed: () {},
                  //         icon: Icon(
                  //           Icons.chevron_right,
                  //           size: 30,
                  //           color: Colors.grey,
                  //         ),
                  //       )
                  //     ],
                  //   ),
                  // ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    height: 1,
                    width: 320,
                    color: const Color.fromARGB(255, 206, 205, 205),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        // color: Colors.amber,
                        margin: EdgeInsets.only(left: 20),
                        padding: EdgeInsets.only(bottom: 10),
                        // color: Colors.amber,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.location_on,
                              color: Colors.green,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              // mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  '2.4 km',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    Text('Delivery Now   |'),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    SvgPicture.asset(
                                      'assets/svg/scooter.svg',
                                      color: Colors.green,
                                      height: 20,
                                      width: 20,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      'Rs.150',
                                      style: TextStyle(
                                          color: const Color.fromARGB(
                                              255, 202, 202, 202)),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                          top: -10,
                          right: 14,
                          child: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.chevron_right,
                              size: 30,
                              color: Colors.grey,
                            ),
                          ))
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    height: 1,
                    width: 320,
                    color: const Color.fromARGB(255, 206, 205, 205),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        // color: Colors.amber,
                        margin: EdgeInsets.only(left: 20),
                        padding: EdgeInsets.only(bottom: 10),
                        // color: Colors.amber,
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              'assets/svg/offer.svg',
                              color: Colors.green,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Offers are available',
                              style: TextStyle(fontSize: 15),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                          top: -10,
                          right: 12,
                          child: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.chevron_right,
                              size: 30,
                              color: Colors.grey,
                            ),
                          ))
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    height: 1,
                    width: 320,
                    color: const Color.fromARGB(255, 206, 205, 205),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 250),
                    child: Text(
                      'For You',
                      style: TextStyle(
                        fontSize: 25,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      //crossAxisAlignment: CrossAxisAlignment.center,
                      //mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // SizedBox(
                        //   width: 10,
                        // ),
                        Expanded(
                          child: Card(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(22),
                            ),
                            elevation: 0,
                            shadowColor: Colors.grey.withOpacity(0.5),
                            // margin: EdgeInsets.only(left: 15),
                            child: Padding(
                              padding: EdgeInsets.all(12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Food Image Container
                                  Container(
                                    width: 130,
                                    height: 130,
                                    decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 230, 225, 225),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Image.asset(
                                      'assets/images/foods/burger.png',
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  // Food Title
                                  Text(
                                    'Salad 1',
                                    style: TextStyle(
                                      fontSize: 20,
                                      //   fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  // Rating Row

                                  // Price and Favorite Icon
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Rs.250',
                                        style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 99, 240, 71),
                                          fontSize: 15,
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Card(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(22),
                            ),
                            elevation: 0,
                            shadowColor: Colors.grey.withOpacity(0.5),
                            //  margin: EdgeInsets.only(left: 15),
                            child: Padding(
                              padding: EdgeInsets.all(12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Food Image Container
                                  Container(
                                    width: 130,
                                    height: 130,
                                    decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 230, 225, 225),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Image.asset(
                                      'assets/images/foods/burger.png',
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  // Food Title
                                  Text(
                                    'Salad 2',
                                    style: TextStyle(
                                      fontSize: 20,
                                      //   fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  // Rating Row

                                  // Price and Favorite Icon
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Rs.250',
                                        style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 99, 240, 71),
                                          fontSize: 15,
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),

                  Container(
                      margin: EdgeInsets.only(right: 270),
                      child: Text(
                        'Menu',
                        style: TextStyle(fontSize: 25),
                      )),
                  SizedBox(
                    height: 10,
                  ),

                  Card(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 0,
                    shadowColor: Colors.white,
                    margin: EdgeInsets.only(left: 20, right: 20),
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: 10, right: 10, top: 20, bottom: 20),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            //  color: Colors.blue,
                            padding: EdgeInsets.all(10),
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 230, 225, 225),
                                borderRadius: BorderRadius.circular(22)),
                            child: Image.asset(
                              'assets/images/foods/burger.png',
                              fit: BoxFit.cover,
                              width: 90,
                              height: 90,
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(
                                      left: 8, right: 8, top: 5, bottom: 5),
                                  decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Text(
                                    'New',
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.white),
                                  ),
                                ),
                                Text(
                                  'Burger',
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Rs. 250',
                                      style: TextStyle(
                                          color: const Color.fromARGB(
                                              255, 99, 240, 71),
                                          fontSize: 15,
                                          fontWeight: FontWeight.w900),
                                    ),
                                    // Flexible(
                                    //   child: Container(
                                    //     margin: EdgeInsets.only(left: 110),
                                    //     child: GestureDetector(
                                    //       onTap: () {
                                    //         print('heart');
                                    //       },
                                    //       child: SvgPicture.asset(
                                    //           'assets/svg/heart.svg'),
                                    //     ),
                                    //   ),
                                    // )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Card(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 0,
                    shadowColor: Colors.white,
                    margin: EdgeInsets.only(left: 20, right: 20),
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: 10, right: 10, top: 20, bottom: 20),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            //  color: Colors.blue,
                            padding: EdgeInsets.all(10),
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 230, 225, 225),
                                borderRadius: BorderRadius.circular(22)),
                            child: Image.asset(
                              'assets/images/foods/burger.png',
                              fit: BoxFit.cover,
                              width: 90,
                              height: 90,
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Container(
                                //   padding: EdgeInsets.only(
                                //       left: 8, right: 8, top: 5, bottom: 5),
                                //   decoration: BoxDecoration(
                                //       color: Colors.green,
                                //       borderRadius: BorderRadius.circular(10)),
                                //   child: Text(
                                //     'New',
                                //     style:
                                //         TextStyle(fontSize: 12, color: Colors.white),
                                //   ),
                                // ),
                                Text(
                                  'Burger',
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Rs. 250',
                                      style: TextStyle(
                                          color: const Color.fromARGB(
                                              255, 99, 240, 71),
                                          fontSize: 15,
                                          fontWeight: FontWeight.w900),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 20,
                  ),
                  // Column(
                  //   children: [
                  //     Container(
                  //       margin: EdgeInsets.only(
                  //         left: 20,
                  //         top: 5,
                  //       ),
                  //       child: Column(
                  //         children: [
                  //           Row(
                  //             children: [
                  //               Icon(
                  //                 Icons.location_on,
                  //                 color: Colors.green,
                  //               ),
                  //               SizedBox(
                  //                 width: 10,
                  //               ),
                  //               Text(
                  //                 '2.4 km',
                  //                 style: TextStyle(
                  //                     fontWeight: FontWeight.bold, fontSize: 15),
                  //               ),
                  //               SizedBox(
                  //                 width: 145,
                  //               ),
                  //             ],
                  //           ),
                  //           Row(
                  //             children: [
                  //               Text('Delivery Now   |'),
                  //               SizedBox(
                  //                 width: 10,
                  //               ),
                  //               SvgPicture.asset(
                  //                 'assets/svg/scooter.svg',
                  //                 color: Colors.green,
                  //                 height: 20,
                  //                 width: 20,
                  //               )
                  //             ],
                  //           )
                  //         ],
                  //       ),
                  //     ),
                  //   ],
                  // )
                ],
              ),
            ),
          ),
          Row(
            children: [
              SizedBox(
                width: 20,
              ),
              getoutlinebutton('Add To Cart', id: order.id),
              SizedBox(width: 20), // Space between the buttons
              getoutlinebutton('Order', routeto: 'checkout', order: order),
              SizedBox(
                width: 20,
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
