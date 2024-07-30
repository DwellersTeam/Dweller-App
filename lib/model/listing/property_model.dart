import 'package:dweller/model/listing/facility_model.dart';
import 'package:dweller/model/location/places.dart';
import 'package:dweller/model/profile/user_profile_model.dart';



//for fetch logged in user property by he's id
class PropertyModel{
  PropertyModel({
    required this.buildingType,
    required this.rooms,
    required this.floors,
    required this.size,
    required this.rent,
    required this.location,
    required this.facilities,
    required this.propertyPics,
    required this.id,
  });
  final String id;
  final String buildingType;
  final num rooms;
  final num floors;
  final num size;
  final num rent;
  final Location location;
  final List<dynamic> facilities;
  final List<dynamic> propertyPics;

  factory PropertyModel.fromJson(Map<String, dynamic> json) {
    return PropertyModel(
      id: json['user'] ?? 'null',
      buildingType: json['building'] ?? 'null',
      rooms: json['rooms'] ?? 0,
      floors: json['floors'] ?? 0,
      size: json['size'] ?? 0,
      rent: json['rent'] ?? 0,
      location: Location.fromJson(json['location'] ?? {}),
      facilities: json['facilities'] ?? [], //(json['facilities'] as List<String>?)?.map((detailsJson) => FacilityModel.fromJson(e)).toList() ?? [],
      propertyPics: json['pictures'] ?? [],

    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user': id,
      'buildingType': buildingType,
      'rooms': rooms,
      'floors': floors,
      'size': size,
      'rent': rent,
      'location': location.toJson(),
      'facilities': facilities,
      'pictures': propertyPics,

    };
  }
}




//for fetching list of users by their location(HOSTS)

class PropertyHostModel{
  PropertyHostModel({
    required this.buildingType,
    required this.rooms,
    required this.floors,
    required this.size,
    required this.rent,
    required this.location,
    required this.facilities,
    required this.propertyPics,
    required this.propertyOwner,
    required this.id,
  });
  final String id;
  final String buildingType;
  final num rooms;
  final num floors;
  final num size;
  final num rent;
  final Location location;
  final List<dynamic> facilities;
  final List<dynamic> propertyPics;
  final UserModel propertyOwner;

  factory  PropertyHostModel.fromJson(Map<String, dynamic> json) {
    return  PropertyHostModel(
      id: json['user'] ?? 'null',
      buildingType: json['building'] ?? 'null',
      rooms: json['rooms'] ?? 0,
      floors: json['floors'] ?? 0,
      size: json['size'] ?? 0,
      rent: json['rent'] ?? 0,
      location: Location.fromJson(json['location'] ?? {}),
      facilities: json['facilities'] ?? [], //(json['facilities'] as List<String>?)?.map((detailsJson) => FacilityModel.fromJson(e)).toList() ?? [],
      propertyPics: json['pictures'] ?? [],
      propertyOwner: UserModel.fromJson(json['profile'] ?? {}) //owner

    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user': id,
      'buildingType': buildingType,
      'rooms': rooms,
      'floors': floors,
      'size': size,
      'rent': rent,
      'location': location.toJson(),
      'facilities': facilities,
      'pictures': propertyPics,
      'profile': propertyOwner.toJson()

    };
  }
}
