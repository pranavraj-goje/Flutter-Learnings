import 'dart:convert';

import 'package:http/http.dart' as http;

const MAPBOX_API_KEY =
    'pk.eyJ1IjoicHJhbmF2cmFqZzIzIiwiYSI6ImNrdDM1YnBhbDBxdmsyb21tdHJidGU5a3YifQ.YaWor9L-iObK1DT-pnT_tQ';
const GOOGLE_API_KEY = '';
const POSITION_STACK_API_KEY = '288f093d50474175f9658346a85ff71e';

class LocationHelper {
  static String generateLocationPreviewImage(
      {double latitude, double longitude}) {
    if (MAPBOX_API_KEY == '') {
      return null;
    }
    return 'https://api.mapbox.com/styles/v1/mapbox/streets-v11/static/pin-l($longitude,$latitude)/$longitude,$latitude,14.25,0,0/600x300?access_token=$MAPBOX_API_KEY';
  }

  static Future<String> getPlaceAddress(double lat, double long) async {
    final url = Uri.parse(
        'http://api.positionstack.com/v1/reverse?access_key=$POSITION_STACK_API_KEY&query=$lat,$long');
    final response = await http.get(url);
    final extractedData = json.decode(response.body);
    String address = '${(extractedData['data'][2]['label'])}';
    return address;
  }
}

class PositionHelper {
  static Future<List<String>> generateLocationPreviewImage(
      {String city, String state}) async {
    final url = Uri.parse(
        'http://api.positionstack.com/v1/forward?access_key=$POSITION_STACK_API_KEY&query=$city,$state');

    final response = await http.get(url);
    final extractedData = json.decode(response.body);
    final latitude = extractedData['data'][0]['latitude'];
    final longitude = extractedData['data'][0]['longitude']; 
    // print(extractedData);
    return ['https://api.mapbox.com/styles/v1/mapbox/streets-v11/static/pin-l($longitude,$latitude)/$longitude,$latitude,14.25,0,0/600x300?access_token=$MAPBOX_API_KEY', latitude.toString(), longitude.toString()];
  }
}
