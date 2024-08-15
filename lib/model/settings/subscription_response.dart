
class SubscriptionResponse{

  SubscriptionResponse({
    required this.customerId,
    required this.subscriptionId,
    required this.clientSecret
  });
  final String customerId;
  final String subscriptionId;
  final String clientSecret;


  factory SubscriptionResponse.fromJson(Map<String, dynamic> json) {
    return SubscriptionResponse(
      customerId: json['customerId'] ?? 'null',
      subscriptionId: json['subscriptionId'] ?? "null",
      clientSecret: json['clientSecret'] ?? "null"
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "customerId": customerId,
      "subscriptionId": subscriptionId,
      "clientSecret": clientSecret
    };
  }
}



