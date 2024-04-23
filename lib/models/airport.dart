class Airport {
  final String iata;
  final double lon;
  final String iso;
  final int status;
  final String name;
  final String continent;
  final String type;
  final double lat;
  final String size;

  Airport({
    required this.iata,
    required this.lon,
    required this.iso,
    required this.status,
    required this.name,
    required this.continent,
    required this.type,
    required this.lat,
    required this.size,
  });

  factory Airport.fromJson(Map<String, dynamic> json) {
    return Airport(
      iata: json['iata'],
      lon: double.parse(json['lon']),
      iso: json['iso'],
      status: json['status'],
      name: json['name'],
      continent: json['continent'],
      type: json['type'],
      lat: double.parse(json['lat']),
      size: json['size'],
    );
  }
  List<Airport> getAirportsByName(List<Airport> airports, String name) {
    return airports
        .where((airport) =>
            airport.name.toLowerCase().contains(name.toLowerCase()))
        .toList();
  }
}
