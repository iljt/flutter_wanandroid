import 'package:flutter/material.dart';

import '../api/Api.dart';
import '../entity/user_info_entity.dart';
import '../util/ToastUtils.dart';
import '../util/SharedPreferencesUtils.dart';

class LoginRoute extends StatefulWidget{
  const LoginRoute({super.key});

  @override
  State<StatefulWidget> createState() {
    return LoginState();
  }
}

class LoginState extends State<LoginRoute>{
  final TextEditingController _userNameController = TextEditingController();
  String account = "";
  String password = "";
  bool isBtnEnable =false;

  @override
  void initState() {
    super.initState();
    _userNameController.addListener(() {
      //监听输入改变
      print(_userNameController.text);
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("登录"),
        ),
        body:
       Container(
          margin: const EdgeInsets.only(top: 120),
          padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: TextField(
                    controller: _userNameController,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(5.0),
                      hintText: "请输入账号",
                      prefixIcon: const Icon(Icons.account_circle),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide.none),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    autofocus: true,
                    textInputAction: TextInputAction.done,
                    onChanged: (String input) {
                      // 输入文字改变监听
                      account = input;
                      if(account==""){
                        setState(() {
                          isBtnEnable =false;
                        });
                      }
                      if(account!="" && password!=""){
                        setState(() {
                          isBtnEnable =true;
                        });
                      }
                    },
                    //maxLength: 12,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 12, 10, 10),
                  child: TextField(
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(5.0),
                      hintText: "请输入密码",
                      prefixIcon: const Icon(Icons.enhanced_encryption),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide.none),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    autofocus: false,
                    obscureText: true,
                    textInputAction: TextInputAction.done,
                    onChanged: (String input) {
                      // 输入文字改变监听
                       password = input;
                       if(password==""){
                         setState(() {
                           isBtnEnable =false;
                         });
                       }
                       if(account!="" && password!=""){
                         setState(() {
                           isBtnEnable =true;
                         });
                       }
                    },
                    //maxLength: 12,
                  ),
                ),
                Padding(
                  padding:  const EdgeInsets.fromLTRB(0, 10, 20, 0),
                  child: Container(
                    alignment: Alignment.centerRight,
                    child:  GestureDetector(
                      onTap: () async {
                        var result = await Navigator.of(context).pushNamed("register_page",arguments: "注册");
                        print("注册成功后返回值: ${result.toString()}");
                        if(result!=null){
                          setState(() {
                            _userNameController.text=result.toString();
                          });
                        }
                      },
                      child: Text(
                        "去注册",
                        style: _TextStyles(),
                      ),
                    )
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 30, 20, 10),
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    child: TextButton(
                        style: ButtonStyle(
                          //字体  这里设置颜色没用
                        //  textStyle: MaterialStateProperty.all(const TextStyle(fontSize: 36,fontWeight: FontWeight.w700)),
                          //字体颜色
                          foregroundColor: MaterialStateProperty.all(Colors.white),
                          //圆角弧度
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          //背景颜色
                          backgroundColor: isBtnEnable ? MaterialStateProperty.all(Colors.green):MaterialStateProperty.all(Colors.grey),
                          //边框
                       /*   side: MaterialStateProperty.all(
                            const BorderSide(
                                color: Colors.grey,
                                width: 0.5),
                          ),*/
                        ),
                      onPressed: isBtnEnable ? (){
                          login(context);
                      } : null,
                      child: const Text(
                         "登录",
                         style: TextStyle(color: Colors.white),
                      ),


                    ),
                  ),
                ),
              ],
        )
     )
    );
  }

  void login(BuildContext context) {
    if(account.isEmpty) {
      ToastUtils.showToast("请输入账号");
    }else if (password.isEmpty) {
      ToastUtils.showToast("请输入密码");
    }else{
      userLogin(context,account,password);
    }
  }

}

Future userLogin(BuildContext context,String account,String password) async{
  print("LoginRoute userLogin");
  Api.userLogin(account, password,(UserInfoEntity data){
    print("userRegister username= ${data.username}");
    //登录成功
    ToastUtils.showToast("登录成功");
    UserInfoEntity userInfoEntity = data;
    userInfoEntity.password = password;
    //缓存用户信息
    SharedPreferencesUtils.saveUserInfo(userInfoEntity);
    Navigator.of(context).pop(userInfoEntity);
  }, (error) {
    ToastUtils.showToast(error.errorMsg!);
  });
}

TextStyle _TextStyles() {
  return  const TextStyle(
    //颜色
      color: Colors.green,
      //字号 默认14
      fontSize: 15,
      //粗细
      fontWeight: FontWeight.w400,
      //斜体
      fontStyle: FontStyle.italic,
      //underline：下划线，overline：上划线，lineThrough：删除线
      decoration: TextDecoration.underline,
      decorationColor: Colors.green,
      //solid：实线，double：双线，dotted：点虚线，dashed：横虚线，wavy：波浪线
      decorationStyle: TextDecorationStyle.solid);
}

