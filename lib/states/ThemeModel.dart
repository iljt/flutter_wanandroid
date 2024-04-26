import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../common/Global.dart';
import 'ProfileChangeNotifier.dart';

///主题状态在用户更换APP主题时更新、通知其依赖项
class ThemeModel extends ProfileChangeNotifier {
  // 获取当前主题，如果为设置主题，则默认使用蓝色主题
  MaterialColor get theme => Global.themes
      .firstWhere((element) => element.value == profile.theme,
      orElse: () => Colors.blue);

  // 主题改变后，通知其依赖项，新主题会立即生效
  set theme(MaterialColor color) {
    if (color != theme) {
      profile.theme = color[500]!.value;
      notifyListeners();
    }
  }
}