

class CardResponse{
  CardResponse({
    required this.id,
    required this.user,
    required this.number,
    required this.expiry,
    required this.cvv,
    required this.cardHolderName,
    required this.type,
    required this.active,
    required this.createdAt,
  });
  //final KYC kyc;
  final String id;
  final String user;
  final String number;
  final String expiry;
  final String cvv;
  final String cardHolderName;
  final String type;
  bool active;
  final String createdAt;


  factory CardResponse.fromJson(Map<String, dynamic> json) {
    return CardResponse(
      id: json['_id'] ?? '',
      user: json['user'] ?? '',
      number: json['number'] ?? '',
      expiry: json['expiry'] ?? "",
      cvv: json['cvv'] ?? "",
      cardHolderName: json['name'] ?? "null",
      type: json['type'] ?? "",
      active: json['active'] ?? false,
      createdAt: json['createdAt'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "user": user,
      "number": number,
      "expiry": expiry,
      "cvv": cvv,
      "name": cardHolderName,
      "type": type,
      "active": active,
      "createdAt": createdAt
    };

  }
}