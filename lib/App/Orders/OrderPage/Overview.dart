import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Overview extends StatelessWidget {
  const Overview({super.key});
  static const overview = 'overview';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        titleSpacing: 0,
        scrolledUnderElevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(left: 20),
            child: Text(
              'Big Garden Salad',
              style: TextStyle(fontSize: 30),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Center(
              child: Container(
                width: 320,
                height: 1,
                color: const Color.fromARGB(255, 207, 207, 207),
              ),
            ),
          ),
          Row(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Column(
                      children: [
                        Text(
                          '4.8',
                          style: TextStyle(
                              fontSize: 50, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            SvgPicture.asset(
                              'assets/svg/star.svg',
                              height: 30,
                              width: 30,
                            ),
                            SvgPicture.asset(
                              'assets/svg/star.svg',
                              height: 30,
                              width: 30,
                            ),
                            SvgPicture.asset(
                              'assets/svg/star.svg',
                              height: 30,
                              width: 30,
                            ),
                            SvgPicture.asset(
                              'assets/svg/star.svg',
                              height: 30,
                              width: 30,
                            ),
                            SvgPicture.asset(
                              'assets/svg/star.svg',
                              height: 30,
                              width: 30,
                            )
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          '(4.8k reviews)',
                          style: TextStyle(fontSize: 20),
                        )
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                height: 170,
                width: 1,
                color: const Color.fromARGB(255, 207, 207, 207),
              ),
              SizedBox(
                width: 15,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Text(
                        '5',
                        style: TextStyle(fontSize: 25),
                      ),
                      Text(
                        '4',
                        style: TextStyle(fontSize: 25),
                      ),
                      Text(
                        '3',
                        style: TextStyle(fontSize: 25),
                      ),
                      Text(
                        '2',
                        style: TextStyle(fontSize: 25),
                      ),
                      Text(
                        '1',
                        style: TextStyle(fontSize: 25),
                      )
                    ],
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: LinearProgressIndicator(
                          value: 0.5,
                          backgroundColor: Colors.grey,
                          valueColor: AlwaysStoppedAnimation(Colors.green),
                        ),
                      )
                    ],
                  )
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
