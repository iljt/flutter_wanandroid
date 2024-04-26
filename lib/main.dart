import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_wanandroid/page/MinePage.dart';
import 'package:flutter_wanandroid/page/NavigationPage.dart';
import 'package:flutter_wanandroid/page/ProjectPage.dart';
import 'package:flutter_wanandroid/routes/AboutRoute.dart';
import 'package:flutter_wanandroid/routes/CollectRoute.dart';
import 'package:flutter_wanandroid/routes/LanguageRoute.dart';
import 'package:flutter_wanandroid/routes/LoginRoute.dart';
import 'package:flutter_wanandroid/routes/RegisterRoute.dart';
import 'package:flutter_wanandroid/routes/SettingRoute.dart';
import 'package:flutter_wanandroid/routes/ThemeChangeRoute.dart';
import 'package:flutter_wanandroid/states/LocaleModel.dart';
import 'package:flutter_wanandroid/states/ThemeModel.dart';
import 'package:flutter_wanandroid/page/HomePage.dart';
import 'package:flutter_wanandroid/widgets/KeepAliveWrapper.dart';
import 'package:flutter_wanandroid/widgets/webview/WebView.dart';
import 'package:provider/provider.dart';
import 'common/AppLocalizations.dart';
import 'common/AppLocalizationsDelegate.dart';
import 'common/Global.dart';

