import 'package:flutter/material.dart';
import 'package:pareezsalonapp/screens/booking_screen.dart';
import 'package:pareezsalonapp/screens/home_screen.dart';
import 'package:pareezsalonapp/screens/profile_screen.dart';

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    BookingScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
            border: Border(top: BorderSide(color: Colors.orange, width: 2.0))),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          elevation: 10.0,
          backgroundColor: Colors.black,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              backgroundColor: Colors.black,
              icon: Icon(Icons.home, color: Colors.white),
              title: Text(
                'Home',
                style: TextStyle(
                  letterSpacing: 1.0,
                  color: Colors.white,
                ),
              ),
            ),
            BottomNavigationBarItem(
              icon:
                  Icon(Icons.calendar_today, color: Colors.white),
              title: Text(
                'Book Now',
                style: TextStyle(
                  letterSpacing: 1.0,
                  color: Colors.white,
                ),
              ),
            ),
            BottomNavigationBarItem(
              icon:
                  Icon(Icons.person_outline, color: Colors.white),
              title: Text(
                'Profile',
                style: TextStyle(
                  letterSpacing: 1.0,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
