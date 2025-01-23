import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodu/Model/ItemModel.dart';

class Noodles extends StatelessWidget {
  const Noodles({super.key});

  @override
  Widget build(BuildContext context) {
    final List<discount> noodles =
        discounts.where((discount) => discount.category == 'Noodles').toList();

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
                itemCount: noodles.length,
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
                                  noodles[index].image,
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
                                      noodles[index].name,
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
                                          '${noodles[index].items} | ',
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
                                          '${noodles[index].rating}  (${noodles[index].km}km',
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
                                          'Rs. ${noodles[index].rs}',
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
                                                print('heart');
                                              },
                                              child: SvgPicture.asset(
                                                  'assets/svg/heart.svg'),
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
