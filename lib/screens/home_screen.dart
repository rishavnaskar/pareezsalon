import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pareezsalonapp/components/custom_app_bar.dart';
import 'package:pareezsalonapp/screens/booking_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  
  _image1(int number, String imageName, String imageDescriptionName) {
    return Expanded(
      flex: 2,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            right: BorderSide(
                width: 5.0,
                color: Colors.black,
                style: BorderStyle.solid),
            left: BorderSide(
                width: 5.0,
                color: Colors.black,
                style: BorderStyle.solid),
            top: BorderSide(
                width: 10.0,
                color: Colors.black,
                style: BorderStyle.solid),
          ),
        ),
        child: GestureDetector(
          onTap: () {
            setState(() {
              Navigator.push(
                context,
                new CupertinoPageRoute(
                  builder: (context) => BookingScreen(
                    number: number,
                  ),
                ),
              );
            });
          },
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Image.asset(
                imageName,
                fit: BoxFit.fitWidth,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  imageDescriptionName,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                    letterSpacing: 4.0,
                    textBaseline: TextBaseline.ideographic,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  _image3(int number, String imageName, String imageDescriptionName) {
    return Expanded(
      flex: 2,
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(
                width: 5.0, color: Colors.black, style: BorderStyle.solid)),
        child: GestureDetector(
          onTap: () {
            setState(() {
              Navigator.push(
                context,
                new CupertinoPageRoute(
                  builder: (context) => BookingScreen(
                    number: number,
                  ),
                ),
              );
            });
          },
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Image.asset(
                imageName,
                fit: BoxFit.fitWidth,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: FittedBox(
                  child: Text(
                    imageDescriptionName,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold,
                      letterSpacing: 4.0,
                      textBaseline: TextBaseline.ideographic,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        leading: CustomAppBar().appBarLocationIcon(),
        title: CustomAppBar().appBarTitle(false),
        actions: <Widget>[
          CustomAppBar().appBarCallIcon(),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Center(
              child: FittedBox(
                fit: BoxFit.fitWidth,
                child: Text(
                  'Garfa, Kolkata',
                  style: TextStyle(
                    backgroundColor: Colors.black,
                    fontSize: 15.0,
                    fontFamily: 'Montserrat',
                    letterSpacing: 1.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Expanded(
              flex: 1,
              child: Container(
                color: Colors.grey[700],
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  reverse: false,
                  addSemanticIndexes: true,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.all(5.0),
                      child: Image.asset('assets/ResPic12.jpg',
                          fit: BoxFit.fitWidth),
                    ),
                    Container(
                      margin: EdgeInsets.all(5.0),
                      child: Image.asset('assets/ResPic13.jpg',
                          fit: BoxFit.fitWidth),
                    ),
                    Container(
                      margin: EdgeInsets.all(5.0),
                      child: Image.asset('assets/ResPic14.jpg',
                          fit: BoxFit.fitWidth),
                    ),
                    Container(
                      margin: EdgeInsets.all(5.0),
                      child: Image.asset('assets/ResPic11.jpg',
                          fit: BoxFit.fitWidth),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Row(
                children: <Widget>[
                  _image1(1, 'assets/HairRes1.jpg', 'HAIR'),
                  _image1(2, 'assets/SkinRes1.jpg', 'SKIN'),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: <Widget>[
                  _image3(3, 'assets/Bridal.jpg', 'BRIDAL'),
                  _image3(4, 'assets/FeetRes1.jpg', 'HANDS/FEET'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
