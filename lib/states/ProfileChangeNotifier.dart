import 'package:flutter/cupertino.dart';

import '../common/Global.dart';
import '../entity/Profile.dart';

///需要共享的状态有登录用户信息、APP主题信息、APP语言信息。由于这些信息改变后都要立即通知其他依赖的该信息的Widget更新，所以我们应该使用ChangeNotifierProvider，
///另外，这些信息改变后都是需要更新Profile信息并进行持久化的。综上所述，我们可以定义一个ProfileChangeNotifier基类，然后让需要共享的Model继承自该类即可
class ProfileChangeNotifier extends ChangeNotifier {
  Profile get profile => Global.profile;

  @override
  void notifyListeners() {
    Global.saveProfile(); //保存Profile变更
    super.notifyListeners(); //通知依赖的Widget更新
  }
}