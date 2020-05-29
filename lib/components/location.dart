import 'package:url_launcher/url_launcher.dart';

class MapUtils {

  Future<void> openMap() async {

    String googleUrl = 'https://www.google.com/maps/place/Pareez/@22.499859,88.3817163,17z/data=!3m1!4b1!4m5!3m4!1s0x3a02714844914921:0xa169ac5f26d5bc9d!8m2!3d22.499859!4d88.383905';
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      throw 'Could not open the map.';
    }
  }
}

class CallsAndMessagesService {
  void call() => launch("tel:7890791339");
}