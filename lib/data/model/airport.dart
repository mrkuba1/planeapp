class AirportInfo {
  String iata;
  String name;
  double lon;
  double lat;
  String iso;
  int status;
  String continent;
  String type;
  String size;

  AirportInfo({
    required this.iata,
    required this.name,
    required this.lon,
    required this.lat,
    required this.iso,
    required this.status,
    required this.continent,
    required this.type,
    required this.size,
  });

  factory AirportInfo.fromMap(Map<String, dynamic> map) {
    return AirportInfo(
      iata: map['iata'],
      name: map['name'],
      lon: double.parse(map['lon']),
      lat: double.parse(map['lat']),
      iso: map['iso'],
      status: map['status'],
      continent: map['continent'],
      type: map['type'],
      size: map['size'],
    );
  }
}