void main() {
  Global.init().then((e){
    print("init e=$e");
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ///状态管理Provider
    ///根widget是MultiProvider，它将主题、用户、语言三种状态绑定到了应用的根上，如此一来，任何路由中都可以通过Provider.of()来获取这些状态，也就是说这三种状态是全局共享的
    return MultiProvider(
      ///语言和主题都是可以设置的，而两者都是通过ChangeNotifierProvider来实现的：我们在main函数中使用了Consumer2，依赖了ThemeModel和LocaleModel，
      ///因此，当我们在语言和主题设置页更该当前的配置后，Consumer2的builder都会重新执行，构建一个新的MaterialApp，所以修改会立即生效
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeModel()),
      //  ChangeNotifierProvider(create: (_) => UserModel()),
        ChangeNotifierProvider(create: (_) => LocaleModel()),
      ],
      child: Consumer2<ThemeModel, LocaleModel>(
        builder: (BuildContext context, themeModel, localeModel, child) {
          print("Consumer2 builder");
          ///构建MaterialApp时，我们配置了APP支持的语言列表，以及监听了系统语言改变事件；另外MaterialApp消费（依赖）了ThemeModel和LocaleModel，所以当APP主题或语言改变时MaterialApp会重新构建
          return MaterialApp(
            ///去除右上角Debug标签
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: themeModel.theme,
            ),
            onGenerateTitle: (context){
              return AppLocalizations.of(context)!.title;
            },
            home: const MyHomePage(title: "XX",),
            locale: localeModel.getLocale(),
            //我们只支持美国英语和中文简体
            supportedLocales: const [
              Locale('en', 'US'), // 美国英语
              Locale('zh', 'CN'), // 中文简体
              //其他Locales
            ],
             localizationsDelegates: const [
                // 本地化的代理类
                ///Material 组件库提供的本地化的字符串和其他值，它可以使Material 组件支持多语言
                GlobalMaterialLocalizations.delegate,
                ///定义组件默认的文本方向，从左到右或从右到左，这是因为有些语言的阅读习惯并不是从左到右，比如如阿拉伯语就是从右向左的
                GlobalWidgetsLocalizations.delegate,
                ///添加多语言支持 需要先注册AppLocalizationsDelegate类，然后再通过AppLocalizations.of(context)来动态获取当前Locale文本
                /// 注册我们的Delegate
                ApplizationsDelegate(),
              ],
            localeResolutionCallback: (_locale, supportedLocales) {
              if (localeModel.getLocale() != null) {
                //如果已经选定语言，则不跟随系统
                return localeModel.getLocale();
              } else {
                //跟随系统
                Locale locale;
                if (supportedLocales.contains(_locale)) {
                  locale= _locale!;
                } else {
                  //如果系统语言不是中文简体或美国英语，则默认使用美国英语
                  locale= const Locale('en', 'US');
                }
                return locale;
              }
            },
            // 注册路由表
            routes: <String, WidgetBuilder>{
             //  "login": (context) => LoginRoute(),
               "theme_page": (context) => const ThemeChangeRoute(),
               "language_page": (context) => const LanguageRoute(),
               "webview_page": (context) => const WebView(),
               "login_page": (context) => const LoginRoute(),
               "register_page": (context) => const RegisterRoute(),
               "about_page": (context) => const AboutRoute(),
               "collect_page": (context) => const CollectRoute(),
               "setting_page": (context) => const SettingRoute(),
            },
          );
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  String title = "首页";
  var appBarTitles = ['首页', '导航', '项目', '我的'];

  final _pageController = PageController(initialPage: 0);

  var pages = <Widget>[
    //KeepAliveWrapper缓存没效果？？?
    const KeepAliveWrapper(child: HomePage()),
    const KeepAliveWrapper(child: NavigationPage()),
    const KeepAliveWrapper(child: ProjectPage()),
    const KeepAliveWrapper(child: MinePage()),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  void _pageChange(int index) {
    setState(() {
      _selectedIndex = index;
      //根据下标修改标题
      title = appBarTitles[index];
    });
  }

  /*
   * 根据image路径获取图片
   * 这个图片的路径需要在 pubspec.yaml 中去定义
   */
  AssetImage getTabImage(path) {
    return AssetImage(path);
  }

  /*
   * 根据索引获得对应的normal或是press的icon
   */
  Image getTabIcon(int curIndex) {
    if (curIndex == _selectedIndex) {
      return tabImages[curIndex][1];
    }
    return tabImages[curIndex][0];
  }
  /*
   * 获取bottomTab的颜色和文字
   */
  String getTabTitle(int curIndex) {
    return appBarTitles[curIndex];
   /* if (curIndex == _selectedIndex) {
      return Text(],
          style: const TextStyle(color: Color(0xff63ca6c)));
    } else {
      return Text(appBarTitles[curIndex],
          style: const TextStyle(color: Color(0xff888888)));
    }*/
  }

  String getTabColor(int curIndex) {
    return appBarTitles[curIndex];
    /* if (curIndex == _selectedIndex) {
      return Text(],
          style: const TextStyle(color: Color(0xff63ca6c)));
    } else {
      return Text(appBarTitles[curIndex],
          style: const TextStyle(color: Color(0xff888888)));
    }*/
  }

  /*
      bottom的按压图片
     */
  var  tabImages = [
    [
      Image.asset('assets/images/home_normal.png', width: 25.0, height: 25.0),
      Image.asset('assets/images/home_selected.png', width: 25.0, height: 25.0),
     // getTabImage('assets/images/ic_home_normal.png'),
     // getTabImage('assets/images/ic_home_select.png'),
    ],
    [
      Image.asset('assets/images/navigation_normal.png', width: 25.0, height: 25.0),
      Image.asset('assets/images/navigation_selected.png', width: 25.0, height: 25.0),
    ],
    [
      Image.asset('assets/images/project_normal.png', width: 25.0, height: 25.0),
      Image.asset('assets/images/project_selected.png', width: 25.0, height: 25.0),
    ],
    [
      Image.asset('assets/images/my_normal.png', width: 25.0, height: 25.0),
      Image.asset('assets/images/my_selected.png', width: 25.0, height: 25.0),
    ]
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(AppLocalizations.of(context)!.title),
      ),
      body: PageView.builder(
      onPageChanged: _pageChange,
      controller: _pageController,
      itemCount: pages.length,
      physics: const NeverScrollableScrollPhysics(),//禁止滚动，不响应滚动事件
      itemBuilder: (BuildContext context, int index) {
        return pages.elementAt(_selectedIndex);
      },
     ),
      bottomNavigationBar: BottomNavigationBar( // 底部导航
        items: <BottomNavigationBarItem>[
         BottomNavigationBarItem(icon: getTabIcon(0), label: getTabTitle(0)),
         BottomNavigationBarItem(icon: getTabIcon(1), label: getTabTitle(1)),
         BottomNavigationBarItem(icon: getTabIcon(2), label: getTabTitle(2)),
         BottomNavigationBarItem(icon: getTabIcon(3), label: getTabTitle(3)),
        //  BottomNavigationBarItem(icon: Icon(Icons.home), label: getTabTitle(0)),
         // BottomNavigationBarItem(icon: Icon(Icons.filter_list), label: '导航'),
        //  BottomNavigationBarItem(icon: Icon(Icons.low_priority), label: '项目'),
        //  BottomNavigationBarItem(icon: Icon(Icons.apps), label: '我的'),
        ],
        currentIndex: _selectedIndex,
        fixedColor: Colors.green,
        //显示模式
        type: BottomNavigationBarType.fixed,
        onTap: _onItemTapped,
      ),
    );
  }
}
