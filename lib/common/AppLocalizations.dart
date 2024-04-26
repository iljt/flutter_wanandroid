//Locale资源类
import 'package:flutter/cupertino.dart';

///UI中如何支持多语言我们需要实现两个类：一个Delegate类一个Localizations类
/*但是这种方式还有一个严重的不足就是我们需要在DemoLocalizations类中获取title时手动的判断当前语言Locale，然后返回合适的文本。
试想一下，当我们要支持的语言不是两种而是8种甚至20几种时，如果为每个文本属性都要分别去判断到底是哪种Locale从而获取相应语言的文本将会是一件非常复杂的事。
还有，通常情况下翻译人员并不是开发人员，能不能像i18n或l10n标准那样可以将翻译单独保存为一个arb文件交由翻译人员去翻译，翻译好之后开发人员再通过工具将arb文件转为代码。
答案是肯定的！我们将通过Dart intl包来实现这些。*/
class AppLocalizations {
  AppLocalizations(this.isZh);
  //是否为中文
  bool isZh = false;

  //为了使用方便，我们定义一个静态方法
  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  ///AppLocalizations中会根据当前的语言来返回不同的文本，如title，我们可以将所有需要支持多语言的文本都在此类中定义。
  ///AppLocalizations的实例将会在Delegate类的load方法中创建
  //Locale相关值
  String get title {
    return isZh ? "玩安卓" : "wanAndroid";
  }

  String get language {
    return isZh ? "语言" : "Language";
  }

  String get auto {
    return isZh ? "跟随系统" : "Auto";
  }

  String get theme {
    return isZh ? "主题" : "Theme";
  }

}