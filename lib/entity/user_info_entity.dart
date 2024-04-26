import 'package:flutter_wanandroid/generated/json/base/json_field.dart';
import 'package:flutter_wanandroid/generated/json/user_info_entity.g.dart';
import 'dart:convert';
export 'package:flutter_wanandroid/generated/json/user_info_entity.g.dart';

@JsonSerializable()
class UserInfoEntity {
	late bool admin = false;
	late List<dynamic> chapterTops = [];
	late int coinCount = 0;
	late List<int> collectIds = [];
	late String email = '';
	late String icon = '';
	late int id = 0;
	late String nickname = '';
	late String password = '';
	late String publicName = '';
	late String token = '';
	late int type = 0;
	late String username = '';

	UserInfoEntity();

	factory UserInfoEntity.fromJson(Map<String, dynamic> json) => $UserInfoEntityFromJson(json);

	Map<String, dynamic> toJson() => $UserInfoEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}