import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class ItemModel {
  final String name;
  final String image;

  ItemModel({required this.name, required this.image});
}

class CartItem {
  final String name;
  final String image;
  final String itemcount;
  final String km;
  final String rs;

  CartItem(
      {required this.name,
      required this.image,
      required this.itemcount,
      required this.km,
      required this.rs});
}

class SpecialOffer {
  final String name;
  final String image;
  final Color color;

  SpecialOffer({required this.name, required this.image, required this.color});
}

class notifications {
  final String title;
  final String icon;
  final String time;
  final String newm;
  final String message;
  final Color color;
  final bool newmessage;

  notifications(
      {required this.title,
      required this.icon,
      required this.time,
      required this.newm,
      required this.message,
      required this.color,
      required this.newmessage});
}

class discount {
  final String id;
  final String name;
  final String image;
  final String items;
  final String rating;
  final String km;
  final String rs;
  final String category;
  int itemCount;
  bool toggle;

  discount(
      {required this.id,
      required this.name,
      required this.image,
      required this.items,
      required this.rating,
      required this.km,
      required this.rs,
      required this.category,
      required this.itemCount,
      required this.toggle});
}

final List<discount> discounts = [
  discount(
      id: "1",
      name: 'Special Burger',
      image: 'assets/images/foods/burger2.png',
      items: '1',
      rating: '4.8',
      km: '2',
      rs: '150',
      category: 'Burger',
      itemCount: 1,
      toggle: false),
  discount(
      id: '2',
      name: 'Dessert',
      image: 'assets/images/foods/dessert.png',
      items: '1',
      rating: '4.1',
      km: '8',
      rs: '370',
      category: 'Dessert',
      itemCount: 1,
      toggle: false),
  discount(
      id: '3',
      name: 'Noodles',
      image: 'assets/images/foods/noodles.png',
      items: '1',
      rating: '4.2',
      km: '13',
      rs: '410',
      category: 'Noodles',
      itemCount: 1,
      toggle: false),
  discount(
      id: '4',
      name: 'Drink',
      image: 'assets/images/foods/drink.png',
      items: '1',
      rating: '3.8',
      km: '12',
      rs: '370',
      category: 'Drink',
      itemCount: 1,
      toggle: false),
  discount(
      id: '5',
      name: 'Dosa',
      image: 'assets/images/foods/dosa.png',
      items: '1',
      rating: '4.6',
      km: '9',
      rs: '770',
      category: 'Dosa',
      itemCount: 1,
      toggle: false),
  discount(
      id: '6',
      name: 'Meat',
      image: 'assets/images/foods/meat.png',
      items: '1',
      rating: '4.0',
      km: '1',
      rs: '870',
      category: 'Meat',
      itemCount: 1,
      toggle: false),
  discount(
      id: '7',
      name: 'Pizza',
      image: 'assets/images/foods/pizza.png',
      items: '1',
      rating: '4.5',
      km: '10',
      rs: '170',
      category: 'Pizza',
      itemCount: 1,
      toggle: false),
  discount(
      id: '8',
      name: 'Burger',
      image: 'assets/images/foods/burger.png',
      items: '1',
      rating: '4.8',
      km: '2',
      rs: '150',
      category: 'Burger',
      itemCount: 1,
      toggle: false),
];

class Addresss {
  final String id;
  final String state;
  final String city;
  final String addresss;
  final String type;

  Addresss(
      {required this.id,
      required this.state,
      required this.city,
      required this.addresss,
      required this.type});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'state': state,
      'city': city,
      'address': addresss,
      'type': type,
    };
  }

  factory Addresss.fromJson(Map<String, dynamic> json) {
    return Addresss(
      id: json['id'],
      state: json['state'],
      city: json['city'],
      addresss: json['address'],
      type: json['type'],
    );
  }
}
