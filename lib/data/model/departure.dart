class Departure {
  final String iataCode;
  final String at;

  Departure({
    required this.iataCode,
    required this.at,
  });

  factory Departure.fromJson(Map<String, dynamic> json) {
    return Departure(
      iataCode: json['iataCode'],
      at: json['at'],
    );
  }
  @override
  String toString() {
    return 'Departure { '
        'iataCode: $iataCode, '
        'at: $at '
        '}';
  }
}
