import 'package:flutter_wanandroid/generated/json/base/json_field.dart';
import 'package:flutter_wanandroid/generated/json/banner_entity.g.dart';
import 'dart:convert';
export 'package:flutter_wanandroid/generated/json/banner_entity.g.dart';

@JsonSerializable()
class BannerEntity {
	late String desc = '';
	late int id = 0;
	late String imagePath = '';
	late int isVisible = 0;
	late int order = 0;
	late String title = '';
	late int type = 0;
	late String url = '';

	BannerEntity();

	factory BannerEntity.fromJson(Map<String, dynamic> json) => $BannerEntityFromJson(json);

	Map<String, dynamic> toJson() => $BannerEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}