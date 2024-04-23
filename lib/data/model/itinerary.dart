import 'package:planeapp/data/model/segment.dart';

class Itinerary {
  final String duration;
  final List<Segment> segments;

  Itinerary({
    required this.duration,
    required this.segments,
  });

  factory Itinerary.fromJson(Map<String, dynamic> json) {
    final List<dynamic> segmentsList = json['segments'];
    return Itinerary(
      duration: json['duration'],
      segments:
          segmentsList.map((segment) => Segment.fromJson(segment)).toList(),
    );
  }
  @override
  String toString() {
    return 'Itinerary { '
        'duration: $duration, '
        'segments: $segments '
        '}';
  }
}
