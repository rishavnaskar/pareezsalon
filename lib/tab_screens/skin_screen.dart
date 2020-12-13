import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gender_selection/gender_selection.dart';
import 'package:pareezsalonapp/components/components.dart';
import 'package:pareezsalonapp/screens/booking_screen.dart';
import 'package:pareezsalonapp/screens/home_screen.dart';

class SkinScreen extends StatefulWidget {
  @override
  _SkinScreenState createState() => _SkinScreenState();
}

class _SkinScreenState extends State<SkinScreen> {
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
          if (snapshot.data.containsKey('skin')) {
            for (int i = 0; i < snapshot.data['skin'].length; i++) {
              if (!_dataSearch.skin.contains(snapshot.data['skin'][i])) {
                _dataSearch.skin.add(snapshot.data['skin'][i]);
                _dataSearch.costSkin.add(snapshot.data['costskin'][i]);
              }
            }
            break;
          }
        }

        return ListView.separated(
          separatorBuilder: (context, index) => Divider(indent: 20.0, endIndent: 20.0),
          itemCount: _dataSearch.skin == null ? 0 : _dataSearch.skin.length,
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
                            Text('${_dataSearch.skin[index]}',
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold)),
                            SizedBox(height: 10.0),
                            FittedBox(
                                child: Text('₹${_dataSearch.costSkin[index]}',
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold))),
                          ]),
                      trailing: ButtonTheme(
                        minWidth: 10.0,
                        height: 30.0,
                        child: RaisedButton(
                          child: selectedItems.contains(_dataSearch.skin[index])
                              ? Icon(Icons.check, color: Colors.white)
                              : Text('Select',
                              style: TextStyle(
                                  color:
                                  selectedItems.contains(_dataSearch.skin[index])
                                      ? Colors.white
                                      : Colors.black)),
                          color: selectedItems.contains(_dataSearch.skin[index])
                              ? Colors.black
                              : Colors.grey[300],
                          elevation: 3.0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          onPressed: () {
                            if (!selectedItems.contains(_dataSearch.skin[index])) {
                              setState(() {
                                selectedItems.add(_dataSearch.skin[index]);
                                selectedItemsCost.add(_dataSearch.costSkin[index]);
                              });
                            } else {
                              setState(() {
                                selectedItems.remove(_dataSearch.skin[index]);
                                selectedItemsCost.remove(_dataSearch.costSkin[index]);
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
