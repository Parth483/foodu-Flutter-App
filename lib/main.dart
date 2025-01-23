import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodu/App/Category/cart.dart';
import 'package:foodu/App/Category/category.dart';
//import 'package:foodu/App/Category/food_category/Items.dart';
import 'package:foodu/App/Category/food_category/item3.dart';
import 'package:foodu/App/Category/specialoffers.dart';
import 'package:foodu/App/Homepage/homepage.dart';
import 'package:foodu/App/Homepage/subfolders/home.dart';
import 'package:foodu/App/Homepage/subfolders/order.dart';
import 'package:foodu/App/Homepage/subfolders/profile.dart';
import 'package:foodu/App/Notification/notification.dart';
import 'package:foodu/App/OTP/otp.dart';
import 'package:foodu/App/Orders/OrderPage/Address.dart';
import 'package:foodu/App/Orders/OrderPage/Checkout.dart';
import 'package:foodu/App/Orders/OrderPage/OrderDetailsScreen.dart';
import 'package:foodu/App/Orders/OrderPage/Overview.dart';
import 'package:foodu/App/Orders/OrderPage/addAddress.dart';
import 'package:foodu/App/Orders/OrderPage/editaddress.dart';

import 'package:foodu/App/Profile/EditPassword.dart';
import 'package:foodu/App/Profile/EditProfile.dart';
import 'package:foodu/App/Profile/logout.dart';
import 'package:foodu/SplashScreen/splashscreen.dart';
import 'package:foodu/SplashScreen/welcome.dart';
import 'package:foodu/Start/pageview.dart';
import 'package:foodu/Start/deliverydetails.dart';
import 'package:foodu/Start/fooddetails.dart';
import 'package:foodu/Start/paymentdetails.dart';
import 'package:foodu/getstart/first.dart';
import 'package:foodu/getstart/login.dart';
import 'package:foodu/getstart/signup.dart';
import 'package:sizer/sizer.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  // Add logic to close keyboard at startup
  //SystemChannels.textInput.invokeMethod('TextInput.hide');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return MaterialApp(
        theme: ThemeData(fontFamily: 'Oswald'),
        initialRoute: Splashscreen.splashscreen,
        routes: {
          Splashscreen.splashscreen: (context) => Splashscreen(),
          Welcome.welcome: (context) => Welcome(),
          Bottomnav.bottomnav: (context) => Bottomnav(),
          Deliverydetails.delivery: (context) => Deliverydetails(),
          Fooddetails.fooddtl: (context) => Fooddetails(),
          Paymentdetails.paymentdtl: (context) => Paymentdetails(),
          First.first: (context) => First(),
          Signup.signup: (contex) => Signup(),
          Login.login: (context) => Login(),
          Homepage.homepage: (context) => Homepage(),
          Home.home: (context) => Home(),
          Order.order: (context) => Order(),
          Profile.profile: (context) => Profile(),
          Category.category: (context) => Category(),
          Specialoffers.specialoffers: (context) => Specialoffers(),
          Cart.cart: (context) => Cart(),
          Item3.items: (context) => Item3(),
          Notifications.notification: (context) => Notifications(),
          Editprofile.editprofile: (context) => Editprofile(),
          Editpassword.editpassword: (context) => Editpassword(),
          Logout.logout: (context) => Logout(),
          Orderdetailsscreen.orderdetails: (context) => Orderdetailsscreen(),
          Checkout.checkout: (context) => Checkout(),
          Address.address: (context) => Address(),
          Overview.overview: (context) => Overview(),
          Otp.otp: (context) => Otp(),
          Addaddress.addaddress: (context) => Addaddress(),
          Editaddress.editaddress: (context) => Editaddress()
        },
        // home: Signup(),
        debugShowCheckedModeBanner: false,
      );
    });
  }
}
