import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodu/Model/ItemModel.dart';

class Category extends StatefulWidget {
  const Category({super.key});
  static const category = 'category';

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  final List<ItemModel> _items = [
    ItemModel(name: "Burger", image: "assets/svg/food/burger.svg"),
    ItemModel(name: "Dessert", image: "assets/svg/food/dessert.svg"),
    ItemModel(name: "Drink", image: "assets/svg/food/drink.svg"),
    ItemModel(name: "Meat", image: "assets/svg/food/meat.svg"),
    ItemModel(name: "Noodles", image: "assets/svg/food/noodles.svg"),
    ItemModel(name: "Pizza", image: "assets/svg/food/pizza.svg"),
    ItemModel(name: "Vegetables", image: "assets/svg/food/vege.svg"),
    ItemModel(name: "Bread", image: "assets/svg/food/bread.svg"),
    ItemModel(name: 'Croissant', image: "assets/svg/food/croissant.svg"),
    ItemModel(name: 'Pancake', image: "assets/svg/food/pancake.svg"),
    ItemModel(name: 'Cheese', image: "assets/svg/food/cheese.svg"),
    ItemModel(name: 'French Fr..', image: "assets/svg/food/french_fri.svg"),
    ItemModel(name: 'Sandwich', image: "assets/svg/food/sandwich.svg"),
    ItemModel(name: 'Taco', image: "assets/svg/food/taco.svg"),
    ItemModel(name: 'Pot Of Food', image: "assets/svg/food/pot_of_food.svg"),
    ItemModel(name: 'Salad', image: "assets/svg/food/salad.svg"),
    ItemModel(name: 'Bento', image: "assets/svg/food/bento.svg"),
    ItemModel(name: 'Cooked Rice', image: "assets/svg/food/cooked_rice.svg"),
    ItemModel(name: 'Spaghetti', image: "assets/svg/food/spaghetti.svg"),
    ItemModel(name: 'Sushi', image: "assets/svg/food/sushi.svg"),
    ItemModel(name: 'Ice Cream', image: "assets/svg/food/ice_cream.svg"),
    ItemModel(name: 'Cookie', image: "assets/svg/food/cookie.svg"),
    ItemModel(name: 'Beverage', image: "assets/svg/food/beverage.svg"),
    ItemModel(name: 'Other', image: "assets/svg/food/more.svg"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        titleSpacing: 0,
        toolbarHeight: 70,
        title: Text(
          'More Category',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: SizedBox(
          child: Expanded(
              child: GridView.count(
            crossAxisCount: 4,
            children: List.generate(_items.length, (index) {
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
                      _items[index].image,
                      height: 35,
                      width: 35,
                    ),
                  ),
                  Text(
                    _items[index].name,
                    style: TextStyle(
                        fontFamily: 'Oswald', fontWeight: FontWeight.normal),
                  )
                ],
              );
            }),
          )),
        ),
      ),
    );
  }
}
