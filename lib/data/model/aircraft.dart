class Aircraft {
  final String code;
  Aircraft({
    required this.code,
  });

  factory Aircraft.fromJson(Map<String, dynamic> json) {
    return Aircraft(
      code: json['code'],
    );
  }

  @override
  String toString() {
    return 'Aircraft { '
        'code: $code '
        '}';
  }
}
