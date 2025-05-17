import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
//import 'package:foodu/App/Homepage/subfolders/home.dart';
import 'package:foodu/Model/ItemModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class All extends StatefulWidget {
  List<discount>? retrivedDiscount;
  final Function(int)? toggleFavourite;

  All({super.key, this.retrivedDiscount, this.toggleFavourite});

  @override
  State<All> createState() => _AllState();
}

class _AllState extends State<All> {
  // late List<discount> retrivedDiscount;

  Future<void> _loadData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? jsonList = prefs.getStringList('favouriteList');
    if (jsonList == null) return;

    List<discount> discounts =
        jsonList.map((json) => discount.fromJson(jsonDecode(json))).toList();

    setState(() {
      widget.retrivedDiscount = discounts;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // widget.retrivedDiscount = widget.retrivedDiscount ?? [];
    _loadData();
  }

  // Future<List<discount>> getfavouriteList() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   List<String>? jsonList = prefs.getStringList('favouriteList');
  //   if (jsonList == null) return [];

  //   return jsonList.map((json) => discount.fromJson(jsonDecode(json))).toList();
  // }

  // Future<void> _loadData() async {
  //   List<discount> discounts = await getfavouriteList();
  //   setState(() {
  //     retrivedDiscount = discounts;
  //   });
  // }

  Future<void> _SaveItems(int index) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String>? jsonList = prefs.getStringList('favouriteList');
    if (jsonList == null || index >= jsonList.length) return;

    Map<String, dynamic> item = jsonDecode(jsonList[index]);

    item['isFavourite'] = widget.retrivedDiscount![index].isFavourite;
    jsonList[index] = jsonEncode(item);

    // List<String> jsonList = retrivedDiscount!
    //     .map((discount) => jsonEncode(discount.toJson()))
    //     .toList();

    await prefs.setStringList('favouriteList', jsonList);
  }

  void toggleFavourite(int index) {
    widget.toggleFavourite!(index);
    // setState(() {
    //   retrivedDiscount[index].isFavourite =
    //       !retrivedDiscount[index].isFavourite;
    // });

    // _SaveItems(index).then((_) {
    //   setState(() {});
    // });
    // _loadData();

    // setState(() {
    //   // Toggle the favourite state
    //   widget.retrivedDiscount![index].isFavourite =
    //       !widget.retrivedDiscount![index].isFavourite;
    // });

    // Save the updated state to SharedPreferences
    _SaveItems(index).then((_) {
      setState(() {}); // Rebuild the widget to apply the changes
    });
  }

  @override
  Widget build(BuildContext context) {
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
                itemCount: widget.retrivedDiscount!.length,
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
                                  widget.retrivedDiscount![index].image,
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
                                      widget.retrivedDiscount![index].name,
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
                                          '${widget.retrivedDiscount![index].items} | ',
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
                                          '${widget.retrivedDiscount![index].rating}  (${widget.retrivedDiscount![index].km}km',
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
                                          'Rs. ${widget.retrivedDiscount![index].rs}',
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
                                              child: widget
                                                          .retrivedDiscount![
                                                              index]
                                                          .isFavourite !=
                                                      true
                                                  ? SvgPicture.asset(
                                                      'assets/svg/heart.svg')
                                                  : SvgPicture.asset(
                                                      'assets/svg/heart2.svg'),
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
