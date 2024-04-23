class Arrival {
  final String iataCode;
  // final String terminal;
  final String at;

  Arrival({
    required this.iataCode,
    // required this.terminal,
    required this.at,
  });

  factory Arrival.fromJson(Map<String, dynamic> json) {
    return Arrival(
      iataCode: json['iataCode'],
      // terminal: json['terminal'],
      at: json['at'],
    );
  }
  @override
  String toString() {
    return 'Arrival { '
        'iataCode: $iataCode, '
        // 'terminal: $terminal, '
        'at: $at '
        '}';
  }
}
