import 'package:flutter/material.dart';
import 'package:pareezsalonapp/components/custom_app_bar.dart';
import 'package:pareezsalonapp/screens/booking_bridal.dart';
import 'package:pareezsalonapp/screens/booking_hair.dart';
import 'package:pareezsalonapp/screens/booking_handsandfeet.dart';
import 'package:pareezsalonapp/screens/booking_skin.dart';

class BookingScreen extends StatefulWidget {
  BookingScreen({this.number});
  final int number;

  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  int _selectedNumber;
  @override
  void initState() {
    super.initState();
    if (widget.number == 1 ||
        widget.number == 2 ||
        widget.number == 3 ||
        widget.number == 4) {
      _selectedNumber = widget.number - 1;
    } else {
      _selectedNumber = 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 4,
        initialIndex: _selectedNumber,
        child: Scaffold(
          backgroundColor: Colors.grey[900],
          appBar: AppBar(
            backgroundColor: Colors.black,
            centerTitle: true,
            leading: CustomAppBar().appBarLocationIcon(),
            title: CustomAppBar().appBarTitle(false),
            actions: <Widget>[
              CustomAppBar().appBarCallIcon(),
            ],
            bottom: TabBar(
              indicatorColor: Colors.orange,
              isScrollable: true,
              unselectedLabelStyle:
                  TextStyle(color: Colors.white, fontSize: 20.0),
              unselectedLabelColor: Colors.white,
              tabs: [
                TabItems(title: 'Hair'),
                TabItems(title: 'Skin'),
                TabItems(title: 'Bridal'),
                TabItems(title: 'Hands & feet'),
              ],
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              BookingHair(),
              BookingSkin(),
              BookingBridal(),
              BookingHandsAndFeet(),
            ],
          ),
        ),
      ),
    );
  }
}

class TabItems extends StatelessWidget {
  TabItems({@required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Text(
        '$title',
        style: TextStyle(
          fontSize: 16.0,
          letterSpacing: 2.0,
          color: Colors.white,
        ),
      ),
    );
  }
}
