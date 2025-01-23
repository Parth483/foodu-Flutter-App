import 'package:flutter/material.dart';
//import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodu/App/Category/food_category/foods/all.dart';
import 'package:foodu/App/Category/food_category/foods/burgers.dart';
import 'package:foodu/App/Category/food_category/foods/desserts.dart';
import 'package:foodu/App/Category/food_category/foods/dosa.dart';
import 'package:foodu/App/Category/food_category/foods/drink.dart';
import 'package:foodu/App/Category/food_category/foods/meat.dart';
import 'package:foodu/App/Category/food_category/foods/noodles.dart';
import 'package:foodu/App/Category/food_category/foods/pizza.dart';
import 'package:foodu/Model/ItemModel.dart';

class Item3 extends StatefulWidget {
  const Item3({super.key});
  static const items = 'items';

  @override
  State<Item3> createState() => _Item3State();
}

class _Item3State extends State<Item3> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String Title = 'Recommended For You';

  bool _isSearchVisible = false;
  String _searchQuery = '';

  void _onSearchChanged(String query) {
    setState(() {
      _searchQuery = query;
    });
  }

  List<discount> _getSearchResults() {
    if (_searchQuery.isEmpty) {
      return discounts; // Return all items if search query is empty
    } else {
      // Filter by name or category
      return discounts.where((discount) {
        return discount.name
                .toLowerCase()
                .contains(_searchQuery.toLowerCase()) ||
            discount.category
                .toLowerCase()
                .contains(_searchQuery.toLowerCase());
      }).toList();
    }
  }

  final List<String> _titles = [
    'All',
    'Burgers',
    'Desserts',
    'Dosa',
    'Drinks',
    'Meat',
    'Noodles',
    'Pizza'
  ];

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 8, vsync: this);

    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        setState(() {
          Title = _titles[_tabController.index];
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: true,
            titleSpacing: 0,
            title: Text(Title),
            toolbarHeight: 70,
            actions: [
              Padding(
                padding: EdgeInsets.only(right: 30),
                child: GestureDetector(
                    onTap: () {
                      print('search');
                      setState(() {
                        _isSearchVisible = true;
                      });
                    },
                    child: Icon(Icons.search)),
              )
            ],
          ),
          body: Column(
            children: [
              _isSearchVisible
                  ? Row(
                      children: [
                        Flexible(
                          child: Container(
                            margin: EdgeInsets.only(
                              left: 20,
                            ),
                            child: TextField(
                              onChanged: _onSearchChanged,
                              decoration: InputDecoration(
                                  prefixIcon: Padding(
                                    padding: EdgeInsets.all(8),
                                    child: Icon(Icons.search),
                                  ),
                                  filled: true,
                                  fillColor:
                                      const Color.fromARGB(26, 185, 178, 178),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide.none)),
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              _isSearchVisible = false;
                              _searchQuery = '';
                            });
                          },
                          child: Text('Cancel'),
                        ),
                        SizedBox(
                          width: 10,
                        )
                      ],
                    )
                  : Container(
                      margin: EdgeInsets.only(left: 0),
                      padding: EdgeInsets.symmetric(horizontal: 0),
                      child: TabBar(
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
                          tabs: _titles
                              .map((title) => Tab(
                                    text: title,
                                  ))
                              .toList()),
                    ),
              Expanded(
                child: _isSearchVisible
                    ? ListView.builder(
                        itemCount: _getSearchResults().length,
                        itemBuilder: (context, index) {
                          final discount = _getSearchResults()[index];
                          return ListTile(
                            leading: Image.asset(
                              discount.image,
                              width: 50,
                              height: 50,
                            ),
                            title: Text(discount.name),
                            subtitle: Text(
                                '${discount.category} - Rs. ${discount.rs}'),
                            onTap: () {
                              print('Tapped on:${discount.name}');
                            },
                          );
                        },
                      )
                    : TabBarView(controller: _tabController, children: [
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
          )),
    );
  }
}
