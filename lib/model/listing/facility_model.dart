

class FacilityModel {
  final String name;
  final String icon;
  bool isSelected;

  FacilityModel({required this.name, required this.icon, this.isSelected = false});

  factory FacilityModel.fromJson(Map<String, dynamic> json) {
    return FacilityModel(
      name: json['name'] ?? 'null',
      icon: json['icon'] ?? 'null',
      isSelected: json['isSelected'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'icon': icon,
    };
  }
}