

class CardResponse{
  CardResponse({
    required this.id,
    required this.user,
    required this.number,
    required this.expMonth,
    required this.expYear,
    required this.cvc,
    required this.cardHolderName,
    //required this.type,
    required this.active,
    required this.createdAt,
  });
  //final KYC kyc;
  final String id;
  final String user;
  final String number;
  final int expMonth;
  final int expYear;
  final String cvc;
  final String cardHolderName;
  //final String type;
  bool active;
  final String createdAt;


  factory CardResponse.fromJson(Map<String, dynamic> json) {
    return CardResponse(
      id: json['_id'] ?? '',
      user: json['user'] ?? '',
      number: json['number'] ?? '',
      expMonth: json['expMonth'] ?? 0,
      expYear: json['expYear'] ?? 0,
      cvc: json['cvc'] ?? "",
      cardHolderName: json['cardholderName'] ?? "Dweller",
      //type: json['type'] ?? "",
      active: json['active'] ?? false,
      createdAt: json['createdAt'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "user": user,
      "number": number,
      "expMonth": expMonth,
      "expYear": expYear,
      "cvv": cvc,
      "name": cardHolderName,
      //"type": type,
      "active": active,
      "createdAt": createdAt
    };

  }
}