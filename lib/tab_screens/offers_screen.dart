import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gender_selection/gender_selection.dart';
import 'package:pareezsalonapp/screens/booking_screen.dart';
import 'package:pareezsalonapp/screens/home_screen.dart';

class OffersScreen extends StatefulWidget {
  @override
  _OffersScreenState createState() => _OffersScreenState();
}

class _OffersScreenState extends State<OffersScreen> {
  List<String> offers = [];
  List<int> costOffers = [];
  List<String> offersPic = [];

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: selectedGender == Gender.Male
          ? Firestore.instance.collection('services_male').snapshots()
          : Firestore.instance.collection('services_female').snapshots(),
      builder: (context, snapshots) {
        if (!snapshots.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.grey,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
            ),
          );
        }

        for (var snapshot in snapshots.data.documents) {
          if (snapshot.data.containsKey('offers')) {
            for (int i = 0; i < snapshot.data['offers'].length; i++) {
              if (!offers.contains(snapshot.data['offers'][i])) {
                offers.add(snapshot.data['offers'][i]);
                costOffers.add(snapshot.data['costoffers'][i]);
                offersPic.add(snapshot.data['offerspic'][i]);
              }
            }
            break;
          }
        }

        return ListView.separated(
          separatorBuilder: (context, index) =>
              Divider(indent: 20.0, endIndent: 20.0),
          itemCount: offers == null ? 0 : offers.length,
          itemBuilder: (context, index) {

            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 10.0),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      height: 200,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.grey,
                              Colors.black,
                            ]
                          ),
                          borderRadius: BorderRadius.circular(20)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                              child: Container(
                            height: 170,
                            width: 130,
                            decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 3,
                                      color: Colors.black,
                                      offset: Offset(3, 3))
                                ],
                                image: DecorationImage(
                                    image: NetworkImage('${offersPic[index]}'),
                                    fit: BoxFit.cover)),
                          )),
                          Flexible(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      '${offers[index]}',
                                      maxLines: 5,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.end,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Montserrat',
                                        letterSpacing: 2.0,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      '₹ ${costOffers[index]}',
                                      textAlign: TextAlign.end,
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontFamily: 'Montserrat',
                                          letterSpacing: 2.0,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14
                                      ),
                                    ),
                                  ],
                                ),
                                Flexible(child: SizedBox(height: 30)),
                                ButtonTheme(
                                  minWidth: 10.0,
                                  height: 30.0,
                                  child: RaisedButton(
                                    child: selectedItems.contains(offers[index])
                                        ? Icon(Icons.check, color: Colors.black)
                                        : Text('Select',
                                        style: TextStyle(
                                            color: Colors.orange)),
                                    color: selectedItems.contains(offers[index])
                                        ? Colors.white
                                        : Colors.grey[800],
                                    elevation: 3.0,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5.0)),
                                    onPressed: () {
                                      if (!selectedItems.contains(offers[index])) {
                                        setState(() {
                                          selectedItems.add(offers[index]);
                                          selectedItemsCost.add(costOffers[index]);
                                        });
                                      } else {
                                        setState(() {
                                          selectedItems.remove(offers[index]);
                                          selectedItemsCost.remove(costOffers[index]);
                                        });
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 10.0)
                  ]),
            );
          },
        );
      },
    );
  }
}

/*
if (!selectedItems.contains(offers[index])) {
                              setState(() {
                                selectedItems.add(offers[index]);
                                selectedItemsCost.add(costOffers[index]);
                              });
                            } else {
                              setState(() {
                                selectedItems.remove(offers[index]);
                                selectedItemsCost.remove(costOffers[index]);
                              });
                            }
 */

/*
ListTile(
                      title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('${offers[index]}',
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold)),
                            SizedBox(height: 10.0),
                            FittedBox(
                                child: Text('₹${costOffers[index]}',
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold))),
                          ]),
                      trailing: ButtonTheme(
                        minWidth: 10.0,
                        height: 30.0,
                        child: RaisedButton(
                          child: Text('Select',
                              style: TextStyle(
                                  color: selectedItems.contains(offers[index])
                                      ? Colors.white
                                      : Colors.black)),
                          color: selectedItems.contains(offers[index])
                              ? Colors.black
                              : Colors.grey[300],
                          elevation: 3.0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          onPressed: () {

                          },
                        ),
                      ),
                    ),
 */
