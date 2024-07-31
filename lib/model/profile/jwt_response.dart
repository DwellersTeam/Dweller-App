import 'package:dweller/model/profile/user_profile_model.dart';





class JwtModel {
  final Preference preferences;
  final String id;
  final String firstname;
  final String lastname;
  final String email;
  final bool online;
  final bool pro;
  final String role;
  final String status;
  final String displayPicture;  //picture

  final LocationInfo location;   //LocationInfo to be
  final bool property;   //to check if a user has property
  final String dwellerKind;

  //added for future
  final String isKYCVerified; //PENDING, UNVERIFIED, VERIFIED,
  final bool isPhoneVerified;  //true or false
  

  JwtModel({
    required this.preferences,
    required this.id,
    required this.firstname, 
    required this.lastname, 
    required this.email,   
    required this.online, 
    required this.pro, 
    required this.role, 
    required this.status, 
    required this.displayPicture,
    

    required this.location,
    required this.property,
    required this.dwellerKind,

    required this.isKYCVerified,
    required this.isPhoneVerified,
    
  });

  factory JwtModel.fromJson(Map<String, dynamic> json) {
    return JwtModel(
      preferences: Preference.fromJson(json['preferences'] ?? {}),
      id: json['_id'] ?? '',
      firstname: json['firstname'] ?? '',
      lastname: json['lastname'] ?? '',
      email: json['email'] ?? '',
      online: json['online'] ?? false,
      pro: json['pro'] ?? false,
      role: json['role'] ?? '',
      status: json['status'] ?? '',
      displayPicture: json['picture'] ?? '',
      location: LocationInfo.fromJson(json['location'] ?? {}),
      property: json['property'] ?? false,
      dwellerKind: json['dwellerKind'] ?? '',

      isKYCVerified: json['isKycVerified'] ?? '',
      isPhoneVerified: json['isPhoneVerified'] ?? false

    );
  }


  Map<String, dynamic> toJson() {
    return {
      'preferences': preferences.toJson(),
      'id': id,
      'firstname': firstname,
      'lastname': lastname,
      'email': email,
      'online': online ,
      'pro': pro,
      'role': role, 
      
      'status': status,
      'picture': displayPicture,
      'displayPicture': displayPicture,

      'location': location.toJson(),
      'property': property,
      'dwellerKind': dwellerKind,

      'isKYCVerified': isKYCVerified,
      'isPhoneVerified': isPhoneVerified,
    };
  }
}
