import 'package:carousel_pro/carousel_pro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gender_selection/gender_selection.dart';
import 'package:pareezsalonapp/components/components.dart';
import 'package:toast/toast.dart';

DateTime selectedDate;
TimeOfDay selectedTime;
Gender selectedGender = Gender.Female;
List carouselPictures = [];

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ScrollController _scrollController;
  double elevation = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: elevation,
        leading: IconButton(
          icon: Icon(Icons.subject),
          color: Colors.black,
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
        title: Text('PARΣΞZ',
            style: TextStyle(
              color: Colors.black,
              letterSpacing: 6.0,
              fontSize: 22.0,
            )),
        actions: [
          FloatingActionButton(
            mini: true,
            heroTag: 'pareez',
            backgroundColor: Colors.transparent,
            elevation: 0,
            onPressed: () {},
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/Pareez.png'),
              radius: 15,
            ),
          ),
          SizedBox(width: 10)
        ],
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text('Updates',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 18.0,
                      )),
                  SizedBox(width: 20.0),
                  Icon(Icons.update, size: 20.0),
                  Expanded(child: SizedBox(width: 10)),
                  Hero(tag: 'cart', child: CartButton())
                ],
              ),
              SizedBox(height: 20.0),
              HomeCarousel(),
              SizedBox(height: 40.0),
              Row(children: [
                Text('Book an appointment',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 18.0,
                    )),
                SizedBox(width: 20.0),
                Icon(Icons.calendar_today, size: 20.0)
              ]),
              SizedBox(height: 20.0),
              DatePicker(
                DateTime.now(),
                initialSelectedDate: DateTime.now(),
                daysCount: 10,
                selectionColor: Colors.black,
                selectedTextColor: Colors.white,
                onDateChange: (date) {
                  setState(() {
                    selectedDate = date;
                  });
                },
              ),
              SizedBox(height: 10.0),
              Center(
                child: RaisedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      showPicker(
                        context: context,
                        value: selectedTime,
                        onChange: onTimeChanged,
                        is24HrFormat: false,
                        accentColor: Colors.black,
                        blurredBackground: true,
                      ),
                    );
                  },
                  child: Text(
                    '${selectedTime.format(context)}',
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Montserrat',
                        letterSpacing: 2.0),
                  ),
                  color: Colors.black,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5.0))),
                ),
              ),
              SizedBox(height: 40.0),
              Text('Choose your gender',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 18.0,
                  )),
              SizedBox(height: 10.0),
              genderButton(),
              SizedBox(height: 40.0),
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: RaisedButton(
                    child: Row(
                      children: [
                        FittedBox(
                          child: Text('Let\'s Continue',
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 18.0,
                              )),
                        ),
                        Expanded(child: SizedBox(width: 20.0)),
                        Icon(Icons.arrow_forward, size: 20.0)
                      ],
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5.0))),
                    color: Colors.black,
                    textColor: Colors.white,
                    elevation: 10.0,
                    onPressed: () {
                      if (selectedGender != null)
                        Navigator.pushNamed(context, '/booking');
                      else
                        Toast.show('Please select your gender', context,
                            duration: Toast.LENGTH_SHORT,
                            gravity: Toast.BOTTOM);
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget genderButton() {
    return GenderSelection(
      maleText: "Male",
      femaleText: "Female",
      selectedGenderIconBackgroundColor: Colors.black,
      linearGradient: LinearGradient(colors: [Colors.transparent, Colors.grey]),
      checkIconAlignment: Alignment.centerRight,
      selectedGenderCheckIcon: Icons.check,
      selectedGender: selectedGender,
      onChanged: (Gender gender) {
        selectedGender = gender;
      },
      equallyAligned: true,
      animationDuration: Duration(milliseconds: 400),
      isCircular: true, // default : true,
      isSelectedGenderIconCircular: true,
      opacityOfGradient: 0.6,
      padding: EdgeInsets.all(3),
      size: 100,
    );
  }

  _scrollListener() {
    if (_scrollController.offset > _scrollController.position.minScrollExtent) {
      setState(() {
        elevation = 20.0;
      });
    } else {
      setState(() {
        elevation = 0.0;
      });
    }
  }

  void onTimeChanged(TimeOfDay newTime) {
    setState(() {
      selectedTime = newTime;
    });
  }

  void getCarouselPictures() async {
    final records = await Firestore.instance.collection('info').getDocuments();
    for (var record in records.documents) {
      if (record.data.containsKey('carouselpics')) {
        for (int i = 0; i < record.data['carouselpics'].length; i++) {
          carouselPictures.add(record.data['carouselpics'][i]);
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    selectedDate = DateTime.now();
    selectedTime = TimeOfDay.now();
    getCarouselPictures();
  }
}

class HomeCarousel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200.0,
      child: Stack(
        children: [
          Carousel(
            images: [
              ExactAssetImage('assets/ResPic5.jpg'),
              ExactAssetImage('assets/ResPic2.jpg'),
              ExactAssetImage('assets/ResPic3.jpg'),
              ExactAssetImage('assets/ResPic4.jpg'),
            ],
            showIndicator: false,
            borderRadius: false,
            autoplayDuration: Duration(seconds: 10),
            animationDuration: Duration(seconds: 1),
            moveIndicatorFromBottom: 180.0,
            noRadiusForIndicator: true,
            overlayShadow: true,
            overlayShadowColors: Colors.black,
            overlayShadowSize: 0.5,
            boxFit: BoxFit.cover,
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 8.0),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Text('Tap to check out',
                  style: TextStyle(color: Colors.white, letterSpacing: 2.0)),
            ),
          )
        ],
      ),
    );
  }
}
