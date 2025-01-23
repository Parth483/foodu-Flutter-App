import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodu/Model/ItemModel.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key});
  static const notification = 'notification';

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  bool newmessage = false;
  final List<notifications> _notification = [
    notifications(
        title: 'Order Cancelled!',
        icon: 'assets/svg/close.svg',
        time: '19 Dec 2022 | 20:50 PM',
        newm: 'New',
        message:
            'You have canceled on order at Burger Hut, We apologzie for your inconvenience We will try to improve our service next time',
        color: Color.fromARGB(255, 255, 223, 222),
        newmessage: true),
    notifications(
        title: 'Order Successful!',
        icon: 'assets/svg/shop.svg',
        time: '19 Dec 2022 | 20:49 PM',
        newm: 'New',
        message:
            'You have placed an order of Burger Hut and paid 24.Your food will arrive soon. Enjoy our services',
        color: const Color.fromARGB(255, 245, 255, 222),
        newmessage: true),
    notifications(
        title: 'New Services Available!',
        icon: 'assets/svg/star.svg',
        time: '14 Dec 2022 | 10:52 AM',
        newm: '',
        message:
            'You can make multiple food orders at one time. You can also cancel your orders.',
        color: const Color.fromARGB(255, 255, 249, 222),
        newmessage: false),
    notifications(
        title: 'Credit Card Connected!',
        icon: 'assets/svg/wallet.svg',
        time: '12 Dec 2022 | 10:50 AM',
        newm: '',
        message:
            'Your credit card has been successfully linked with Foodu.Enjoy our sevices.',
        color: const Color.fromARGB(255, 222, 248, 255),
        newmessage: false),
    notifications(
        title: 'Account Setup Successful!',
        icon: 'assets/svg/user.svg',
        time: '12 Dec 2022 | 20:50 PM',
        newm: '',
        message:
            'You have canceled on order at Burger Hut, We apologzie for your inconvenience We will try to improve our service next time',
        color: const Color.fromARGB(255, 223, 255, 222),
        newmessage: false),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            scrolledUnderElevation: 0,
            backgroundColor: Colors.white10,
            automaticallyImplyLeading: true,
            title: Text('Notifications'),
            titleSpacing: 0,
            toolbarHeight: 70,
            actions: [
              Padding(
                padding: EdgeInsets.only(right: 30),
                child: SvgPicture.asset(
                  'assets/svg/dot.svg',
                  height: 25,
                  width: 25,
                ),
              ),
            ]),
        body: ListView.builder(
            itemCount: _notification.length,
            itemBuilder: (context, index) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 15),
                    child: Container(
                      padding: EdgeInsets.all(1),
                      child: Slidable(
                        endActionPane:
                            ActionPane(motion: StretchMotion(), children: [
                          SlidableAction(
                            onPressed: (context) {
                              print('Item Deleted');
                            },
                            icon: Icons.delete,
                            borderRadius: BorderRadius.circular(15),
                            backgroundColor: _notification[index].color,
                          )
                        ]),
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(8),
                              child: Row(
                                children: [
                                  ClipOval(
                                    child: Container(
                                      padding: EdgeInsets.all(15),
                                      decoration: BoxDecoration(
                                          color: _notification[index].color),
                                      child: SvgPicture.asset(
                                        _notification[index].icon,
                                        height: 30,
                                        width: 30,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        _notification[index].title,
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            _notification[index].time,
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 13),
                                          ),
                                          _notification[index].newmessage
                                              ? Container(
                                                  margin:
                                                      EdgeInsets.only(left: 80),
                                                  padding: EdgeInsets.only(
                                                      left: 8,
                                                      right: 8,
                                                      top: 5,
                                                      bottom: 5),
                                                  decoration: BoxDecoration(
                                                      color: Colors.green,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  child: Text(
                                                    _notification[index].newm,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 10),
                                                  ),
                                                )
                                              : SizedBox.shrink()
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                _notification[index].message,
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              );
            }));
  }
}
