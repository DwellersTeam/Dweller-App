

class GoogleSigninResponse{
  GoogleSigninResponse({
    required this.accessToken,
    required this.refreshToken,
    required this.isUserNew,
  });
  final String accessToken;
  final String refreshToken;
  bool isUserNew;


  factory GoogleSigninResponse.fromJson(Map<String, dynamic> json) {
    return GoogleSigninResponse(
      accessToken: json['accessToken'] ?? '',
      refreshToken: json['refreshToken'] ?? '',
      isUserNew: json['new'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'accessToken': accessToken,
      'refreshToken': refreshToken,
      'new': isUserNew
    };
  }
}
