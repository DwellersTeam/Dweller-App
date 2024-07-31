



class UserModel {
  final Preference preferences;
  final String id;
  final String firstname;
  final String lastname;
  final String email;
  final String bio;
  final List<dynamic> pictures;
  final String fcmToken;
  final String authProvider;
  final bool online;
  final bool pro;
  final String role;
  final String status;
  final String displayPicture;  //picture



  final String phone;
  final String password;
  final String dateOfBirth;
  final String username;
  final String gender;
  final String job;
  final LocationInfo location;   //LocationInfo to be
  final String school;
  final KYCInfo kyc; //document, url
  final String property;   //to check if a user has property
  final int age;
  final String zodiac;
  final String dwellerKind;

  //added for future
  final String isKYCVerified; //PENDING, UNVERIFIED, VERIFIED,
  final bool isPhoneVerified;  //true or false
  

  UserModel({
    required this.preferences,
    required this.id,
    required this.firstname, 
    required this.lastname, 
    required this.email, 
    required this.bio, 
    required this.pictures, 
    required this.fcmToken, 
    required this.authProvider, 
    required this.online, 
    required this.pro, 
    required this.role, 
    required this.status, 
    required this.displayPicture,
    
    required this.phone,
    required this.password,
    required this.dateOfBirth,
    required this.username,
    required this.gender,
    required this.job,
    required this.location,
    required this.school,
    required this.kyc,
    required this.property,
    required this.age,
    required this.zodiac,
    required this.dwellerKind,

    required this.isKYCVerified,
    required this.isPhoneVerified,
    
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      preferences: Preference.fromJson(json['preferences'] ?? {}),
      id: json['_id'] ?? '',
      firstname: json['firstname'] ?? '',
      lastname: json['lastname'] ?? '',
      email: json['email'] ?? '',
      bio: json['bio'] ?? '',
      pictures: json['pictures'] ?? [],
      fcmToken: json['fcmToken'] ?? '',
      authProvider: json['authProvider'] ?? '',
      online: json['online'] ?? false,
      pro: json['pro'] ?? false,
      role: json['role'] ?? '',
      status: json['status'] ?? '',
      displayPicture: json['picture'] ?? '',

      kyc: KYCInfo.fromJson(json['kyc'] ?? {}),
      phone: json['phone'] ?? '',
      password: json['password'] ?? '',
      dateOfBirth: json['dateOfBirth'] ?? '',
      username: json['username'] ?? '',
      gender: json['gender'] ?? '',
      job: json['job'] ?? '',
      location: LocationInfo.fromJson(json['location'] ?? {}),
      school: json['school'] ?? '',
      property: json['property'] ?? 'non',
      age: json['age'] ?? 0,
      zodiac: json['zodiac'] ?? '',
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
      'bio': bio,
      'pictures': pictures,
      'fcmToken': fcmToken,
      'authProvider': authProvider,
      'online': online ,
      'pro': pro,
      'role': role, 
      
      'status': status,
      'picture': displayPicture,
      'displayPicture': displayPicture,

      'kyc': kyc.toJson(),
      'phone': phone,
      'password': password,
      'dateOfBirth': dateOfBirth,
      'username': username,
      'gender': gender,
      'job': job,
      'location': location.toJson(),
      'school': school,
      'property': property,
      'age': age,
      'zodiac': zodiac,
      'dwellerKind': dwellerKind,

      'isKYCVerified': isKYCVerified,
      'isPhoneVerified': isPhoneVerified,
    };
  }
}



class LocationInfo {
  final String address;
  final String placeId;
  final num longitude;
  final num latitude;
  LocationInfo({
    required this.address,
    required this.placeId,
    required this.longitude,
    required this.latitude,
  });

  factory LocationInfo.fromJson(Map<String, dynamic> json) {
    return LocationInfo(
      address: json['address'] ?? '',
      placeId: json['placeId'] ?? '',
      longitude: json['longitude'] ?? 0,
      latitude: json['latitude'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'address': address,
      'placeId': placeId,
      'longitude': longitude,
      'latitude': latitude
    };
  }
}



class KYCInfo {
  final String document;
  final String url;
  KYCInfo({
    required this.document,
    required this.url,
  });

  factory KYCInfo.fromJson(Map<String, dynamic> json) {
    return KYCInfo(
      document: json['document'] ?? '',
      url: json['url'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'document': document,
      'url': url,
    };
  }
}



class Preference {
  final List<dynamic> livelihood;
  final List<dynamic> interests;
  final List<dynamic> pets;
  final String noise;
  final String smoke;
  final String alcohol;
  final String sleepSchedule;
  final String workStudySchedule;
  final String visitors;


  Preference({
    required this.livelihood,
    required this.interests,
    required this.pets,
    required this.noise,
    required this.smoke,
    required this.alcohol,
    required this.sleepSchedule,
    required this.workStudySchedule,
    required this.visitors,
  });

  factory Preference.fromJson(Map<String, dynamic> json) {
    return Preference(
      livelihood: json['livelihood'] ?? [],
      interests: json['interests'] ?? [],
      pets: json['pets'] ?? [],
      noise: json['noise'] ?? '',
      smoke: json['smoke'] ?? '',
      alcohol: json['alcohol'] ?? '',
      sleepSchedule: json['sleepSchedule'] ?? '',
      workStudySchedule: json["wrokStudySchedule"] ?? '',
      visitors: json["visitors"] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'livelihood': livelihood,
      'interests': interests,
      'pets': pets,
      'noise': noise,
      'smoke': smoke,
      'alcohol': alcohol,
      'sleepSchedule': sleepSchedule,
      'workStudySchedule': workStudySchedule,
      'visitors': visitors,
    };
  }
}



