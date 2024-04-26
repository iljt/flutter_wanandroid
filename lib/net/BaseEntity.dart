import 'EntityFactory.dart';

/// 网络请求基类
class BaseEntity<T>{
  T? data;
  int? errorCode;
  String? errorMsg;

  BaseEntity({this.data,this.errorCode,this.errorMsg});

  factory BaseEntity.fromJson(json){
    return BaseEntity(data:EntityFactory.generateOBJ(json["data"]),errorCode:json["errorCode"],errorMsg:json["errorMsg"]);
  }
}