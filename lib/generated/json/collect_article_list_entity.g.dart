import 'package:flutter_wanandroid/generated/json/base/json_convert_content.dart';
import 'package:flutter_wanandroid/entity/collect_article_list_entity.dart';

CollectArticleListEntity $CollectArticleListEntityFromJson(
    Map<String, dynamic> json) {
  final CollectArticleListEntity collectArticleListEntity = CollectArticleListEntity();
  final CollectArticleListData? data = jsonConvert.convert<
      CollectArticleListData>(json['data']);
  if (data != null) {
    collectArticleListEntity.data = data;
  }
  return collectArticleListEntity;
}

Map<String, dynamic> $CollectArticleListEntityToJson(
    CollectArticleListEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['data'] = entity.data.toJson();
  return data;
}

extension CollectArticleListEntityExtension on CollectArticleListEntity {
  CollectArticleListEntity copyWith({
    CollectArticleListData? data,
  }) {
    return CollectArticleListEntity()
      ..data = data ?? this.data;
  }
}

CollectArticleListData $CollectArticleListDataFromJson(
    Map<String, dynamic> json) {
  final CollectArticleListData collectArticleListData = CollectArticleListData();
  final int? curPage = jsonConvert.convert<int>(json['curPage']);
  if (curPage != null) {
    collectArticleListData.curPage = curPage;
  }
  final List<CollectArticleListDataDatas>? datas = (json['datas'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<CollectArticleListDataDatas>(
          e) as CollectArticleListDataDatas).toList();
  if (datas != null) {
    collectArticleListData.datas = datas;
  }
  final int? offset = jsonConvert.convert<int>(json['offset']);
  if (offset != null) {
    collectArticleListData.offset = offset;
  }
  final bool? over = jsonConvert.convert<bool>(json['over']);
  if (over != null) {
    collectArticleListData.over = over;
  }
  final int? pageCount = jsonConvert.convert<int>(json['pageCount']);
  if (pageCount != null) {
    collectArticleListData.pageCount = pageCount;
  }
  final int? size = jsonConvert.convert<int>(json['size']);
  if (size != null) {
    collectArticleListData.size = size;
  }
  final int? total = jsonConvert.convert<int>(json['total']);
  if (total != null) {
    collectArticleListData.total = total;
  }
  return collectArticleListData;
}

Map<String, dynamic> $CollectArticleListDataToJson(
    CollectArticleListData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['curPage'] = entity.curPage;
  data['datas'] = entity.datas.map((v) => v.toJson()).toList();
  data['offset'] = entity.offset;
  data['over'] = entity.over;
  data['pageCount'] = entity.pageCount;
  data['size'] = entity.size;
  data['total'] = entity.total;
  return data;
}

extension CollectArticleListDataExtension on CollectArticleListData {
  CollectArticleListData copyWith({
    int? curPage,
    List<CollectArticleListDataDatas>? datas,
    int? offset,
    bool? over,
    int? pageCount,
    int? size,
    int? total,
  }) {
    return CollectArticleListData()
      ..curPage = curPage ?? this.curPage
      ..datas = datas ?? this.datas
      ..offset = offset ?? this.offset
      ..over = over ?? this.over
      ..pageCount = pageCount ?? this.pageCount
      ..size = size ?? this.size
      ..total = total ?? this.total;
  }
}

CollectArticleListDataDatas $CollectArticleListDataDatasFromJson(
    Map<String, dynamic> json) {
  final CollectArticleListDataDatas collectArticleListDataDatas = CollectArticleListDataDatas();
  final String? author = jsonConvert.convert<String>(json['author']);
  if (author != null) {
    collectArticleListDataDatas.author = author;
  }
  final int? chapterId = jsonConvert.convert<int>(json['chapterId']);
  if (chapterId != null) {
    collectArticleListDataDatas.chapterId = chapterId;
  }
  final String? chapterName = jsonConvert.convert<String>(json['chapterName']);
  if (chapterName != null) {
    collectArticleListDataDatas.chapterName = chapterName;
  }
  final int? courseId = jsonConvert.convert<int>(json['courseId']);
  if (courseId != null) {
    collectArticleListDataDatas.courseId = courseId;
  }
  final String? desc = jsonConvert.convert<String>(json['desc']);
  if (desc != null) {
    collectArticleListDataDatas.desc = desc;
  }
  final String? envelopePic = jsonConvert.convert<String>(json['envelopePic']);
  if (envelopePic != null) {
    collectArticleListDataDatas.envelopePic = envelopePic;
  }
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    collectArticleListDataDatas.id = id;
  }
  final String? link = jsonConvert.convert<String>(json['link']);
  if (link != null) {
    collectArticleListDataDatas.link = link;
  }
  final String? niceDate = jsonConvert.convert<String>(json['niceDate']);
  if (niceDate != null) {
    collectArticleListDataDatas.niceDate = niceDate;
  }
  final String? origin = jsonConvert.convert<String>(json['origin']);
  if (origin != null) {
    collectArticleListDataDatas.origin = origin;
  }
  final int? originId = jsonConvert.convert<int>(json['originId']);
  if (originId != null) {
    collectArticleListDataDatas.originId = originId;
  }
  final int? publishTime = jsonConvert.convert<int>(json['publishTime']);
  if (publishTime != null) {
    collectArticleListDataDatas.publishTime = publishTime;
  }
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    collectArticleListDataDatas.title = title;
  }
  final int? userId = jsonConvert.convert<int>(json['userId']);
  if (userId != null) {
    collectArticleListDataDatas.userId = userId;
  }
  final int? visible = jsonConvert.convert<int>(json['visible']);
  if (visible != null) {
    collectArticleListDataDatas.visible = visible;
  }
  final int? zan = jsonConvert.convert<int>(json['zan']);
  if (zan != null) {
    collectArticleListDataDatas.zan = zan;
  }
  return collectArticleListDataDatas;
}

