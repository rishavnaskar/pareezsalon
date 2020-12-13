import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pareezsalonapp/components/authservice.dart';
import 'package:pareezsalonapp/screens/booking_screen.dart';
import 'package:pareezsalonapp/screens/cart_screen.dart';

Future main() async {
  await DotEnv().load('.env');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case '/':
            return CupertinoPageRoute(
                builder: (_) => AuthService().handleAuth(), settings: settings);
          case '/cart':
            return CupertinoPageRoute(
                builder: (_) => CartScreen(), settings: settings);
          case '/booking':
            return CupertinoPageRoute(
                builder: (_) => BookingScreen(), settings: settings);
          default:
            return CupertinoPageRoute(
                builder: (_) => AuthService().handleAuth(), settings: settings);
        }
      },
    );
  }
}
