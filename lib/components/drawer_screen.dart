import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pareezsalonapp/login/google_sign_in.dart';
import 'package:pareezsalonapp/screens/about_screen.dart';
import 'package:pareezsalonapp/screens/home_screen.dart';

String email, displayName;

class DrawerItem {
  String title;
  DrawerItem(this.title);
}

class DrawerPage extends StatefulWidget {
  DrawerPage({this.photoUrl, this.displayName, this.email});
  final String email;
  final String displayName;
  final String photoUrl;
  final drawerItems = [
    DrawerItem('Home'),
    DrawerItem('About Us'),
  ];

  @override
  _DrawerPageState createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  int _selectedDrawerIndex = 0;
  String photoUrl;

  @override
  void initState() {
    if (widget.email == null || widget.displayName == null) {
      _getCurrentUser();
    } else {
      setState(() {
        email = widget.email;
        photoUrl = widget.photoUrl;
        displayName = widget.displayName;
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var drawerOptions = <Widget>[];
    for (var i = 0; i < widget.drawerItems.length; i++) {
      var d = widget.drawerItems[i];
      drawerOptions.add(ListTile(
        title: Padding(
            padding: EdgeInsets.only(left: 20.0, top: 50.0),
            child: Text(d.title,
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w900,
                    letterSpacing: 2.0))),
        selected: i == _selectedDrawerIndex,
        onTap: () => _onSelectItem(i),
      ));
    }

    return Scaffold(
      drawer: Drawer(
        elevation: 10.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Colors.grey[700],
                    Colors.grey[300].withOpacity(0.7),
                  ]),
                  borderRadius:
                      BorderRadius.only(bottomRight: Radius.circular(20.0)),
                  boxShadow: [BoxShadow(blurRadius: 10.0)]),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                backgroundImage: NetworkImage('$photoUrl'),
                radius: 15.0,
              ),
              accountName: FittedBox(
                child: Text('$displayName',
                    style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.black,
                        fontFamily: 'Pacifico',
                        letterSpacing: 4.0,
                        fontWeight: FontWeight.bold)),
              ),
              margin: EdgeInsets.zero,
              accountEmail: null,
            ),
            Column(children: drawerOptions),
            Expanded(
                child: SizedBox(
              height: 20.0,
            )),
            Container(color: Colors.black, height: 1.0),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5.0),
              child: RaisedButton(
                child:
                    Text('Logout', style: TextStyle(fontFamily: 'Montserrat')),
                onPressed: () => GoogleLoginIn().googleLogOutUser(context),
                elevation: 0.0,
                color: Colors.transparent,
                focusElevation: 0.0,
              ),
            )
          ],
        ),
      ),
      body: _getDrawerItemWidget(_selectedDrawerIndex),
    );
  }

  _getDrawerItemWidget(int pos) {
    switch (pos) {
      case 0:
        return HomeScreen();
      case 1:
        return AboutScreen();
      default:
        return new Text("Error");
    }
  }

  _onSelectItem(int index) {
    setState(() => _selectedDrawerIndex = index);
    Navigator.of(context).pop();
  }

  void _getCurrentUser() async {
    try {
      final user = await FirebaseAuth.instance.currentUser();
      if (user != null) {
        setState(() {
          email = user.email;
          photoUrl = user.photoUrl;
          displayName = user.displayName;
        });
      }
    } catch (e) {
      print(e);
    }
  }
}
