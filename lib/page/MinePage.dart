import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/entity/user_info_entity.dart';
import 'package:flutter_wanandroid/util/SharedPreferencesUtils.dart';

import '../api/Api.dart';
import '../net/HttpManager.dart';
import '../util/ToastUtils.dart';


class MinePage extends StatefulWidget{
  const MinePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MinePageState();
  }
}

class _MinePageState extends State<MinePage>{
  UserInfoEntity? _userInfoEntity;

  @override
  void initState() {
    super.initState();
    SharedPreferencesUtils.getUserInfo().then((UserInfoEntity? userInfo) {
      setState(() {
        _userInfoEntity = userInfo;
      });
      //获取我的页面信息接口
    }).catchError((onError){
      _userInfoEntity = null;
    });

  }

  @override
  Widget build(BuildContext context) {
    String? iconUrl="";
    if(_userInfoEntity!=null && _userInfoEntity?.icon !=""){
      iconUrl= _userInfoEntity?.icon;
    }else{
      iconUrl= "https://img.zcool.cn/community/01a7f7590cd5a3a8012145509a8335.jpg@2o.jpg";
    }
    return Scaffold(
        body:
       SingleChildScrollView(
          child: Column(
             mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  //设置背景图片
                  /*decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/bg.png'),
                     image: NetworkImage(
                          "https://www.mtjsoft.cn/media/wanandroid/userbg.jpg"),
                      fit: BoxFit.cover,
                    ),
                  ),*/
                  color: Colors.white,
                  alignment: Alignment.center,
                  width: double.infinity,
                  height: 200,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                       Visibility(
                            visible: _userInfoEntity != null,
                            child:  ClipRRect( //圆角图片
                              borderRadius: BorderRadius.circular(50),
                              child: Image.network(
                                  iconUrl!,
                                  width: 75,
                                  height: 75
                              ),
                            )
                        ),
                      Visibility(
                        visible: _userInfoEntity == null,
                        child: ClipRRect( //圆角图片
                          borderRadius: BorderRadius.circular(50),
                          child: Image.asset(
                              'assets/images/default_head_icon.png',
                              width: 75,
                              height: 75
                          ),
                        )
                      ),

                      Visibility(
                        visible: _userInfoEntity != null,
                        child:  Column(
                          children: <Widget>[
                            Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: Text(_userInfoEntity != null ? "${_userInfoEntity?.nickname}" : "未登录",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      color: Colors.black, fontSize: 18),
                                )),
                          ],
                        ),
                      ),
                      Visibility(
                        visible: _userInfoEntity == null,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: GestureDetector(
                            onTap: () {
                              // 登录成功返回userInfoEntity
                              loginPage(context);
                            },
                            child: const Text(
                              "点我登录",
                              style: TextStyle(color: Colors.black, fontSize: 16),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // 收藏
                    if (_userInfoEntity == null) {
                      loginPage(context);
                    } else {
                      //收藏
                      Navigator.of(context).pushNamed("collect_page",arguments: "收藏");
                    }
                  },
                  child: Container(
                    margin: const EdgeInsets.only(top: 1),
                    color: Colors.grey[200],
                    padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
                    width: double.infinity,
                    child: const Row(
                      children: <Widget>[
                        Icon(
                          Icons.star_border,
                          size: 18,
                        ),
                        Text(
                          "收藏",
                        ),
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.grey,
                              size: 12,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    //关于我们
                    Navigator.of(context).pushNamed("about_page",arguments: "关于我们");
                  },
                  child: Container(
                    margin: const EdgeInsets.only(top: 1),
                    color: Colors.grey[200],
                    padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
                    width: double.infinity,
                    child: const Row(
                      children: <Widget>[
                        Icon(
                          Icons.assignment,
                          size: 18,
                        ),
                        Text(
                          "关于",
                        ),
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.grey,
                              size: 12,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    //设置
                    Navigator.of(context).pushNamed("setting_page",arguments: "设置");
                  },
                  child: Container(
                    margin: const EdgeInsets.only(top: 1),
                    color: Colors.grey[200],
                    padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
                    width: double.infinity,
                    child: const Row(
                      children: <Widget>[
                        Icon(
                          Icons.settings,
                          size: 18,
                        ),
                        Text(
                          "设置",
                        ),
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.grey,
                              size: 12,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Visibility(
                  visible: _userInfoEntity != null,
                  child: GestureDetector(
                      onTap: () {
                        // 退出登录
                        showLogoutDialog();
                      },
                      child: Container(
                        margin: const EdgeInsets.only(left:50,top: 100,right: 50),
                        color: Colors.grey[200],
                        padding: const EdgeInsets.fromLTRB(16, 15, 16, 15),
                        width: double.infinity,
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "退出登录",
                            ),

                          ],
                        ),
                      )),
                )
       ],
       ),
      )
    );
  }

  void loginPage(BuildContext context) {
       Navigator.of(context).pushNamed("login_page",arguments: "登录").then((value){
         if (value != null && value is UserInfoEntity) {
           setState(() {
             _userInfoEntity = value;
           });
        //登录成功,获取我的页面信息接口
       }
     });
  }

  void showLogoutDialog() {
    showDialog<void>(context: context,
        barrierDismissible: true, // user must tap button!
        builder: (BuildContext context){
          return AlertDialog(
            title: const Text('提示'),
            content: const SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('确认退出吗？'),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('取消', style: TextStyle(color: Colors.black)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text('确定'),
                onPressed: () {
                  //退出
                  Navigator.of(context).pop();
                  exitLogin();
                },
              ),
            ],
          );
    });

  }

  void exitLogin() {
    print("MinePage exitLogin");
    Api.userLoginOut((Object? data){
      print("MinePage exitLogin= $data");
      //登录成功
      ToastUtils.showToast("退出成功");
      setState(() {
        _userInfoEntity = null;
      });
      SharedPreferencesUtils.removeUserInfo();
      HttpManager.getInstance().cookieJar?.deleteAll();
    }, (error) {
      ToastUtils.showToast(error.errorMsg!);
    });
  }
}