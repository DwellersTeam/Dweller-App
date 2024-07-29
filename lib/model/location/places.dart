class Place {
  final String description;
  final String placeId;
  final String status;
  final List<dynamic> matched_substrings;

  Place({required this.status, required this.description, required this.placeId, required this.matched_substrings});

  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
      status: json['status'] ?? 'OK',
      description: json['description'] ?? 'desc',
      placeId: json['place_id'] ?? 'place_id',
      matched_substrings: json["matched_substrings"] ?? [],
    );
  }
}


class Location{
  final String address;
  final String placeId;
  final num latitude;
  final num longitude;

  Location({required this.address, required this.placeId, required this.latitude, required this.longitude});

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      address: json['address'] ?? 'null',
      placeId: json['placeId'] ?? 'null',
      latitude: json['latitude'] ?? 0,
      longitude: json["longitude"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'address': address,
      'placeId': placeId,
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}