import 'package:basics_2/theme13/features/domain/entities/person_entity.dart';

class LocationModel extends LocationEntity{
  LocationModel({required super.name, required super.url});

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      name: json['name'] as String,
      url: json['url'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'url': url,
    };
  }

}