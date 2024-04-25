import 'dart:convert';
import 'package:http/http.dart';

class Amadeus {
  String? token;
  Future<String?> generateAccessToken() async {
    String clientId = "vhC1bo8myDra3Gpvd453qC5LnKGaNiiP";
    String clientSecret = "C3L6EVWnJ8rySkyd";
    Uri authorizationUri =
        Uri.parse("https://test.api.amadeus.com/v1/security/oauth2/token");
    Response response;
    try {
      response = await post(authorizationUri,
          headers: {"Content-type": "application/x-www-form-urlencoded"},
          body:
              "grant_type=client_credentials&client_id=$clientId&client_secret=$clientSecret");
    } catch (e) {
      return "Unable to generate access token due to error $e";
    }
    Map data = jsonDecode(response.body);
    token = data['access_token'];
    return token;
  }
}
