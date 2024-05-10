import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/widgets/webview/WebView.dart';

import '../api/Api.dart';
import '../entity/navigation_entity.dart';
import '../util/ToastUtils.dart';


class NavigationPage extends StatefulWidget{
  const NavigationPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _NavigationPageState();
  }
}

class _NavigationPageState extends State<NavigationPage>{
  List<NavigationData> _datas = []; //一级分类集合
  List<NavigationDataArticles> articles = []; //二级分类集合
  int selectpPosition = 0; //选择了的一级分类下标
  ///控制正在加载的显示
  bool _isHide = true;

  @override
  void initState() {
    super.initState();
    getNavigationData();
  }

  //文章列表数据
  Future getNavigationData() async{
    print("NavigationPage getNavigationData");
    Api.getNavigationData((List<NavigationData> navigationList){
      print("NavigationPage getNavigationData=$navigationList");
      //更新UI
      //to ensure the object is still in the tree
     // if(mounted){
        setState(() {
          _datas = navigationList;
          selectpPosition = 0;
          _isHide = false;
        });
      //}

    }, (error) {
      ToastUtils.showToast(error.errorMsg!);
    }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        //加载提示
        Offstage(
          offstage: !_isHide,//是否显示
          child:  Center(
          // 圆形进度条直径指定为100
           child:SizedBox(
              height: 40,
              width: 40,
              child: CircularProgressIndicator(
                backgroundColor: Colors.grey[200],
                valueColor: const AlwaysStoppedAnimation(Colors.green),
                strokeWidth: 5,
              ),
          )
         ),
        ),
        Offstage(
          offstage: _isHide,
          ///SwipeRefresh 下拉刷新组件
          child:   Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  color: Colors.white,
                  child: ListView.builder(
                    itemCount: _datas.length,
                    itemBuilder: (BuildContext context, int position) {
                      return getLeft(position);
                    },
                  ),
                ),
              ),
              Expanded(
                  flex: 5,
                  child: ListView(
                    children: <Widget>[
                      Container(
                        //height: double.infinity,
                        alignment: Alignment.topLeft,
                        padding: const EdgeInsets.all(10),
                        color: Colors.white,
                        child: getRight(selectpPosition), //传入一级分类下标
                      ),
                    ],
                  )),
            ],
          )
        )
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();

  }

  Widget getLeft(int position) {
    Color textColor = Theme.of(context).highlightColor; //字体颜色
    return GestureDetector(
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        //Container下的color属性会与decoration下的border属性冲突，所以要用decoration下的color属性
        decoration: BoxDecoration(
          color: selectpPosition == position ? Colors.grey : Colors.white,
          border: Border(
            left: BorderSide(
                width: 5,
                color:
                selectpPosition == position ? Colors.green : Colors.white),
          ),
        ),
        child: Text(
          _datas[position].name,
          style: TextStyle(
            color: selectpPosition == position ?  Colors.green : Colors.grey,
            fontWeight: selectpPosition == position ? FontWeight.w600 : FontWeight.w400,
            fontSize: 16,
          ),
        ),
      ),
      onTap: () {
        setState(() {
          selectpPosition = position; //记录选中的下标
          textColor = Colors.grey;
        });
      },
    );
  }

  Widget getRight(int selectpPosition) {
    _updateArticles(selectpPosition);
    return Wrap(
      spacing: 10.0, //两个widget之间横向的间隔
      direction: Axis.horizontal, //方向
      alignment: WrapAlignment.start, //内容排序方式
      children:
      List.generate(articles.length, (int index) {
        return ActionChip(
          //标签文字
          label: Text(
            articles[index].title,
            style: const TextStyle(fontSize: 16, color: Colors.black),
          ),
          //点击事件
          onPressed: () {
            Navigator.pushNamed((context), "webview_page",
                arguments: jsonEncode({
                  "url": articles[index].link,
                  "title": articles[index].title
                }));
          },
          elevation: 2,
          backgroundColor: Colors.grey.shade200,
        );
      }),

    );
  }

  void _updateArticles(int selectpPosition) {
    setState(() {
      if(_datas.isNotEmpty){
        articles = _datas[selectpPosition].articles;
      }
    });
  }
}