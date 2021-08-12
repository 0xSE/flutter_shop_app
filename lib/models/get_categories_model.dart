class CategoriesModel {
  bool? status;
  String? message;
  DataModelCategories? data;

  CategoriesModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
    data = DataModelCategories.fromJson(json["data"]);
  }
}

class DataModelCategories {
  int? current_page;
  List<DataModelCategoriesData> data = [];

  DataModelCategories.fromJson(Map<String, dynamic> json) {
    current_page = json["current_page"];
    json['data'].forEach((element) {
      data.add(DataModelCategoriesData.fromJson(element));
    });
  }
}

class DataModelCategoriesData {
  int? id;
  String? name;
  String? image;

  DataModelCategoriesData.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    image = json["image"];
  }
}