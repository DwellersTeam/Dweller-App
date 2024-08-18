class MessageResponse{

  MessageResponse({
    required this.messageId,
    required this.from,
    required this.to,
    required this.content,
    required this.imageUrl,
    required this.isHidden,
    required this.createdAt,
  });
  final String messageId;
  final String from;
  final String to;
  final String content;
  final String imageUrl;
  final List<dynamic> isHidden;
  final String createdAt;



  factory MessageResponse.fromJson(Map<String, dynamic> json) {
    return MessageResponse(
      messageId: json['_id'] ?? "",
      from: json['from'] ?? '',
      to: json['to'] ?? '',
      content: json["content"] ?? "",
      imageUrl: json['imageUrl'] ?? '',
      isHidden: json["isHidden"] ?? "",
      createdAt: json['createdAt'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': messageId,
      'from': from,
      'to': to,
      "isHidden": isHidden,
      'content': content,
      'imageUrl': imageUrl,
      'createdAt': createdAt,
    };
  }
}
