import 'package:flutter_wanandroid/generated/json/base/json_field.dart';
import 'package:flutter_wanandroid/generated/json/navigation_entity.g.dart';
import 'dart:convert';
export 'package:flutter_wanandroid/generated/json/navigation_entity.g.dart';

@JsonSerializable()
class NavigationEntity {
	late List<NavigationData> data = [];

	NavigationEntity();

	factory NavigationEntity.fromJson(Map<String, dynamic> json) => $NavigationEntityFromJson(json);

	Map<String, dynamic> toJson() => $NavigationEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class NavigationData {
	late List<NavigationDataArticles> articles = [];
	late int cid = 0;
	late String name = '';

	NavigationData();

	factory NavigationData.fromJson(Map<String, dynamic> json) => $NavigationDataFromJson(json);

	Map<String, dynamic> toJson() => $NavigationDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class NavigationDataArticles {
	late bool adminAdd = false;
	late String apkLink = '';
	late int audit = 0;
	late String author = '';
	late bool canEdit = false;
	late int chapterId = 0;
	late String chapterName = '';
	late bool collect = false;
	late int courseId = 0;
	late String desc = '';
	late String descMd = '';
	late String envelopePic = '';
	late bool fresh = false;
	late String host = '';
	late int id = 0;
	late bool isAdminAdd = false;
	late String link = '';
	late String niceDate = '';
	late String niceShareDate = '';
	late String origin = '';
	late String prefix = '';
	late String projectLink = '';
	late int publishTime = 0;
	late int realSuperChapterId = 0;
	late int selfVisible = 0;
	late int shareDate = 0;
	late String shareUser = '';
	late int superChapterId = 0;
	late String superChapterName = '';
	late List<dynamic> tags = [];
	late String title = '';
	late int type = 0;
	late int userId = 0;
	late int visible = 0;
	late int zan = 0;

	NavigationDataArticles();

	factory NavigationDataArticles.fromJson(Map<String, dynamic> json) => $NavigationDataArticlesFromJson(json);

	Map<String, dynamic> toJson() => $NavigationDataArticlesToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}