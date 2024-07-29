


class RegisterResponse{
  RegisterResponse({
    required this.accessToken,
    required this.refreshToken,
  });
  final String accessToken;
  final String refreshToken;


  factory RegisterResponse.fromJson(Map<String, dynamic> json) {
    return RegisterResponse(
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
