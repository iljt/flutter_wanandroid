import 'dart:convert';

import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';

import '../api/Api.dart';
import '../entity/collect_article_list_entity.dart';
import '../util/ToastUtils.dart';

class CollectRoute extends StatefulWidget{
  const CollectRoute({super.key});

  @override
  State<StatefulWidget> createState() {
    return CollectState();
  }
}

class CollectState extends State<CollectRoute>{
  //收藏的文章列表数据
  List<CollectArticleListDataDatas> articleList= [];
  //当前页数
  int curPage = 0;
  ///控制正在加载的显示
  bool _isHide = true;

  @override
  void initState() {
    super.initState();
    getCollectList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("收藏"),
        ),
        body:Stack(
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
                child:    EasyRefresh(
                    header: const /*PhoenixHeader()*/MaterialHeader(),
                    footer: const /*PhoenixFooter()*/MaterialFooter(),
                    onRefresh:() async{
                      await Future.delayed(const Duration(seconds: 1),(){
                        setState(() {
                          curPage = 0;
                        });
                        getCollectList();
                      });
                    },
                    onLoad:() async{
                      await Future.delayed(const Duration(seconds: 1),(){
                        setState(() {
                          curPage++;
                        });
                        getMoreData();
                      });
                    },
                    child: CustomScrollView(
                      slivers: [
                        SliverList(delegate: SliverChildBuilderDelegate((BuildContext context, int index){
                          return getItem(index);
                        },childCount: articleList.length))
                      ],
                    )
                )
            )
          ],
        )
    );
  }

  //文章收藏列表数据
  Future getCollectList() async{
      print("CollectRoute getCollectList");
      Api.getCollectList(curPage, (CollectArticleListData data){
        print("CollectRoute getCollectList= $data");
        //to ensure the object is still in the tree
        if(mounted){
          //更新UI
          setState(() {
            articleList = data.datas;
            _isHide=false;
          });
        }
      }, (error) {
        ToastUtils.showToast(error.errorMsg!);
      }
      );
    }

  //取消收藏
  Future unCollect(int id,int originId) async{
    print("CollectRoute unCollect");
    Api.unCollect(id,originId, (Object? data){
      print("CollectRoute unCollect= $data");
      //to ensure the object is still in the tree
      ToastUtils.showToast("取消收藏成功!");
      if(mounted){
        //更新UI
        setState(() {

        });
      }
    }, (error) {
      ToastUtils.showToast(error.errorMsg!);
    }
    );
  }

  Future getMoreData() async {
    print("CollectRoute getMoreData");
    Api.getCollectList(curPage, (CollectArticleListData data){
      print("CollectRoute getMoreData= $data");
      //to ensure the object is still in the tree
      if(mounted){
        //更新UI
        setState(() {
          articleList.addAll(data.datas);
        });
      }
    }, (error) {
      ToastUtils.showToast(error.errorMsg!);
    }
    );
  }

  Widget getItem(int index) {
    var itemData =articleList[index];
    return  Dismissible(
      // Show a red background as the item is swiped away
        background: Container(color: Colors.redAccent[700]),
        // Each Dismissible must contain a Key. Keys allow Flutter to uniquely identify Widgets.
        key: Key(itemData.title),
        // We need to provide a function that will tell our app what to do after an item has been swiped away.
        onDismissed:(DismissDirection direction){
          // Remove the item from our data source
          unCollect(itemData.id,itemData.originId).then((value) {
            articleList.removeAt(index);
          });
          // Show a snackbar! This snackbar could also contain "Undo" actions.
          //ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("已移除")));
        },
        child: getRow(index));
  }

  Widget getRow(int i) {
    var itemData =articleList[i];
    return GestureDetector(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            padding: const EdgeInsets.all(10.0),
            child: ListTile(
              title: Text(
                itemData.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.green,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular((20.0)), // 圆角度
                      ),
                      child: Text(
                        itemData.chapterName,
                        style: const TextStyle(color: Colors.green),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 6,top: 6),
                      child: Text(itemData.niceDate),
                    ),
                  ],
                ),
              ),
              trailing: const Icon(Icons.chevron_right),
            )),
        const Divider(height: 1,color: Colors.green,)
      ]),
      onTap: () {
        // 点击跳转WebView
        Navigator.pushNamed((context), "webview_page",
            arguments: jsonEncode({
              "url": itemData.link,
              "title": itemData.title
            }));
      },
    );
  }
}