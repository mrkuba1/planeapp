class IncludedCheckedBags {
  final int weight;
  final String weightUnit;

  IncludedCheckedBags({
    required this.weight,
    required this.weightUnit,
  });

  factory IncludedCheckedBags.fromJson(Map<String, dynamic> json) {
    return IncludedCheckedBags(
      weight: json['weight'],
      weightUnit: json['weightUnit'],
    );
  }
  @override
  String toString() {
    return 'IncludedCheckedBags { '
        'weight: $weight, '
        'weightUnit: $weightUnit '
        '}';
  }
}
