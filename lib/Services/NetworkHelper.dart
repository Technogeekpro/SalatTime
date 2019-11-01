import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class NetworkHelper {
  final String url;

  NetworkHelper(this.url);

  Future getData() async{
    String data;
    http.Response response = await http.get(url);
    print(url);

    if(response.statusCode ==200) {
      data = response.body;
      print(jsonDecode(data)['data'][0]['timings']['Fajr']);
      return jsonDecode(data);

    }
    else {
      print(response.statusCode);
    }
  }
}


//Todo For future use
//data = response.body;
//['results']['datetime'][0]['times']['Asr']
//String IshaTime= jsonDecode(data)['items'][0]['maghrib'].toString();
//print(placemark[0].country);
//print(placemark[0].position);
//print(placemark[0].locality);
//print(placemark[0].administrativeArea);
//print(placemark[0].postalCode);
//print(placemark[0].name);
//print(placemark[0].isoCountryCode);
//print(placemark[0].subLocality);
//print(placemark[0].subThoroughfare);
//print(placemark[0].thoroughfare);
