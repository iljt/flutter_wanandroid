import 'package:flutter_wanandroid/generated/json/base/json_field.dart';
import 'package:flutter_wanandroid/generated/json/collect_article_list_entity.g.dart';
import 'dart:convert';
export 'package:flutter_wanandroid/generated/json/collect_article_list_entity.g.dart';

@JsonSerializable()
class CollectArticleListEntity {
	late CollectArticleListData data;

	CollectArticleListEntity();

	factory CollectArticleListEntity.fromJson(Map<String, dynamic> json) => $CollectArticleListEntityFromJson(json);

	Map<String, dynamic> toJson() => $CollectArticleListEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class CollectArticleListData {
	late int curPage = 0;
	late List<CollectArticleListDataDatas> datas = [];
	late int offset = 0;
	late bool over = false;
	late int pageCount = 0;
	late int size = 0;
	late int total = 0;

	CollectArticleListData();

	factory CollectArticleListData.fromJson(Map<String, dynamic> json) => $CollectArticleListDataFromJson(json);

	Map<String, dynamic> toJson() => $CollectArticleListDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class CollectArticleListDataDatas {
	late String author = '';
	late int chapterId = 0;
	late String chapterName = '';
	late int courseId = 0;
	late String desc = '';
	late String envelopePic = '';
	late int id = 0;
	late String link = '';
	late String niceDate = '';
	late String origin = '';
	late int originId = 0;
	late int publishTime = 0;
	late String title = '';
	late int userId = 0;
	late int visible = 0;
	late int zan = 0;

	CollectArticleListDataDatas();

	factory CollectArticleListDataDatas.fromJson(Map<String, dynamic> json) => $CollectArticleListDataDatasFromJson(json);

	Map<String, dynamic> toJson() => $CollectArticleListDataDatasToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}