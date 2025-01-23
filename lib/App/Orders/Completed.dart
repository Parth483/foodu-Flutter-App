import 'package:flutter/material.dart';
import 'package:foodu/Model/ItemModel.dart';

class Completed extends StatefulWidget {
  const Completed({super.key});

  @override
  State<Completed> createState() => _CompletedState();
}

class _CompletedState extends State<Completed> {
  final List<discount> _items =
      discounts.where((discount) => discount.category == 'Burger').toList();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
              child: ListView.builder(
                  itemCount: _items.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Card(
                          elevation: 0,
                          margin: EdgeInsets.only(left: 15, right: 15),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: 10,
                                        right: 10,
                                        top: 10,
                                        bottom: 0),
                                    child: Row(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                              color: const Color.fromARGB(
                                                  255, 230, 225, 225),
                                              borderRadius:
                                                  BorderRadius.circular(22)),
                                          padding: EdgeInsets.all(8),
                                          child: Image.asset(
                                            _items[index].image,
                                            height: 80,
                                            width: 80,
                                          ),
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(
                                                  left: 20, bottom: 10),
                                              child: Text(
                                                _items[index].name,
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(
                                                  left: 20, bottom: 10),
                                              child: Text(
                                                '${_items[index].items}items | ${_items[index].km}km',
                                                style: TextStyle(
                                                    color: Colors.grey),
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Container(
                                                  margin:
                                                      EdgeInsets.only(left: 20),
                                                  child: Text(
                                                    'Rs.${_items[index].rs}',
                                                    style: TextStyle(
                                                        color: Colors.green,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 20),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Container(
                                                    padding: EdgeInsets.only(
                                                        left: 10,
                                                        right: 10,
                                                        top: 2,
                                                        bottom: 2),
                                                    decoration: BoxDecoration(
                                                        color: Colors.green,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                                    child: Text(
                                                      'Completed',
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ))
                                              ],
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.symmetric(vertical: 10),
                                    height: 1,
                                    width: 320,
                                    color: const Color.fromARGB(
                                        255, 228, 225, 225),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      OutlinedButton(
                                        style: ButtonStyle(
                                          fixedSize: WidgetStatePropertyAll(
                                            Size(150, 20),
                                          ),
                                          side: WidgetStatePropertyAll(
                                            BorderSide(
                                                color: Colors.green,
                                                width: 2.0,
                                                style: BorderStyle.solid),
                                          ),
                                          backgroundColor:
                                              WidgetStateProperty.resolveWith(
                                            (states) {
                                              if (states.contains(
                                                  WidgetState.pressed)) {
                                                return Colors.green;
                                              }
                                              return Colors.transparent;
                                            },
                                          ),
                                          foregroundColor:
                                              WidgetStateProperty.resolveWith(
                                            (states) {
                                              if (states.contains(
                                                  WidgetState.pressed)) {
                                                return Colors.white;
                                              }
                                              return Colors.green;
                                            },
                                          ),
                                        ),
                                        onPressed: () {},
                                        child: Text(
                                          'Leave a Review',

                                          ///   style: TextStyle(color: Colors.green),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      OutlinedButton(
                                        style: ButtonStyle(
                                          fixedSize: WidgetStatePropertyAll(
                                            Size(150, 20),
                                          ),
                                          side: WidgetStatePropertyAll(
                                            BorderSide(
                                                color: Colors.green,
                                                width: 2.0,
                                                style: BorderStyle.solid),
                                          ),
                                          backgroundColor:
                                              WidgetStateProperty.resolveWith(
                                            (states) {
                                              if (states.contains(
                                                  WidgetState.pressed)) {
                                                return Colors.green;
                                              }
                                              return Colors.transparent;
                                            },
                                          ),
                                          foregroundColor:
                                              WidgetStateProperty.resolveWith(
                                            (states) {
                                              if (states.contains(
                                                  WidgetState.pressed)) {
                                                return Colors.white;
                                              }
                                              return Colors.green;
                                            },
                                          ),
                                        ),
                                        onPressed: () {},
                                        child: Text('Order Again'),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    );
                  }))
        ],
      )),
    );
  }
}
