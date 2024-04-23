import 'package:planeapp/data/model/aircraft.dart';
import 'package:planeapp/data/model/arrival.dart';
import 'package:planeapp/data/model/departure.dart';

class Segment {
  final Departure departure;
  final Arrival arrival;
  final String carrierCode;
  final String number;
  final Aircraft aircraft;
  // final Operating operating;
  final String duration;
  final String id;
  final int numberOfStops;
  final bool blacklistedInEU;

  Segment({
    required this.departure,
    required this.arrival,
    required this.carrierCode,
    required this.number,
    required this.aircraft,
    // required this.operating,
    required this.duration,
    required this.id,
    required this.numberOfStops,
    required this.blacklistedInEU,
  });

  factory Segment.fromJson(Map<String, dynamic> json) {
    return Segment(
      departure: Departure.fromJson(json['departure']),
      arrival: Arrival.fromJson(json['arrival']),
      carrierCode: json['carrierCode'],
      number: json['number'],
      aircraft: Aircraft.fromJson(json['aircraft']),
      // operating: Operating.fromJson(json['operating']),
      duration: json['duration'],
      id: json['id'],
      numberOfStops: json['numberOfStops'],
      blacklistedInEU: json['blacklistedInEU'],
    );
  }
  @override
  String toString() {
    return 'Segment { '
        'departure: $departure, '
        'arrival: $arrival, '
        'carrierCode: $carrierCode, '
        'number: $number, '
        'aircraft: $aircraft, '
        // 'operating: $operating, '
        'duration: $duration, '
        'id: $id, '
        'numberOfStops: $numberOfStops, '
        'blacklistedInEU: $blacklistedInEU '
        '}';
  }
}
