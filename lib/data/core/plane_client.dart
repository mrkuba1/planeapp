import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:planeapp/amadeus.dart';
import 'package:planeapp/data/core/base_client.dart';
import 'package:planeapp/data/model/flight_offer.dart';

class PlaneClient extends PABaseClient {
  Future fetchFlightOffers(String departureCode, String arrivalCode,
      String numberOfAdults, String departureDate, String arrvialDate) async {
    Amadeus amadeus = Amadeus();
    String? accessToken = amadeus.token == null
        ? await amadeus.generateAccessToken()
        : amadeus.token.toString();
    String departureDateTrimmed = departureDate.substring(0, 10);
    String returnDateTrimmed = arrvialDate.substring(0, 10);

    String apiUrl =
        'https://test.api.amadeus.com/v2/shopping/flight-offers?originLocationCode=$departureCode&destinationLocationCode=$arrivalCode&departureDate=$departureDateTrimmed&adults=$numberOfAdults&nonStop=false&max=250';

    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {"Authorization": "Bearer $accessToken"},
    );
    // print(apiUrl);

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = json.decode(response.body);
      final List<dynamic> offersJson = jsonData['data'];
      List<FlightOffer> flightOffers = offersJson
          .map((offerJson) => FlightOffer.fromJson(offerJson))
          .toList();
      return flightOffers;
    } else {
      throw Exception('Failed to load flight offers ${response.statusCode}');
    }
  }
}
