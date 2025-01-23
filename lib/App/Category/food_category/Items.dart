import 'package:flutter/material.dart';

class Items extends StatelessWidget {
  const Items({super.key});
  

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 8,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: Text('Recommended For You..'),
          toolbarHeight: 70,
          elevation: 0.0,
          shadowColor: Colors.transparent,
          bottom: PreferredSize(
              preferredSize: Size.fromHeight(40),
              child: Container(
                decoration: BoxDecoration(color: Colors.transparent),
                // margin: EdgeInsets.symmetric(horizontal: 8),
                child: Padding(
                  padding: EdgeInsets.zero,
                  child: TabBar(
                    isScrollable: true,
                    tabs: [
                      Tab(
                        text: 'All',
                      ),
                      Tab(
                        text: 'Burgers',
                      ),
                      Tab(
                        text: 'Desserts',
                      ),
                      Tab(
                        text: 'Noodles',
                      ),
                      Tab(
                        text: 'Dosa',
                      ),
                      Tab(
                        text: 'Drink',
                      ),
                      Tab(
                        text: 'Meat',
                      ),
                      Tab(
                        text: 'Pizza',
                      ),
                    ],
                    //   labelPadding: EdgeInsets.symmetric(horizontal: 16),
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: Colors.green),
                    indicatorPadding:
                        EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    unselectedLabelColor: Colors.grey,
                    labelColor: Colors.white,
                    splashFactory: NoSplash.splashFactory,
                    overlayColor: WidgetStatePropertyAll(Colors.transparent),
                  ),
                ),
              )),
        ),
      ),
    );
  }
}
