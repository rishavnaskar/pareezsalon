import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pareezsalonapp/components/components.dart';
import 'package:pareezsalonapp/components/mailer.dart';
import 'package:pareezsalonapp/screens/booking_screen.dart';
import 'package:pareezsalonapp/screens/home_screen.dart';
import 'package:toast/toast.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  String emptyCart =
      'Your cart seems empty! Quickly add your favourites and book an appointment';
  String fullCart =
      'Looks like your cart is waiting for you. Book an appointment before it\'s too late!';

  @override
  Widget build(BuildContext context) {
    var cartItems = <Widget>[];
    cartItems.add(CartCaption(emptyCart: emptyCart, fullCart: fullCart));
    cartItems.add(SizedBox(height: 50));
    cartItems.add(CartTimeWidget());
    cartItems.add(SizedBox(height: 20));

    for (int i = 0; i < selectedItems.length; i++) {
      cartItems.add(
        Column(
          children: [
            Container(
              height: 200.0,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: CircleAvatar(
                        backgroundColor: Colors.black,
                        radius: 15,
                        child: FittedBox(
                          child: Text('${i + 1}',
                              style: TextStyle(color: Colors.white)),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Text('${selectedItems[i]}',
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold)),
                    SizedBox(height: 20.0),
                    Text('₹ ${selectedItemsCost[i]}',
                        style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold)),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: IconButton(
                        icon: Icon(Icons.delete_outline),
                        onPressed: () {
                          setState(() {
                            selectedItems.removeAt(i);
                            selectedItemsCost.removeAt(i);
                          });
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 30),
          ],
        ),
      );
    }
    if (selectedItems.length == 0) {
      cartItems.add(SizedBox(height: MediaQuery.of(context).size.height / 4.8));
      cartItems.add(Center(
          child: Text('Cart is empty!', style: TextStyle(letterSpacing: 2.0))));
      cartItems.add(SizedBox(height: MediaQuery.of(context).size.height / 4.8));
    }
    cartItems.add(CartConfirm());
    cartItems.add(SizedBox(height: 20));

    return WillPopScope(
      onWillPop: () {
        if (selectedItems.length == 0) {
          Navigator.popUntil(context, ModalRoute.withName('/'));
        } else {
          Navigator.pop(context);
        }
        return Future.value(false);
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 50),
                  Flexible(
                    child: ListView(children: cartItems),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 40.0,
              left: 5.0,
              child: IconButton(
                icon: Icon(Icons.arrow_back_ios),
                iconSize: 20.0,
                color: Colors.black,
                onPressed: () {
                  if (selectedItems.length == 0) {
                    Navigator.popUntil(context, ModalRoute.withName('/'));
                  } else {
                    Navigator.pop(context);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CartConfirm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
            child: Text(
          'Press the button to confirm your appointment',
          maxLines: 3,
        )),
        SizedBox(width: 40.0),
        FloatingActionButton(
          backgroundColor: Colors.black,
          heroTag: 'pareez',
          child: Icon(Icons.arrow_forward),
          elevation: 10,
          tooltip: 'Confirm Booking',
          onPressed: () async {
            if (selectedItems.length == 0) {
              Toast.show('Empty cart!', context,
                  duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
            } else {
              DialogBox().neverSatisfied(context);
              final result = await Mailer().sendMail(context);
              if (result == 'success') {
                selectedItems.clear();
                selectedItemsCost.clear();
                Navigator.popUntil(context, ModalRoute.withName('/'));
                Toast.show('Appointment booked. Check your email', context,
                    duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
              } else {
                Navigator.pop(context);
                Toast.show('Something went wrong...', context,
                    duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
              }
            }
          },
        ),
        SizedBox(width: 10.0)
      ],
    );
  }
}

class CartTimeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List dayName = ['Mon', 'Tue', 'Wed', 'Thurs', 'Fri', 'Sat', 'Sun'];
    return Row(
      children: [
        Text(
            '${dayName[selectedDate.weekday - 1]}, ${selectedDate.day} / ${selectedDate.month} / ${selectedDate.year}',
            style: TextStyle(
                fontSize: 18,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.bold)),
        Expanded(child: SizedBox(width: 30.0)),
        Text('${selectedTime.format(context)}',
            style: TextStyle(
                fontSize: 18,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.bold)),
      ],
    );
  }
}

class CartCaption extends StatelessWidget {
  const CartCaption({
    Key key,
    @required this.emptyCart,
    @required this.fullCart,
  }) : super(key: key);

  final String emptyCart;
  final String fullCart;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Row(
        children: [
          Hero(
            tag: 'cart',
            child: CircleAvatar(
              radius: 60,
              backgroundColor: Colors.black,
              child: CircleAvatar(
                radius: 55,
                backgroundColor: Colors.white,
                child:
                    Icon(Icons.shopping_cart, size: 80.0, color: Colors.black),
              ),
            ),
          ),
          SizedBox(width: 20.0),
          Flexible(
              child: Text(selectedItems == null ? emptyCart : fullCart,
                  textAlign: TextAlign.center,
                  maxLines: 5,
                  style: TextStyle(
                      fontSize: 18.0,
                      fontFamily: 'Montserrat',
                      letterSpacing: 3.0)))
        ],
      ),
    );
  }
}
