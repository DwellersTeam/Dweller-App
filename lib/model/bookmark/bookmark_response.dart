import 'package:dweller/model/profile/user_profile_model.dart';



class BookmarkResponse{

  BookmarkResponse({
    required this.status,
    required this.id,
    required this.user,
    required this.createdAt,
    required this.profile,
    required this.to
  });

  final String status;
  final String id;
  final String user;
  final String createdAt;
  final UserModel profile;
  final UserModel to;


  factory BookmarkResponse.fromJson(Map<String, dynamic> json) {
    return BookmarkResponse(
      status: json['status'] ?? '', //pending //approved //check is kyc status is not empty
      id: json['_id'] ?? '',
      user: json['user'] ?? '',
      createdAt: json['createdAt'] ?? '',
      profile: UserModel.fromJson(json['profile'] ?? {}),
      to: UserModel.fromJson(json['to'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      '_id': id,
      'user': user,
      'createdAt': createdAt,
      'profile': profile.toJson(),
      'to': to.toJson(),
    };
  }
}
