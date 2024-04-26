import 'EntityFactory.dart';

class BaseListEntity<T> {
  List<T>? data;
  int? errorCode;
  String? errorMsg;


  BaseListEntity({this.data,this.errorCode, this.errorMsg});

  factory BaseListEntity.fromJson(json) {
    List<T> mList= [];
    if (json['data'] != null) {
      //遍历data并转换为我们传进来的类型
      (json['data'] as List).forEach((v) {
        mList.add(EntityFactory.generateOBJ<T>(v) as T);
      });
    }
    return BaseListEntity(
      data: mList,
      errorCode: json["errorCode"],
      errorMsg: json["errorMsg"],
    );
  }
}
