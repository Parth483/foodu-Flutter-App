import 'package:flutter/material.dart';
//import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodu/App/Orders/Active.dart';
import 'package:foodu/App/Orders/Cancelled.dart';
import 'package:foodu/App/Orders/Completed.dart';

class Order extends StatefulWidget {
  const Order({super.key});
  static const order = 'order';

  @override
  State<Order> createState() => _OrderState();
}

class _OrderState extends State<Order> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<String> _titles = [
    'Active',
    'Completed',
    'Cancelled',
  ];

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        titleSpacing: 0,
        title: Text('Orders'),
        leading: Padding(
          padding: const EdgeInsets.only(left: 8.0, top: 5),
          child: Image.asset(
            'assets/logo/logo6.png',
            height: 20,
            width: 20,
          ),
        ),
        bottom: TabBar(
          //isScrollable: true,
          //tabAlignment: TabAlignment.start,
          padding: EdgeInsets.all(5),
          indicatorSize: TabBarIndicatorSize.tab,
          //indicator: BoxDecoration(
          //     borderRadius: BorderRadius.circular(40), color: Colors.green),
          indicatorPadding: EdgeInsets.symmetric(horizontal: 3, vertical: 10),
          indicatorColor: Colors.green,
          unselectedLabelColor: Colors.grey,
          labelColor: Colors.green,
          dividerColor: Colors.transparent,
          splashFactory: NoSplash.splashFactory,
          overlayColor: WidgetStatePropertyAll(Colors.transparent),
          controller: _tabController,
          tabs: _titles
              .map((title) => Tab(
                    text: title,
                  ))
              .toList(),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              print('Text');
            },
            child: Padding(
                padding: EdgeInsets.only(right: 30), child: Icon(Icons.search)),
          )
        ],
      ),
      body: TabBarView(
        controller: _tabController, // Attach TabController to TabBarView
        children: [
          Active(),
          Completed(),
          Cancelled(),
        ],
      ),
    );
  }
}
