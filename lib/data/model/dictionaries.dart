class DictionaryData {
  final List<Location> locations;
  final List<Aircraft> aircrafts;
  final List<Currency> currencies;
  final List<Carrier> carriers;

  DictionaryData({
    required this.locations,
    required this.aircrafts,
    required this.currencies,
    required this.carriers,
  });

  factory DictionaryData.fromJson(Map<String, dynamic> json) {
    return DictionaryData(
      locations: (json['dictionaries']['locations'] as Map<String, dynamic>)
          .values
          .map<Location>((value) => Location.fromJson(value))
          .toList(),
      aircrafts: (json['dictionaries']['aircraft'] as Map<String, dynamic>)
          .entries
          .map<Aircraft>(
              (entry) => Aircraft(code: entry.key, name: entry.value))
          .toList(),
      currencies: (json['dictionaries']['currencies'] as Map<String, dynamic>)
          .entries
          .map<Currency>(
              (entry) => Currency(code: entry.key, name: entry.value))
          .toList(),
      carriers: (json['dictionaries']['carriers'] as Map<String, dynamic>)
          .entries
          .map<Carrier>((entry) => Carrier(code: entry.key, name: entry.value))
          .toList(),
    );
  }
}

class Location {
  final String cityCode;
  final String countryCode;

  Location({
    required this.cityCode,
    required this.countryCode,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      cityCode: json['cityCode'],
      countryCode: json['countryCode'],
    );
  }
}

class Aircraft {
  final String code;
  final String name;

  Aircraft({
    required this.code,
    required this.name,
  });
}

class Currency {
  final String code;
  final String name;

  Currency({
    required this.code,
    required this.name,
  });
}

class Carrier {
  final String code;
  final String name;

  Carrier({
    required this.code,
    required this.name,
  });
}
