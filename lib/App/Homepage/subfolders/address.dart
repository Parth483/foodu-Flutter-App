// import 'package:flutter/material.dart';

// class Address extends StatefulWidget {
//   final Function(String) onCitySelected;
//   const Address({super.key, required this.onCitySelected});

//   @override
//   State<Address> createState() => _AddressState();
// }

// class _AddressState extends State<Address> {
//   final _items = [
//     'Ahmedabad',
//     'Surat',
//     'Baroda',
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Padding(
//           padding: EdgeInsets.all(16),
//         ),
//         Divider(),
//         ..._items.map((city) {
//           return ListTile(
//             title: Text(city),
//             onTap: () {
//               widget.onCitySelected(city);
//             },
//           );
//         })
//       ],
//     );
//   }
// }
