import 'package:new_project/features/family_management/data/model/father_model.dart';
import 'package:new_project/features/family_management/data/model/mother_model.dart';
import 'package:new_project/features/personal_management/data/models/person_model.dart';
import 'package:new_project/features/staff_management/data/model/employee_model.dart';

class SearchPersonResponse {
  final String? message;
  final PersonData? data;

  SearchPersonResponse({
    this.message,
    this.data,
  });

  factory SearchPersonResponse.fromJson(Map<String, dynamic> json) {
    print("\n\n\n.........................................$json\n\n\n");
    return SearchPersonResponse(
      message: json['message'],
      data: json['data'] != null ? PersonData.fromJson(json['data']) : null,
    );
  }
}

class PersonData {
  final PersonModel? person;
  final FatherModel? father;
  final MotherModel? mother;
  final EmployeeModel? employee;

  PersonData({
    this.person,
    this.father,
    this.mother,
    this.employee,
  });

  factory PersonData.fromJson(Map<String, dynamic> json) {
    print("\n\n\n.........................................$json\n\n\n");
    return PersonData(
      person:
          json['person'] != null ? PersonModel.fromJson(json['person']) : null,
      father:
          json['father'] != null ? FatherModel.fromJson(json['father']) : null,
      mother:
          json['mother'] != null ? MotherModel.fromJson(json['mother']) : null,
      employee: json['employee'] != null
          ? EmployeeModel.fromJson(json['employee'])
          : null,
    );
  }
}
