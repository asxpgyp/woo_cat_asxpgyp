class ReviewerAvatarUrls {
  String? s24;
  String? s48;
  String? s96;

  ReviewerAvatarUrls({this.s24, this.s48, this.s96});

  factory ReviewerAvatarUrls.fromJson(Map<String, dynamic> json) {
    return ReviewerAvatarUrls(
      s24: json['24'] as String?,
      s48: json['48'] as String?,
      s96: json['96'] as String?,
    );
    // final m = json['reviewer_avatar_urls'] as Map<String, dynamic>;
    // return ReviewerAvatarUrls(s24: m['24'] as String?, s48: m['48'] as String?, s96: m['96'] as String?);
  }

  Map<String, dynamic> toJson() => {'24': s24, '48': s48, '96': s96};
}
