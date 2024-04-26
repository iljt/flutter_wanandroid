import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/entity/user_info_entity.dart';
import 'package:flutter_wanandroid/util/ToastUtils.dart';

import '../api/Api.dart';

class RegisterRoute extends StatefulWidget{
  const RegisterRoute({super.key});

  @override
  State<StatefulWidget> createState() {
    return RegisterState();
  }
}

class RegisterState extends State<RegisterRoute>{
  final TextEditingController _userNameController = TextEditingController();
  String account = "";
  String password = "";
  String rePassword = "";

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
          title: const Text("注册"),
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
                    },
                    //maxLength: 12,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 12, 10, 10),
                  child: TextField(
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(5.0),
                      hintText: "请再次输入密码",
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
                      rePassword = input;
                    },
                    //maxLength: 12,
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
                          backgroundColor: MaterialStateProperty.all(
                              Colors.grey),
                          //边框
                          side: MaterialStateProperty.all(
                            const BorderSide(
                                color: Colors.grey,
                                width: 0.5),
                          ),
                        ),
                      child: const Text(
                         "注册",
                         style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        register(context);
                      },
                    ),
                  ),
                ),
              ],
        )
     )
    );
  }

  void register(BuildContext context) {
    if(account.isEmpty) {
      ToastUtils.showToast("请输入账号");
    }else if (password.isEmpty) {
      ToastUtils.showToast("请输入密码");
    }else if (rePassword.isEmpty) {
      ToastUtils.showToast("请再次输入密码");
    }else if (password != rePassword) {
      ToastUtils.showToast("两次输入的密码不一致");
    } else {
      userRegister(account,password);
    }
 }

 Future userRegister(String account,String password) async{
    print("RegisterRoute register");
    Api.userRegister(account, password,(UserInfoEntity data){
      print("userRegister username= ${data.username}");
     //注册成功，返回登录
      ToastUtils.showToast("注册成功！请登录");
      Navigator.of(context).pop(data.username);
    }, (error) {
      ToastUtils.showToast(error.errorMsg!);
    });
  }

}
