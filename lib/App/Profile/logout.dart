import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Logout extends StatefulWidget {
  const Logout({super.key});
  static const logout = 'logout';

  @override
  State<Logout> createState() => _LogoutState();
}

class _LogoutState extends State<Logout> {
  //bool? isloggedin;

  Future<void> _logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
    await prefs.setBool('saveFirst', true);
    //prefs.clear();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _logout();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      //padding: EdgeInsets.only(top: 10),
      width: 358,
      height: 230,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25), topRight: Radius.circular(25))),

      child: Column(
        children: [
          Container(
            // decoration: BoxDecoration(
            //     borderRadius: BorderRadius.only(
            //         topLeft: Radius.circular(25),
            //         topRight: Radius.circular(25))),
            width: 30,
            height: 3,
            color: const Color.fromARGB(255, 201, 201, 201),
            margin: EdgeInsets.symmetric(vertical: 10),
          ),
          Text(
            'Logout',
            style: TextStyle(fontSize: 30, color: Colors.red),
          ),
          Container(
            width: 300,
            height: 2,
            color: const Color.fromARGB(255, 201, 201, 201),
            margin: EdgeInsets.symmetric(vertical: 20),
          ),
          Text(
            'Are you sure you want to log out?',
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            padding: EdgeInsets.only(left: 15, right: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                    child: OutlinedButton(
                        style: ButtonStyle(
                          minimumSize: WidgetStateProperty.all(
                            Size(200, 50),
                          ),
                          side: WidgetStatePropertyAll(
                            BorderSide(style: BorderStyle.none),
                          ),
                          backgroundColor: WidgetStateProperty.all(
                              const Color.fromARGB(255, 218, 218, 218)),
                          //     WidgetStateProperty.resolveWith((state) {
                          //   if (state.contains(WidgetState.pressed)) {
                          //     return Colors.green;
                          //   }
                          //   return const Color.fromARGB(255, 219, 217, 217);
                          // }),
                          foregroundColor:
                              WidgetStateProperty.resolveWith((state) {
                            if (state.contains(WidgetState.pressed)) {
                              return Colors.white;
                            }
                            return Colors.green;
                          }),
                          shape: WidgetStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(22),
                            ),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Cancel',
                          style: TextStyle(color: Colors.green),
                        ))),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                    child: OutlinedButton(
                        style: ButtonStyle(
                          minimumSize: WidgetStateProperty.all(
                            Size(200, 50),
                          ),
                          side: WidgetStatePropertyAll(
                            BorderSide(style: BorderStyle.none),
                          ),
                          backgroundColor:
                              WidgetStateProperty.all(Colors.green),
                          //     WidgetStateProperty.resolveWith((state) {
                          //   if (state.contains(WidgetState.pressed)) {
                          //     return Colors.green;
                          //   }
                          //   return Color.fromARGB(255, 219, 217, 217);
                          // }),
                          foregroundColor:
                              WidgetStateProperty.resolveWith((state) {
                            if (state.contains(WidgetState.pressed)) {
                              return Colors.white;
                            }
                            return Colors.green;
                          }),
                          shape: WidgetStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(22),
                            ),
                          ),
                        ),
                        onPressed: () {
                          _logout();

                          Navigator.pushNamedAndRemoveUntil(
                              context, 'first', (route) => false);
                        },
                        child: Text(
                          'Yes, Logout',
                          style: TextStyle(color: Colors.white),
                        ))),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
