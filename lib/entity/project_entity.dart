import 'package:flutter_wanandroid/generated/json/base/json_field.dart';
import 'package:flutter_wanandroid/generated/json/project_entity.g.dart';
import 'dart:convert';
export 'package:flutter_wanandroid/generated/json/project_entity.g.dart';

@JsonSerializable()
class ProjectEntity {
	late List<dynamic> articleList = [];
	late String author = '';
	late List<dynamic> children = [];
	late int courseId = 0;
	late String cover = '';
	late String desc = '';
	late int id = 0;
	late String lisense = '';
	late String lisenseLink = '';
	late String name = '';
	late int order = 0;
	late int parentChapterId = 0;
	late int type = 0;
	late bool userControlSetTop = false;
	late int visible = 0;

	ProjectEntity();

	factory ProjectEntity.fromJson(Map<String, dynamic> json) => $ProjectEntityFromJson(json);

	Map<String, dynamic> toJson() => $ProjectEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}