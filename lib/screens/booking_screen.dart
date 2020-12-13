import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pareezsalonapp/components/components.dart';
import 'package:pareezsalonapp/tab_screens/bridal_screen.dart';
import 'package:pareezsalonapp/tab_screens/hair_screen.dart';
import 'package:pareezsalonapp/tab_screens/handsfeet_screen.dart';
import 'package:pareezsalonapp/tab_screens/offers_screen.dart';
import 'package:pareezsalonapp/tab_screens/skin_screen.dart';

List<String> selectedItems = [];
List<int> selectedItemsCost = [];

class BookingScreen extends StatefulWidget {
  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.3,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage('assets/P1.jpg'),
              fit: BoxFit.cover,
            )),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.3,
            width: MediaQuery.of(context).size.width,
            color: Colors.black.withOpacity(0.3),
          ),
          Content(),
          Positioned(
              top: 20.0,
              left: 0.0,
              child: IconButton(
                icon: Icon(Icons.arrow_back_ios),
                color: Colors.white,
                iconSize: 20.0,
                onPressed: () => Navigator.pop(context),
              )),
        ],
      ),
    );
  }
}

class Content extends StatefulWidget {
  @override
  _ContentState createState() => _ContentState();
}

class _ContentState extends State<Content> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.8,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(60.0))),
        child: DefaultTabController(
          initialIndex: 0,
          length: 5,
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  SliverAppBar(
                    leading: IconButton(
                      icon: Icon(Icons.search),
                      color: Colors.black,
                      iconSize: 20.0,
                      onPressed: () => showSearch(context: context, delegate: DataSearch()),
                    ),
                    title: Text('Booking',
                        style: TextStyle(
                          color: Colors.black,
                          letterSpacing: 6.0,
                        )),
                    actions: [Hero(tag: 'cart', child: CartButton())],
                    shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.only(topLeft: Radius.circular(60.0))),
                    backgroundColor: Colors.white,
                    elevation: 5,
                    centerTitle: true,
                    pinned: true,
                    floating: true,
                    forceElevated: innerBoxIsScrolled,
                    bottom: TabBar(
                      labelColor: Colors.black,
                      indicatorColor: Colors.black,
                      indicatorSize: TabBarIndicatorSize.label,
                      isScrollable: true,
                      tabs: <Tab>[
                        Tab(text: "HAIR"),
                        Tab(text: "SKIN"),
                        Tab(text: "BRIDAL"),
                        Tab(text: "HANDS FEET"),
                        Tab(text: "OFFERS"),
                      ],
                    ),
                  ),
                ];
              },
              body: TabBarView(
                children: <Widget>[
                  HairScreen(),
                  SkinScreen(),
                  BridalScreen(),
                  HandsFeet(),
                  OffersScreen()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
