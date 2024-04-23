class FareDetailsBySegment {
  final String segmentId;
  final String cabin;
  final String fareBasis;
  final String classtype;
  // IncludedCheckedBags includedCheckedBags;

  FareDetailsBySegment({
    required this.segmentId,
    required this.cabin,
    required this.fareBasis,
    required this.classtype,
    // required this.includedCheckedBags,
  });

  factory FareDetailsBySegment.fromJson(Map<String, dynamic> json) {
    return FareDetailsBySegment(
      segmentId: json['segmentId'],
      cabin: json['cabin'],
      fareBasis: json['fareBasis'],
      classtype: json['class'],
      // includedCheckedBags:
      //     IncludedCheckedBags.fromJson(json['includedCheckedBags']),
    );
  }
  @override
  String toString() {
    return 'FareDetailsBySegment { '
        'segmentId: $segmentId, '
        'cabin: $cabin, '
        'fareBasis: $fareBasis, '
        'class: $classtype, '
        // 'includedCheckedBags: $includedCheckedBags '
        '}';
  }
}
