import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gender_selection/gender_selection.dart';
import 'package:pareezsalonapp/components/components.dart';
import 'package:pareezsalonapp/screens/booking_screen.dart';
import 'package:pareezsalonapp/screens/home_screen.dart';

class HandsFeet extends StatefulWidget {
  @override
  _HandsFeetState createState() => _HandsFeetState();
}

class _HandsFeetState extends State<HandsFeet> {
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
          if (snapshot.data.containsKey('handsfeet')) {
            for (int i = 0; i < snapshot.data['handsfeet'].length; i++) {
              if (!_dataSearch.handsFeet.contains(snapshot.data['handsfeet'][i])) {
                _dataSearch.handsFeet.add(snapshot.data['handsfeet'][i]);
                _dataSearch.costHandsFeet.add(snapshot.data['costhandsfeet'][i]);
              }
            }
            break;
          }
        }

        return ListView.separated(
          separatorBuilder: (context, index) => Divider(indent: 20.0, endIndent: 20.0),
          itemCount: _dataSearch.handsFeet == null ? 0 : _dataSearch.handsFeet.length,
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
                            Text('${_dataSearch.handsFeet[index]}',
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold)),
                            SizedBox(height: 10.0),
                            FittedBox(
                                child: Text('₹${_dataSearch.costHandsFeet[index]}',
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold))),
                          ]),
                      trailing: ButtonTheme(
                        minWidth: 10.0,
                        height: 30.0,
                        child: RaisedButton(
                          child: selectedItems.contains(_dataSearch.handsFeet[index])
                              ? Icon(Icons.check, color: Colors.white)
                              : Text('Select',
                              style: TextStyle(
                                  color:
                                  selectedItems.contains(_dataSearch.handsFeet[index])
                                      ? Colors.white
                                      : Colors.black)),
                          color: selectedItems.contains(_dataSearch.handsFeet[index])
                              ? Colors.black
                              : Colors.grey[300],
                          elevation: 3.0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          onPressed: () {
                            if (!selectedItems.contains(_dataSearch.handsFeet[index])) {
                              setState(() {
                                selectedItems.add(_dataSearch.handsFeet[index]);
                                selectedItemsCost.add(_dataSearch.costHandsFeet[index]);
                              });
                            } else {
                              setState(() {
                                selectedItems.remove(_dataSearch.handsFeet[index]);
                                selectedItemsCost.remove(_dataSearch.costHandsFeet[index]);
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
