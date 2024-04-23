class Operating {
  String carrierCode;

  Operating({
    required this.carrierCode,
  });

  factory Operating.fromJson(Map<String, dynamic> json) {
    return Operating(
      carrierCode: json['carrierCode'],
    );
  }

  @override
  String toString() {
    return 'Operating { '
        'carrierCode: $carrierCode '
        '}';
  }
}
