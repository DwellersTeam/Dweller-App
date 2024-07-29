

class VerifyEmailResponse{
  VerifyEmailResponse({
    required this.otp,
    required this.refreshToken,
  });
  final String otp;
  final String refreshToken;


  factory VerifyEmailResponse.fromJson(Map<String, dynamic> json) {
    return VerifyEmailResponse(
      otp: json['otp'] ?? '',
      refreshToken: json['refreshToken'] ?? ''
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'otp': otp,
      'refreshToken': refreshToken
    };
  }
}