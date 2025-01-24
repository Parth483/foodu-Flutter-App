import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodu/App/Category/food_category/foods/all.dart';
import 'package:foodu/App/Category/food_category/foods/burgers.dart';
import 'package:foodu/App/Category/food_category/foods/desserts.dart';
import 'package:foodu/App/Category/food_category/foods/dosa.dart';
import 'package:foodu/App/Category/food_category/foods/drink.dart';
import 'package:foodu/App/Category/food_category/foods/meat.dart';
import 'package:foodu/App/Category/food_category/foods/noodles.dart';
import 'package:foodu/App/Category/food_category/foods/pizza.dart';
//import 'package:foodu/App/Category/food_category/item3.dart';
//import 'package:foodu/App/Homepage/subfolders/address.dart';
//import 'package:foodu/App/Category/category.dart';
import 'package:foodu/Model/ItemModel.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class Home extends StatefulWidget {
  const Home({super.key, this.imagefile});
  static const home = 'home';
  final XFile? imagefile;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  String _dropdownvalue = 'Ahmedabad';
  final _items = [
    'Ahmedabad',
    'Surat',
    'Baroda',
  ];

  final List<ItemModel> items = [
    ItemModel(name: "Burger", image: "assets/svg/food/burger.svg"),
    ItemModel(name: "Dessert", image: "assets/svg/food/dessert.svg"),
    ItemModel(name: "Drink", image: "assets/svg/food/drink.svg"),
    ItemModel(name: "Meat", image: "assets/svg/food/meat.svg"),
    ItemModel(name: "Noodles", image: "assets/svg/food/noodles.svg"),
    ItemModel(name: "Pizza", image: "assets/svg/food/pizza.svg"),
    ItemModel(name: "Vegetables", image: "assets/svg/food/vege.svg"),
    ItemModel(name: "Bread", image: "assets/svg/food/bread.svg"),
  ];

  final List<String> _title = [
    'All',
    'Burgers',
    'Desserts',
    'Dosa',
    'Drinks',
    'Meat',
    'Noodles',
    'Pizza'
  ];

  // String? imagepath;
  // XFile? _imagefile;

  late TabController _tabController;

  // Future<void> getdata() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();

  //   setState(() {
  //     imagepath = prefs.getString('image');
  //     if (imagepath != null) {
  //       _imagefile = XFile(imagepath!);
  //     }
  //   });
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 8, vsync: this);
    // getdata();
  }
  //String _selectedCity = 'Ahmedabad';

  // void _showCitySelector() {
  //   showModalBottomSheet(
  //       context: context,
  //       shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
  //       builder: (BuildContext context) {
  //         return Address(onCitySelected: (city) {
  //           setState(() {
  //             _selectedCity = city;
  //           });
  //         });
  //       });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        scrolledUnderElevation: 0,
        toolbarHeight: 15.h,
        backgroundColor: Colors.white10,
        flexibleSpace: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                margin: EdgeInsets.only(top: 7.h, right: 2.w),
                child: widget.imagefile != null &&
                        widget.imagefile!.path.isNotEmpty
                    ? ClipOval(
                        child: Image.file(
                          File(widget.imagefile!.path),
                          width: 12.w,
                          height: 12.w,
                          fit: BoxFit.cover,
                        ),
                      )
                    : Icon(
                        Icons.account_circle,
                        size: 10.w,
                      )),
            Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 40, right: 50, left: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Deliver to',
                        style: TextStyle(fontSize: 15, color: Colors.grey),
                      ),
                      DropdownButton(
                        items: _items.map((String item) {
                          return DropdownMenuItem(
                            value: item,
                            child: Text(item),
                          );
                        }).toList(),
                        underline: Container(
                          height: 2,
                          color: Colors.transparent,
                        ),
                        onChanged: (String? newValue) {
                          setState(() {
                            _dropdownvalue = newValue!;
                          });
                        },
                        value: _dropdownvalue,
                        isDense: true,
                        //dropdownColor: Colors.transparent,
                      ),
                      // SizedBox(
                      //   child: GestureDetector(
                      //     onTap: _showCitySelector,
                      //     child: Row(
                      //       children: [
                      //         Text(
                      //           overflow: TextOverflow.ellipsis,
                      //           _selectedCity,
                      //           style: TextStyle(
                      //               fontSize: 16,
                      //               color: Colors.black,
                      //               fontWeight: FontWeight.bold),
                      //         ),
                      //         Icon(Icons.keyboard_arrow_down)
                      //       ],
                      //     ),
                      //   ),
                      // )
                    ],
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(left: 10, top: 50),
              child: OutlinedButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'notification');
                },
                style: OutlinedButton.styleFrom(
                  shape: CircleBorder(),
                  side: BorderSide(
                    color: Color.fromARGB(255, 219, 219, 219),
                    width: 1,
                  ),
                  padding: EdgeInsets.zero,
                ),
                child: SvgPicture.asset(
                  'assets/svg/bell.svg',
                  height: 20,
                  width: 20,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 50),
              child: OutlinedButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'checkout');
                },
                style: OutlinedButton.styleFrom(
                  shape: CircleBorder(),
                  side: BorderSide(
                    color: Color.fromARGB(255, 219, 219, 219),
                    width: 1,
                  ),
                  padding: EdgeInsets.zero,
                ),
                child: SvgPicture.asset(
                  'assets/svg/shop.svg',
                  height: 20,
                  width: 20,
                ),
              ),
            ),
          ],
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.all(15),
                child: TextFormField(
                  decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(10),
                        child: Icon(Icons.search),
                      ),
                      hintText: 'What are you craving?',
                      filled: true,
                      fillColor: const Color.fromARGB(26, 185, 178, 178),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(13),
                          borderSide: BorderSide.none)),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 20),
                    child: Text(
                      'Speacial Offers',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(left: 140),
                      child: TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, 'specialoffers');
                          },
                          child: Text(
                            'See All',
                            style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold),
                          ))),
                ],
              ),
              Stack(
                children: [
                  GestureDetector(
                    onTap: () {
                      print('Click-');
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 1,
                      color: const Color.fromARGB(255, 120, 241, 126),
                      margin: EdgeInsets.only(left: 15, right: 15),
                      child: Container(
                          padding:
                              EdgeInsets.only(left: 170, top: 10, right: 10),
                          child: Image.asset(
                            'assets/images/foods/burger6.png',
                          )),
                    ),
                  ),
                  Positioned(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          margin: EdgeInsets.only(left: 45, top: 14),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '30%',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 40,
                                    fontWeight: FontWeight.w900),
                              ),
                              Text(
                                'DISCOUNT ONLY\nVALID FOR TODAY!',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w900),
                              ),
                            ],
                          )),
                    ],
                  ))
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 20),
                    child: Text(
                      'More Category',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(left: 140),
                      child: TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, 'category');
                          },
                          child: Text(
                            'See All',
                            style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold),
                          ))),
                ],
              ),
              SizedBox(
                height: 200,
                child: GridView.count(
                  physics: NeverScrollableScrollPhysics(), // Disable scrolling
                  shrinkWrap:
                      true, // Ensures GridView takes only necessary space
                  crossAxisCount: 4, // Number of items in one row
                  children: List.generate(items.length, (index) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        OutlinedButton(
                          onPressed: () {
                            print('burger');
                          },
                          style: OutlinedButton.styleFrom(
                              shape: CircleBorder(),
                              side: BorderSide.none,
                              minimumSize: Size(70, 70)),
                          child: SvgPicture.asset(
                            items[index].image,
                            height: 35,
                            width: 35,
                          ),
                        ),
                        Text(
                          items[index].name,
                          style: TextStyle(
                              fontFamily: 'Oswald',
                              fontWeight: FontWeight.normal),
                        )
                      ],
                    );
                  }),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 20),
                    child: Text(
                      'Discount Guaranteed!',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(left: 80),
                      child: TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, 'items');
                          },
                          child: Text(
                            'See All',
                            style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold),
                          ))),
                ],
              ),
              SizedBox(
                //padding: EdgeInsets.all(8),
                //  color: Colors.amber,
                height: 280,
                child: ListView.builder(
                  itemCount: discounts.length,
                  scrollDirection: Axis.horizontal,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, 'orderdetails',
                            arguments: discounts[index]);
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 0,
                        shadowColor: Colors.grey.withOpacity(0.5),
                        margin: EdgeInsets.only(left: 15),
                        child: Padding(
                          padding: EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Food Image Container
                              Container(
                                width: 150,
                                height: 150,
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 230, 225, 225),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Image.asset(
                                  discounts[index].image,
                                  fit: BoxFit.contain,
                                ),
                              ),
                              SizedBox(height: 10),
                              // Food Title
                              Text(
                                discounts[index].name,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              SizedBox(height: 5),
                              // Rating Row
                              Row(
                                children: [
                                  Text(
                                    '${discounts[index].km}km   | ',
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                  SvgPicture.asset(
                                    'assets/svg/star.svg',
                                    height: 20,
                                    width: 20,
                                  ),
                                  Text(
                                    '${discounts[index].rating}  (1.2k)',
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              // Price and Favorite Icon
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Rs. ${discounts[index].rs}',
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 99, 240, 71),
                                      fontSize: 15,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 70,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      print('heart');
                                    },
                                    child: SvgPicture.asset(
                                      'assets/svg/heart.svg',
                                      height: 24,
                                      width: 24,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 20),
                    child: Text(
                      'Recommended For You',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 80),
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, 'items');
                      },
                      child: Text(
                        'See All',
                        style: TextStyle(
                            color: Colors.green, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                height: 300,
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    TabBar(
                        isScrollable: true,
                        padding: EdgeInsets.all(0),
                        tabAlignment: TabAlignment.start,
                        dividerColor: Colors.transparent,
                        controller: _tabController,
                        indicatorSize: TabBarIndicatorSize.tab,
                        indicator: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            color: Colors.green),
                        indicatorPadding:
                            EdgeInsets.symmetric(horizontal: 3, vertical: 8),
                        unselectedLabelColor: Colors.grey,
                        labelColor: Colors.white,
                        splashFactory: NoSplash.splashFactory,
                        overlayColor:
                            WidgetStatePropertyAll(Colors.transparent),
                        tabs: _title
                            .map((title) => Tab(
                                  text: title,
                                ))
                            .toList()),
                    Expanded(
                      child: TabBarView(controller: _tabController, children: [
                        All(),
                        Burgers(),
                        Desserts(),
                        Dosa(),
                        Drink(),
                        Meat(),
                        Noodles(),
                        Pizza(),
                      ]),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
