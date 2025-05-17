import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foodu/Model/ItemModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Favourite extends StatefulWidget {
  const Favourite({super.key});
  static const favourite = 'favourite';

  @override
  State<Favourite> createState() => _FavouriteState();
}

class _FavouriteState extends State<Favourite> {
  bool _isSearchVisible = false;
  bool isloading = false;

  // final List<int> _list = [
  //   1,
  //   2,
  //   3,
  // ];

  List<discount> retrivedDiscount = [];

  Future<List<discount>> getfavouriteList() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? jsonList = prefs.getStringList('favouriteList');
    if (jsonList == null) return [];

    return jsonList.map((json) => discount.fromJson(jsonDecode(json))).toList();
  }

  Future<void> _SaveItems(int index) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    // Fetch the existing list
    List<String>? jsonList = prefs.getStringList('favouriteList');
    if (jsonList == null || index >= jsonList.length) return;

    // Update the specific item in the list
    Map<String, dynamic> item = jsonDecode(jsonList[index]);
    item['isFavourite'] = retrivedDiscount[index].isFavourite;
    jsonList[index] = jsonEncode(item);

    // Save the updated list back to SharedPreferences
    await prefs.setStringList('favouriteList', jsonList);
    print('Updated SharedPreferences: $jsonList');
  }

  Future<void> _loadData() async {
    final List<discount> discounts = await getfavouriteList();
    setState(() {
      retrivedDiscount =
          discounts.where((item) => item.isFavourite == true).toList();
      isloading = true;
    });
    print('Items loaded successfully');
  }

  void toggleFavourite(int index) {
    setState(() {
      retrivedDiscount[index].isFavourite =
          !retrivedDiscount[index].isFavourite;
    });
    print('Item toggled: ${retrivedDiscount[index].isFavourite}');

    // Save the updated list to SharedPreferences
    _SaveItems(index).then((_) {
      // After saving the item, reload the data to reflect the changes
      _loadData();
    });
  }

  @override
  void initState() {
    super.initState();

    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Padding(
            padding: EdgeInsets.only(left: 20), child: Text('Favourites')),
        titleSpacing: 0,
        toolbarHeight: 70,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 30),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _isSearchVisible = true;
                });
              },
              child: Icon(Icons.search),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          if (_isSearchVisible)
            Row(
              children: [
                Flexible(
                  child: Container(
                    margin: EdgeInsets.only(left: 20),
                    child: TextField(
                      decoration: InputDecoration(
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(8),
                          child: Icon(Icons.search),
                        ),
                        filled: true,
                        fillColor: const Color.fromARGB(26, 185, 178, 178),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide.none),
                      ),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      _isSearchVisible = false;
                    });
                  },
                  child: Text('Cancel'),
                ),
                SizedBox(
                  width: 10,
                )
              ],
            ),
          SizedBox(
            height: 20,
          ),
          Flexible(
            child: isloading != true || retrivedDiscount.isEmpty
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    itemCount: retrivedDiscount.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, 'orderdetails',
                              arguments: retrivedDiscount[index]);
                        },
                        child: Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Food Image Container
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 230, 225, 225),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Image.asset(
                                    retrivedDiscount[index].image,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                SizedBox(height: 10),
                                // Food Title
                                Text(
                                  retrivedDiscount[index].name,
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
                                      '${retrivedDiscount[index].km}km   | ',
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
                                      '${retrivedDiscount[index].rating}  (1.2k)',
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
                                      'Rs. ${retrivedDiscount[index].rs}',
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
                                        toggleFavourite(index);
                                      },
                                      child:
                                          retrivedDiscount[index].isFavourite !=
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
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
          ),
        ],
      ),
    );
  }
}
