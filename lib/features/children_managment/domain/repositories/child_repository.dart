import 'package:new_project/Core/networking/api_result.dart';
import 'package:new_project/features/children_managment/data/model/CommonDropdownsChidModel.dart';
import 'package:new_project/features/children_managment/data/model/child_edit_details_model.dart';
import 'package:new_project/features/children_managment/data/model/child_list_response_model.dart';
import 'package:new_project/features/children_managment/data/model/child_model.dart';
import 'package:new_project/features/personal_management/data/models/person_model.dart';
import 'package:new_project/features/personal_management/data/models/personalTyp.dart';

abstract class ChildRepository {
  Future<ApiResult<void>> addChild(ChildModel childData);
  Future<ApiResult<void>> updateChild(
      String id, Map<String, dynamic> childData);
  Future<ApiResult<PersonModel?>> searchParentById(PersonType type, String id);
  Future<ApiResult<CommonDropdownsChidModel>>
      getNationalitiesAndCitiesandCases();

  Future<ApiResult<ChildListResponseModel>> getChildren();

  Future<ApiResult<ChildEditDetailsModel>> getChildDetailsById(String childId);
}
