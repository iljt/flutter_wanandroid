import 'package:flutter_wanandroid/generated/json/base/json_convert_content.dart';
import 'package:flutter_wanandroid/entity/Profile.dart';

Profile $ProfileFromJson(Map<String, dynamic> json) {
  final Profile profile = Profile();
  final String? user = jsonConvert.convert<String>(json['user?']);
  if (user != null) {
    profile.user = user;
  }
  final String? token = jsonConvert.convert<String>(json['token?']);
  if (token != null) {
    profile.token = token;
  }
  final int? theme = jsonConvert.convert<int>(json['theme']);
  if (theme != null) {
    profile.theme = theme;
  }
  final String? lastlogin = jsonConvert.convert<String>(json['lastLogin?']);
  if (lastlogin != null) {
    profile.lastlogin = lastlogin;
  }
  final String? locale = jsonConvert.convert<String>(json['locale?']);
  if (locale != null) {
    profile.locale = locale;
  }
  return profile;
}

Map<String, dynamic> $ProfileToJson(Profile entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['user?'] = entity.user;
  data['token?'] = entity.token;
  data['theme'] = entity.theme;
  data['lastLogin?'] = entity.lastlogin;
  data['locale?'] = entity.locale;
  return data;
}

extension ProfileExtension on Profile {
  Profile copyWith({
    String? user,
    String? token,
    int? theme,
    String? lastlogin,
    String? locale,
  }) {
    return Profile()
      ..user = user ?? this.user
      ..token = token ?? this.token
      ..theme = theme ?? this.theme
      ..lastlogin = lastlogin ?? this.lastlogin
      ..locale = locale ?? this.locale;
  }
}