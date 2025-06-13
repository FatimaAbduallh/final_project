import 'package:new_project/Core/networking/config/api_config.dart';

class PersonalEndpoints {
  String addPersonal = '${ApiConfig.baseUrl}personal';
  String mother = 'mother';
  String father = 'father';
  String guardian = 'guardians';
  String employee = 'employees';
  String child = 'children';
  String searchPerson = '${ApiConfig.baseUrl}person/search';
  String nationalitiesAndCities = '${ApiConfig.baseUrl}citiesAndNationalities';
  String areasByCity = '${ApiConfig.baseUrl}areas';
  String getNationalities = '${ApiConfig.baseUrl}nationalities';
}
