import 'package:json_annotation/json_annotation.dart';
import 'package:new_project/features/personal_management/data/models/area_model.dart';
import 'nationality_model.dart';

//part 'person_model.g.dart';

@JsonSerializable()
class PersonModel {
  final int? id;
  final String first_name;
  final String last_name;
  final String gender;
  final String? email;
  final String? phone_number;
  final String identity_card_number;
  final bool isDeceased;
  final int nationalities_id;
  final int? location_id;
  
   final DateTime? birthDate;
  
  @JsonKey(name: 'location')
  final AreaModel? location;
  
  @JsonKey(name: 'nationality')
  final NationalityModel? nationality;

  PersonModel({
    required this.id,
    required this.first_name,
    required this.last_name,
    required this.gender,
    this.email,
    this.phone_number,
    required this.identity_card_number,
    required this.isDeceased,
    required this.nationalities_id,
    this.location_id,
    this.location,
    this.nationality,
    this.birthDate,
  });


  factory PersonModel.fromJson(Map<String, dynamic> json) => PersonModel(
  id: (json['id'] as num).toInt(),
  first_name: json['first_name'] as String,
  last_name: json['last_name'] as String,
  gender: json['gender'] as String,
  email: json['email'] as String?,
  phone_number: json['phone_number'] as String?,
  identity_card_number: json['identity_card_number'] as String,

  isDeceased: json['isDeceased'] == 1, 

  nationalities_id: (json['nationalities_id'] as num).toInt(),
  location_id: (json['location_id'] as num?)?.toInt(),
  location: json['location'] == null
      ? null
      : AreaModel.fromJson(json['location'] as Map<String, dynamic>),

  nationality: json['nationality'] == null
      ? null
      : NationalityModel.fromJson(json['nationality'] as Map<String, dynamic>),
  birthDate: json['birthDate'] == null
      ? null
      : DateTime.parse(json['birthDate'] as String),
);

  get firstName => null;

  get identityCardNumber => null;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'first_name': first_name,
      'last_name': last_name,
      'gender': gender,
      'email': email,
      'phone_number': phone_number,
      'identity_card_number': identity_card_number,
      'isDeceased': isDeceased,
      'nationalities_id': nationalities_id,
      'location_id': location_id,
      //'location': location?.toJson(),
      'nationality': nationality?.toJson(),
      'birthDate': birthDate?.toIso8601String(),

    };
  }
}