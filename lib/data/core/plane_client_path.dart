enum PlaneClientPath {
  flightoffers;

  const PlaneClientPath();

  String get path {
    switch (this) {
      case PlaneClientPath.flightoffers:
        return '/v2/shopping/flight-offers';
      default:
        return '';
    }
  }

  Uri getUriFlightOffers(String departureCode, String arrivalCode,
      String departureDate, String arrivalDate, String numberOfAdults) {
    final baseUri = Uri.https('test.api.amadeus.com', path, {
      'originLocationCode': departureCode,
      'destinationLocationCode': arrivalCode,
      'departureDate': departureDate,
      'adults': numberOfAdults
    });

    return baseUri;
  }
}
