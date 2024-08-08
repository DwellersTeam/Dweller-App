
class KYC{

  KYC({
    required this.status,
  });
  final String status;


  factory KYC.fromJson(Map<String, dynamic> json) {
    return KYC(
      status: json['status'] ?? 'null', //pending //approved //check is kyc status is not empty
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
    };
  }
}



class SettingsResponse{
  SettingsResponse({
    required this.kyc,
    required this.id,
    required this.user,
    required this.pushNotification,
    required this.emailNotification,
    required this.showOnDweller,
    required this.showOnline,
    required this.pro,
    required this.createdAt,
  });
  final KYC kyc;
  final String id;
  final String user;
  final String createdAt;
  bool pushNotification;
  bool emailNotification;
  bool showOnDweller;
  bool showOnline;
  bool pro;


  factory SettingsResponse.fromJson(Map<String, dynamic> json) {
    return SettingsResponse(
      createdAt: json['createdAt'] ?? '',
      kyc: KYC.fromJson(json['kyc'] ?? {}),
      id: json['_id'] ?? 'null',
      user: json['user'] ?? 'user id',
      pushNotification: json['pushNotification'] ?? false,
      emailNotification: json['emailNotification'] ?? false,
      showOnDweller: json['showOnDweller'] ?? false,
      showOnline: json['showOnline'] ?? false,
      pro: json['pro'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'createdAt': createdAt,
      'kyc': kyc,
      '_id': id,
      'user': user,
      'pushNotification': pushNotification,
      'emailNotification': emailNotification,
      'showOnDweller': showOnDweller,
      'showOnline': showOnline,
      'pro': pro
    };
  }
}
