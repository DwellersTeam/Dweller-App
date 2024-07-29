

class TokenResponse{
  TokenResponse({
    required this.accessToken,
    required this.refreshToken,
  });
  final String accessToken;
  final String refreshToken;


  factory TokenResponse.fromJson(Map<String, dynamic> json) {
    return TokenResponse(
      accessToken: json['accessToken'] ?? '',
      refreshToken: json['refreshToken'] ?? ''
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'accessToken': accessToken,
      'refreshToken': refreshToken
    };
  }
}
