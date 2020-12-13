import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gender_selection/gender_selection.dart';
import 'package:pareezsalonapp/components/components.dart';
import 'package:pareezsalonapp/screens/booking_screen.dart';
import 'package:pareezsalonapp/screens/home_screen.dart';

class HairScreen extends StatefulWidget {
  @override
  _HairScreenState createState() => _HairScreenState();
}

class _HairScreenState extends State<HairScreen> {
  DataSearch _dataSearch = DataSearch();
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
          if (snapshot.data.containsKey('hair')) {
            for (int i = 0; i < snapshot.data['hair'].length; i++) {
              if (!_dataSearch.hair.contains(snapshot.data['hair'][i])) {
                _dataSearch.hair.add(snapshot.data['hair'][i]);
                _dataSearch.costHair.add(snapshot.data['costhair'][i]);
              }
            }
            break;
          }
        }

        return ListView.separated(
          separatorBuilder: (context, index) => Divider(indent: 20.0, endIndent: 20.0),
          itemCount: _dataSearch.hair == null ? 0 : _dataSearch.hair.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 10.0),
                    ListTile(
                      title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('${_dataSearch.hair[index]}',
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold)),
                            SizedBox(height: 10.0),
                            FittedBox(
                                child: Text('₹${_dataSearch.costHair[index]}',
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold))),
                          ]),
                      trailing: ButtonTheme(
                        minWidth: 10.0,
                        height: 30.0,
                        child: RaisedButton(
                          child: selectedItems.contains(_dataSearch.hair[index])
                              ? Icon(Icons.check, color: Colors.white)
                              : Text('Select',
                              style: TextStyle(
                                  color:
                                  selectedItems.contains(_dataSearch.hair[index])
                                      ? Colors.white
                                      : Colors.black)),
                          color: selectedItems.contains(_dataSearch.hair[index])
                              ? Colors.black
                              : Colors.grey[300],
                          elevation: 3.0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          onPressed: () {
                            if (!selectedItems.contains(_dataSearch.hair[index])) {
                              setState(() {
                                selectedItems.add(_dataSearch.hair[index]);
                                selectedItemsCost.add(_dataSearch.costHair[index]);
                              });
                            } else {
                              setState(() {
                                selectedItems.remove(_dataSearch.hair[index]);
                                selectedItemsCost.remove(_dataSearch.costHair[index]);
                              });
                            }
                          },
                        ),
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
