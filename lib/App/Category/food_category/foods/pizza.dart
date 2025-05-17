import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodu/Model/ItemModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Pizza extends StatefulWidget {
  const Pizza({super.key});

  @override
  State<Pizza> createState() => _PizzaState();
}

class _PizzaState extends State<Pizza> {
  List<discount> retrivedDiscount = [];

  Future<List<discount>> getfavouriteList() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? jsonList = prefs.getStringList('favouriteList');
    if (jsonList == null) return [];

    return jsonList.map((json) => discount.fromJson(jsonDecode(json))).toList();
  }

  Future<void> _loadData() async {
    List<discount> discounts = await getfavouriteList();
    setState(() {
      retrivedDiscount =
          discounts.where((item) => item.category == 'Pizza').toList();
    });
  }

  Future<void> _SaveItems(int index) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String>? jsonList = prefs.getStringList('favouriteList');
    if (jsonList == null || index >= jsonList.length) return;

    Map<String, dynamic> item = jsonDecode(jsonList[index]);

    item['isFavourite'] = retrivedDiscount[index].isFavourite;
    jsonList[index] = jsonEncode(item);

    // List<String> jsonList = retrivedDiscount!
    //     .map((discount) => jsonEncode(discount.toJson()))
    //     .toList();

    await prefs.setStringList('favouriteList', jsonList);
  }

  void toggleFavourite(int index) {
    setState(() {
      retrivedDiscount[index].isFavourite =
          !retrivedDiscount[index].isFavourite;
    });

    _SaveItems(index);
    _loadData();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    // final List<discount> burger =
    //     discounts.where((discount) => discount.category == 'Burger').toList();

    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: ListView.builder(
                itemCount: retrivedDiscount.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        elevation: 1,
                        shadowColor: Colors.white,
                        margin: EdgeInsets.only(left: 10, right: 10),
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
                                    color: const Color.fromARGB(
                                        255, 230, 225, 225),
                                    borderRadius: BorderRadius.circular(22)),
                                child: Image.asset(
                                  retrivedDiscount[index].image,
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
                                    Text(
                                      retrivedDiscount[index].name,
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w900),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${discounts[index].items} | ',
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w900),
                                        ),
                                        SvgPicture.asset(
                                          'assets/svg/star.svg',
                                          height: 22,
                                          width: 22,
                                        ),
                                        Text(
                                          '${retrivedDiscount[index].rating}  (${retrivedDiscount[index].km}km',
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w900),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Rs. ${retrivedDiscount[index].rs}',
                                          style: TextStyle(
                                              color: const Color.fromARGB(
                                                  255, 99, 240, 71),
                                              fontSize: 15,
                                              fontWeight: FontWeight.w900),
                                        ),
                                        Flexible(
                                          child: Container(
                                            margin: EdgeInsets.only(left: 110),
                                            child: GestureDetector(
                                              onTap: () {
                                                toggleFavourite(index);
                                              },
                                              child: retrivedDiscount[index]
                                                          .isFavourite !=
                                                      true
                                                  ? SvgPicture.asset(
                                                      'assets/svg/heart.svg',
                                                      height: 24,
                                                      width: 24,
                                                    )
                                                  : SvgPicture.asset(
                                                      'assets/svg/heart2.svg',
                                                      height: 24,
                                                      width: 24,
                                                    ),
                                            ),
                                          ),
                                        )
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
                    ],
                  );
                }),
          )
        ],
      ),
    ));
  }
}
