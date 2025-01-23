import 'package:flutter/material.dart';
import 'package:foodu/Model/ItemModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Specialoffers extends StatefulWidget {
  const Specialoffers({super.key});
  static const specialoffers = 'specialoffers';

  //final String currentDiscount;

  @override
  State<Specialoffers> createState() => _SpecialoffersState();
}

class _SpecialoffersState extends State<Specialoffers> {
  final List<SpecialOffer> _specialoffer = [
    SpecialOffer(
      name: '30%',
      image: 'assets/images/home/ramen.png',
      color: Color.fromARGB(255, 120, 241, 126),
    ),
    SpecialOffer(
      name: '15%',
      image: 'assets/images/home/bowl1.png',
      color: Color.fromARGB(255, 163, 156, 55),
    ),
    SpecialOffer(
      name: '20%',
      image: 'assets/images/home/bowl2.png',
      color: Color.fromARGB(255, 241, 120, 120),
    ),
    SpecialOffer(
      name: '25%',
      image: 'assets/images/home/bowl3.png',
      color: Color.fromARGB(255, 120, 176, 241),
    )
  ];

  @override
  void initState() {
    super.initState();
  }

  Future<void> savediscount(String discount) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString('offer', discount);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        titleSpacing: 0,
        toolbarHeight: 70,
        title: Text(
          'Special Offers',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView.builder(
          itemCount: _specialoffer.length,
          itemBuilder: (context, index) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        print('click-');

                        await savediscount(_specialoffer[index].name);

                        Navigator.pop(context);
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        color: _specialoffer[index].color,
                        margin: EdgeInsets.only(left: 15, right: 15),
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment.centerRight,
                                child: Image.asset(
                                  _specialoffer[index].image,
                                  width: 120,
                                  height: 120,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 40),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                _specialoffer[index].name,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 50,
                                    fontWeight: FontWeight.w900),
                              ),
                              Text(
                                'DISCOUNT ONLY\nVALID FOR TODAY!',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w900),
                              )
                            ],
                          ),
                        )
                      ],
                    ))
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            );
          }),
    );
  }
}
