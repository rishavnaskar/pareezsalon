import 'package:badges/badges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gender_selection/gender_selection.dart';
import 'package:pareezsalonapp/screens/booking_screen.dart';
import 'package:pareezsalonapp/screens/cart_screen.dart';
import 'package:pareezsalonapp/screens/home_screen.dart';

///Utility functions

class DataSearch extends SearchDelegate<String> {
  List<String> totalItems = [];
  List<int> costTotalItems = [];

  List<String> hair = [];
  List<int> costHair = [];

  List<String> bridal = [];
  List<int> costBridal = [];

  List<String> handsFeet = [];
  List<int> costHandsFeet = [];

  List<String> skin = [];
  List<int> costSkin = [];

  DataSearch() {
    getRecords();
  }

  getRecords() async {
    final records = await Firestore.instance
        .collection(
            selectedGender == Gender.Male ? 'services_male' : 'services_female')
        .getDocuments();

    for (var record in records.documents) {
      if (record.data.containsKey('hair')) {
        for (int i = 0; i < record.data['hair'].length; i++) {
          if (!totalItems.contains(record.data['hair'][i]) &&
              !hair.contains(record.data['hair'][i])) {
            hair.add(record.data['hair'][i]);
            costHair.add(record.data['costhair'][i]);
          }
        }
      }
      if (record.data.containsKey('skin')) {
        for (int i = 0; i < record.data['skin'].length; i++) {
          if (!totalItems.contains(record.data['skin'][i]) &&
              !skin.contains(record.data['skin'][i])) {
            skin.add(record.data['skin'][i]);
            costSkin.add(record.data['costskin'][i]);
          }
        }
      }
      if (record.data.containsKey('bridal')) {
        for (int i = 0; i < record.data['bridal'].length; i++) {
          if (!totalItems.contains(record.data['bridal'][i]) &&
              !bridal.contains(record.data['bridal'][i])) {
            bridal.add(record.data['bridal'][i]);
            costBridal.add(record.data['costbridal'][i]);
          }
        }
      }
      if (record.data.containsKey('handsfeet')) {
        for (int i = 0; i < record.data['handsfeet'].length; i++) {
          if (!totalItems.contains(record.data['handsfeet'][i]) &&
              !handsFeet.contains(record.data['handsfeet'][i])) {
            handsFeet.add(record.data['handsfeet'][i]);
            costHandsFeet.add(record.data['costhandsfeet'][i]);
          }
        }
      }
    }
    totalItems.addAll(hair);
    costTotalItems.addAll(costHair);
    totalItems.addAll(skin);
    costTotalItems.addAll(costSkin);
    totalItems.addAll(handsFeet);
    costTotalItems.addAll(costHandsFeet);
    totalItems.addAll(bridal);
    costTotalItems.addAll(costBridal);
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () => query = '',
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back_ios),
      iconSize: 20,
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    showSuggestions(context);
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List suggestionList = [];
    List suggestionCost = [];
//    final suggestionList = query.isEmpty
//        ? totalItems
//        : totalItems
//            .where((p) => p
//                .toLowerCase()
//                .trim()
//                .replaceAll('\'', '')
//                .contains('$query'))
//            .toList();

    for (int i = 0; i < totalItems.length; i++) {
      if (totalItems[i]
          .toLowerCase()
          .trim()
          .replaceAll('\'', '')
          .contains('$query')) {
        suggestionList.add(totalItems[i]);
        suggestionCost.add(costTotalItems[i]);
      }
    }

    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) {
//        String temp = suggestionList[index]
//            .toLowerCase()
//            .trim()
//            .replaceAll(' ', '')
//            .replaceAll('\'', '');
//        int count = temp.indexOf('hair');
//        print('$temp - ${count + 1}');
        return ListTile(
          leading: Icon(Icons.spa),
          title: Text(suggestionList[index]),
          onTap: () {
            selectedItems.add(suggestionList[index]);
            selectedItemsCost.add(suggestionCost[index]);
            close(context, null);
            Navigator.push(context,
                CupertinoPageRoute(builder: (context) => CartScreen()));
          },
        );
      },
    );
  }
}

/*
Text(suggestionList[index]),
 */

///Widgets

class CartButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Badge(
      badgeContent: Text('${selectedItems.length}',
          style: TextStyle(color: Colors.white)),
      position: BadgePosition.topRight(top: 0.0, right: 2.0),
      badgeColor: Colors.black,
      showBadge: selectedItems.length == 0 ? false : true,
      child: Material(
        color: Colors.transparent,
        child: IconButton(
          icon: Icon(Icons.shopping_cart),
          padding: EdgeInsets.zero,
          onPressed: () => Navigator.pushNamed(context, '/cart'),
          color: Colors.black,
        ),
      ),
    );
  }
}

class DialogBox {
  Future<void> neverSatisfied(BuildContext context) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            title: Row(
              children: [
                Text('Processing...'),
                Expanded(child: SizedBox(width: 20)),
                CircularProgressIndicator(
                  backgroundColor: Colors.white,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                ),
              ],
            ),
          );
        });
  }
}