Map<String, dynamic> $CollectArticleListDataDatasToJson(
    CollectArticleListDataDatas entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['author'] = entity.author;
  data['chapterId'] = entity.chapterId;
  data['chapterName'] = entity.chapterName;
  data['courseId'] = entity.courseId;
  data['desc'] = entity.desc;
  data['envelopePic'] = entity.envelopePic;
  data['id'] = entity.id;
  data['link'] = entity.link;
  data['niceDate'] = entity.niceDate;
  data['origin'] = entity.origin;
  data['originId'] = entity.originId;
  data['publishTime'] = entity.publishTime;
  data['title'] = entity.title;
  data['userId'] = entity.userId;
  data['visible'] = entity.visible;
  data['zan'] = entity.zan;
  return data;
}

extension CollectArticleListDataDatasExtension on CollectArticleListDataDatas {
  CollectArticleListDataDatas copyWith({
    String? author,
    int? chapterId,
    String? chapterName,
    int? courseId,
    String? desc,
    String? envelopePic,
    int? id,
    String? link,
    String? niceDate,
    String? origin,
    int? originId,
    int? publishTime,
    String? title,
    int? userId,
    int? visible,
    int? zan,
  }) {
    return CollectArticleListDataDatas()
      ..author = author ?? this.author
      ..chapterId = chapterId ?? this.chapterId
      ..chapterName = chapterName ?? this.chapterName
      ..courseId = courseId ?? this.courseId
      ..desc = desc ?? this.desc
      ..envelopePic = envelopePic ?? this.envelopePic
      ..id = id ?? this.id
      ..link = link ?? this.link
      ..niceDate = niceDate ?? this.niceDate
      ..origin = origin ?? this.origin
      ..originId = originId ?? this.originId
      ..publishTime = publishTime ?? this.publishTime
      ..title = title ?? this.title
      ..userId = userId ?? this.userId
      ..visible = visible ?? this.visible
      ..zan = zan ?? this.zan;
  }
}