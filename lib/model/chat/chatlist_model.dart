



class ChatListResponse{

  ChatListResponse({
    required this.fcmToken,
    required this.chatId,
    required this.userId,
    required this.picture,
    required this.name,
    required this.lastMessage,
    required this.createdAt,
    required this.online,
    required this.seen,
  });
  final String fcmToken;
  final String chatId;
  final String userId;
  final String picture;
  final String name;
  final String lastMessage;
  final String createdAt;
  final bool online;
  final bool seen;



  factory ChatListResponse.fromJson(Map<String, dynamic> json) {
    return ChatListResponse(
      fcmToken: json["fcmToken"] ?? '',
      chatId: json["_id"] ?? "",
      userId: json['userId'] ?? "",
      picture: json['picture'] ?? '',
      name: json['name'] ?? '',
      lastMessage: json['lastMessage'] ?? '',
      createdAt: json['createdAt'] ?? '',
      online: json['online'] ?? false,
      seen: json['seen'] ?? false
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "fcmToken": fcmToken,
      "chatId": chatId,
      "userId": userId,
      "picture": picture,
      "name": name,
      "lastMessage": lastMessage,
      "createdAt": createdAt,
      "online": online,
      'seen': seen
    };
  }
}
