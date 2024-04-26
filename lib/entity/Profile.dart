import 'package:flutter_wanandroid/generated/json/base/json_field.dart';
import 'package:flutter_wanandroid/generated/json/profile.g.dart';
import 'dart:convert';
export 'package:flutter_wanandroid/generated/json/profile.g.dart';
/*{
"user?":"$user", //账号信息，结构见"user.json"
"token?":"", // 登录用户的token或密码
"theme":0, //主题索引
"lastLogin?":"", //最近一次的注销登录的用户名
"locale?":"" // APP语言信息
}*/
@JsonSerializable()
class Profile {
	@JSONField(name: "user?")
	late String user = '';
	@JSONField(name: "token?")
	late String token = '';
	late int theme = 0;
	@JSONField(name: "lastLogin?")
	late String lastlogin = '';
	@JSONField(name: "locale?")
	late String locale = 'zh_CN';

	Profile();

	factory Profile.fromJson(Map<String, dynamic> json) => $ProfileFromJson(json);

	Map<String, dynamic> toJson() => $ProfileToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}