import 'package:flutter_wanandroid/generated/json/base/json_field.dart';
import 'package:flutter_wanandroid/generated/json/project_list_entity.g.dart';
import 'dart:convert';
export 'package:flutter_wanandroid/generated/json/project_list_entity.g.dart';

@JsonSerializable()
class ProjectListEntity {
	late int curPage = 0;
	late List<ProjectListDatas> datas = [];
	late int offset = 0;
	late bool over = false;
	late int pageCount = 0;
	late int size = 0;
	late int total = 0;

	ProjectListEntity();

	factory ProjectListEntity.fromJson(Map<String, dynamic> json) => $ProjectListEntityFromJson(json);

	Map<String, dynamic> toJson() => $ProjectListEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class ProjectListDatas {
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
	late List<ProjectListDatasTags> tags = [];
	late String title = '';
	late int type = 0;
	late int userId = 0;
	late int visible = 0;
	late int zan = 0;

	ProjectListDatas();

	factory ProjectListDatas.fromJson(Map<String, dynamic> json) => $ProjectListDatasFromJson(json);

	Map<String, dynamic> toJson() => $ProjectListDatasToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class ProjectListDatasTags {
	late String name = '';
	late String url = '';

	ProjectListDatasTags();

	factory ProjectListDatasTags.fromJson(Map<String, dynamic> json) => $ProjectListDatasTagsFromJson(json);

	Map<String, dynamic> toJson() => $ProjectListDatasTagsToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}