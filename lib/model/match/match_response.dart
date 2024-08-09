import 'package:dweller/model/profile/user_profile_model.dart';




class MatchResponse{

  MatchResponse({
    required this.status,
    required this.id,
    required this.createdAt,
    required this.from,
    required this.to
  });
  final String status;
  final String id;
  final String createdAt;
  final UserModel from;
  final UserModel to;


  factory MatchResponse.fromJson(Map<String, dynamic> json) {
    return MatchResponse(
      status: json['status'] ?? "null", //pending //accepted
      id: json['_id'] ?? '',
      createdAt: json['createdAt'] ?? '',
      from: UserModel.fromJson(json['from'] ?? {}),
      to: UserModel.fromJson(json['to'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      '_id': id,
      'createdAt': createdAt,
      'from': from.toJson(),
      'to': to.toJson(),
    };
  }
}
