class CouponLine {
  String? code;

  CouponLine({this.code});

  factory CouponLine.fromJson(Map<String, dynamic> json) =>
      CouponLine(code: json['code'] as String?);

  Map<String, dynamic> toJson() => {'code': code};
}
