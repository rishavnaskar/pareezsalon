import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:pareezsalonapp/login/google_sign_in.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: ModalProgressHUD(
        inAsyncCall: _isLoading,
        progressIndicator: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white)),
        child: Stack(children: [
          StartCarousel(),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.3,
              decoration: BoxDecoration(
                boxShadow: [BoxShadow(blurRadius: 10.0)],
                gradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  colors: [
                    Colors.white,
                    Colors.white.withOpacity(0.8)
                  ],
                ),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0))),
              child: Padding(
                padding: EdgeInsets.fromLTRB(25.0, 30.0, 25.0, 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FittedBox(
                      child: Text("Beauty is the illumination of your soul", textAlign: TextAlign.start, style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Pacifico',
                        fontSize: 20.0,
                        letterSpacing: 2.0
                      )),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: FittedBox(
                        child: Text("- John O'Donohue", textAlign: TextAlign.end, style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'KaushanScript',
                            letterSpacing: 2.0
                        )),
                      ),
                    ),
                    Expanded(child: SizedBox(height: 30.0)),
                    Container(color: Colors.grey[700], height: 1.0),

                    ///GoogleSignIn Button
                    Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 8.0),
                        child: SignInButton(
                          Buttons.Google,
                          padding: EdgeInsets.only(left: 40.0),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10.0))),
                          onPressed: () {
                            setState(() {
                              _isLoading = true;
                            });
                            GoogleLoginIn().googleLogInUser(context);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

class StartCarousel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.8,
          child: Carousel(
            images: [
              ExactAssetImage('assets/P1.jpg'),
              ExactAssetImage('assets/P2.jpg'),
            ],
            showIndicator: true,
            dotBgColor: Colors.white.withOpacity(0.2),
            dotIncreasedColor: Colors.orange,
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.8,
          color: Colors.black.withOpacity(0.6),
        ),
        Positioned(
          top: 70.0,
          right: 30.0,
          child: Text(
            'PARΣΞZ',
            style: TextStyle(
              fontSize: 55.0,
              color: Colors.white,
              letterSpacing: 3.0,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
        Positioned(
          top: 140.0,
          right: 30.0,
          child: Text(
            'A family salon',
            style: TextStyle(
                color: Colors.grey,
                letterSpacing: 3.0,
                fontWeight: FontWeight.bold,
                wordSpacing: 3.0,
                fontFamily: 'Montserrat'),
          ),
        ),
      ],
    );
  }
}
