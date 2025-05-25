import 'package:new_project/Core/helpers/dropdown_helper/dropdown_storage_helper.dart';
import 'package:new_project/Core/networking/api_error_handler.dart';
import 'package:new_project/features/personal_management/data/models/SimpleNationalityModel.dart';
import 'package:new_project/features/personal_management/data/models/area_model.dart';
import 'package:new_project/features/personal_management/data/models/city_model.dart';
import 'package:new_project/features/personal_management/data/models/nationalitiesAndcities_model.dart';
import 'package:new_project/features/personal_management/data/models/personalTyp.dart';
import 'package:new_project/features/personal_management/domain/repositories/personal_repo.dart';
import 'package:new_project/Core/networking/api_result.dart';

mixin PersonHelperMixin {
  late final PersonRepository personRepository;

  List<SimpleNationalityModel> nationalities = [];
  List<CityModel> cities = [];
  List<AreaModel> areas = [];

  int? selectedNationalityId;
  String? selectedCity;
  int? selectedAreaId;

  void setRepository(PersonRepository repo) {
    personRepository = repo;
  }

  Future<ApiResult<NationalitiesAndCitiesModel>> getNationalitiesAndCities(
      PersonType type) async {
    final cachedData = await DropdownStorageHelper.getDropdownsData();
    print('Cached Data: $cachedData');
    print('Cached Nationalities: ${cachedData?.nationalities}');

    if (cachedData != null) {
      nationalities = cachedData.nationalities;
      cities = cachedData.cities;
      return ApiResult.success(cachedData);
    }
    print('Fetching data from API...');
    final result = await personRepository.getNationalitiesAndCities(type);
    return result.when(success: (data) async {
      print('Fetched Nationalities: ${data.$1}');
      print('Fetched Cities: ${data.$2}');
      nationalities = data.$1;
      cities = data.$2;
      final response =
          NationalitiesAndCitiesModel(nationalities: data.$1, cities: data.$2);
      await DropdownStorageHelper.saveDropdownsData(response);
      return ApiResult.success(response);
    }, failure: (error) {
      final handledError = ErrorHandler.handle(error);
      print('❌ Error fetching data in repository: ${handledError.message}');
      return ApiResult.failure(handledError);
    });
  }

  Future<ApiResult<List<AreaModel>>> getAreasByCity(
      PersonType type, String cityName) async {
    print('🔄 جلب المناطق لمدينة: $cityName');
    try {
      final result = await personRepository.getAreasByCity(type, cityName);
      return result.when(
        success: (areas) {
          print('✅ تم تحميل ${areas.length} منطقة');
          return ApiResult.success(
            areas.map((area) => AreaModel.fromJson(area)).toList(),
          );
        },
        failure: (error) => ApiResult.failure(error),
      );
    } catch (e) {
      print('❌ خطأ في الـ Repository: $e');
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }

  /* Future<ApiResult<List<AreaModel>>> loadAreasByCityId(PersonType type, String cityName) async {
    print('Loading areas for city: $cityName');
    final result = await personRepository.getAreasByCity(type, cityName);
    print('Result of loading areas: $result');
    return result.when(

      success: (data) {
        areas = data;
        print('success areas: $areas');
        return ApiResult.success(data);

      },
      failure: (error) {
  print('❌ Error fetching data in repository: ${error.runtimeType} - ${error.message}');
  return ApiResult.failure(error);
}


    );
  }
*/
}
