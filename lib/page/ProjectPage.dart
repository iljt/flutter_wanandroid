import 'dart:convert';

import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/entity/project_list_entity.dart';
import '../api/Api.dart';
import '../entity/project_entity.dart';
import '../util/ToastUtils.dart';


class ProjectPage extends StatefulWidget{
  const ProjectPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ProjectPageState();
  }
}

class _ProjectPageState extends State<ProjectPage> with TickerProviderStateMixin{
  late TabController _tabController; //tab控制器
  int _currentIndex = 0; //选中下标
  List<ProjectEntity> _tabDatas = []; //tab集合
  List<ProjectListDatas> _listDatas =  []; //内容集合
  int curPage =1; //要注意page是从0还是1开始

  @override
  void initState() {
    super.initState();
    //初始化controller
    _tabController= TabController(vsync: this,length: 0);
    getTabData();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar:
          TabBar(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              indicatorPadding: const EdgeInsets.fromLTRB(-10, 0, -10, 0),// indicator左右各加长10
              //控制器
              controller: _tabController,
              //选中的颜色
              labelColor: Colors.green,
              //选中的样式
              labelStyle: const TextStyle(fontSize: 16),
              //未选中的颜色
              unselectedLabelColor: Colors.grey,
              //未选中的样式
              unselectedLabelStyle: const TextStyle(fontSize: 14),
              //下划线颜色
              indicatorColor: Colors.green,
              //是否可滑动
              isScrollable: true,
              //tab标签
              tabs: _tabDatas.map((ProjectEntity choice) {
                return Tab(
                  text: choice.name,
                );
              }).toList(),
              //点击事件
              onTap: (int i) {
                print(i);
              },
        ),
        body:  TabBarView(
          controller: _tabController,
          children: _tabDatas.map((ProjectEntity choice) {
            return EasyRefresh(
              header: const MaterialHeader(),
              footer: const MaterialFooter(),
              onRefresh: () async {
                await Future.delayed(const Duration(seconds: 1), () {
                  setState(() {
                    curPage = 1;
                  });
                  getProjectList();
                });
              },
              onLoad: () async {
                await Future.delayed(const Duration(seconds: 1), () async {
                  setState(() {
                    curPage++;
                  });
                  getMoreData();
                });
              },
              child: CustomScrollView(
                slivers: [
                  SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        return getRowItem(index,_listDatas[index]);
                      },
                      childCount: _listDatas.length)),
                ],
              ),
            );
          }).toList(),
        ),
    );
  }

  Future getTabData() async{
    print("ProjectPage getTabData");
    Api.getProjectTabData((List<ProjectEntity> tabList){
      //更新UI
      setState(() {
        _tabDatas = tabList;
        _tabController= TabController(vsync: this,length: _tabDatas.length);
      });
      getProjectList();
      //tab改变监听
      _tabController.addListener(() {
        print("ProjectPage tabController Listener ${_tabController.index.toDouble()} --- ${_tabController.animation?.value}");
        if(_tabController.index.toDouble() == _tabController.animation?.value){
          //赋值 并更新数据
          setState(() {
            _currentIndex = _tabController.index;
            curPage =1;
          });
          getProjectList();
        }
      });

    }, (error) {
      ToastUtils.showToast(error.errorMsg!);
    }
   );

  }


  Future getProjectList() async{
    print("ProjectPage getProjectList _currentIndex= $_currentIndex  curPage=$curPage");
    int cid =_tabDatas[_currentIndex].id;
    Api.getProjectList(curPage, cid,(ProjectListEntity data){
      print("ProjectPage getProjectList= $data");
      ///文章总数
      //更新UI
      setState(() {
        _listDatas =data.datas;
      });
    }, (error) {
      ToastUtils.showToast(error.errorMsg!);
    }
    );
  }


  Future getMoreData() async{
    print("ProjectPage getProjectList");
    int cid =_tabDatas[_currentIndex].id;
    Api.getProjectList(curPage, cid,(ProjectListEntity data){
      print("ProjectPage getProjectList= $data");
      ///文章总数
      //更新UI
      setState(() {
          //加载更多
         _listDatas.addAll(data.datas);
      });
    }, (error) {
      ToastUtils.showToast(error.errorMsg!);
    }
    );
  }

  Widget getRowItem(int index, ProjectListDatas itemData) {
    return   GestureDetector(
      onTap: (){
        // 点击跳转WebView
        Navigator.pushNamed((context), "webview_page",
            arguments: jsonEncode({
              "url": itemData.link,
              "title": itemData.title
            }));
      },
      child: Container(
        // padding: const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 10.0),
        margin:  const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
        decoration: const BoxDecoration(
          // 对任意一边设置边框。
            border: Border(
              top: BorderSide(width: 0.1, color: Colors.grey),
              bottom: BorderSide(width: 0.1, color: Colors.grey),
              left: BorderSide(width: 0.1, color: Colors.grey),
              right: /*BorderSide.none*/BorderSide(width: 0.1, color: Colors.grey), // 右边不设置边框
            ),
            //  对任意一边设置圆角。topLeft 左上、topRight 右上、bottomLeft 左下、bottomRight 右下
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),topRight: Radius.circular(20),
              bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20),
            )
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child : Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  flex:2,
                  child: Image.network(itemData.envelopePic),
              ),
              Expanded(
                flex:5,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      itemData.title,
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      itemData.desc,
                      style: const TextStyle(fontSize: 14, color:Colors.green),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Container(
                    alignment: Alignment.bottomLeft,
                    child:  Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Text(itemData.author,style: const TextStyle(fontSize: 14, color:Colors.black))),
                        ),
                       Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(itemData.niceDate, style: const TextStyle(fontSize: 14, color:Colors.black),textAlign: TextAlign.right)
                       )
                   ],
                    ),
                  )
                ],),
              )

            ],)
          )

      ) ,
    );

  }

}