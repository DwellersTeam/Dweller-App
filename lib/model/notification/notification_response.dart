

class NotificationResponse{
  NotificationResponse({
    required this.title,
    required this.subtitle,
    required this.type,
    required this.timestamp,
    required this.id,
  });
  final String id;
  final String title;
  final String subtitle;
  final String type;
  final String timestamp;


  factory NotificationResponse.fromJson(Map<String, dynamic> json) {
    return NotificationResponse(
      id: json['_id'] ?? 'null',
      title: json['title'] ?? 'null',
      subtitle: json['subtitle'] ?? 'null',
      type: json['type'] ?? 'null',
      timestamp: json['createdAt'] ?? 'null',

    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'title': title,
      'subtitle': subtitle,
      'type': type,
      'created_at': timestamp
    };
  }
}
