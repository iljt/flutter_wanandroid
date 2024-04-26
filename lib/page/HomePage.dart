import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/api/Api.dart';
import 'package:flutter_wanandroid/entity/article_list_entity.dart';
import 'package:flutter_wanandroid/widgets/banner/BannerView.dart';

import '../entity/banner_entity.dart';
import '../util/ToastUtils.dart';
import '../widgets/ArticleItem.dart';


class HomePage extends StatefulWidget{
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage>{
  ///滑动控制器
  final ScrollController _controller = new ScrollController();
  ///控制正在加载的显示
  bool _isHide = true;
  ///请求到的文章数据
  List<ArticleListDatas> articles = [];
  ///banner图
  List<BannerEntity> banners = [];
  ///总文章数有多少
  var totalCount = 0;
  ///分页加载，当前页码
  var curPage = 0;

  @override
  void initState() {
    super.initState();
    print("HomePage initState");
    _controller.addListener(() {
       ///获得 SrollController 监听控件可以滚动的最大范围
       var maxScroll = _controller.position.maxScrollExtent;
       ///获取当前位置的像素值
       var pixels = _controller.position.pixels;
       ///当前滑动位置到底部,同时还有更多数据
       if(pixels == maxScroll && curPage < totalCount){
          //上拉加载更多
          getArticleList();
       }
    });
    //下拉刷新
    pullToRefresh();
  }
  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        body: Stack(
         children: [
           //加载提示
           Offstage(
             offstage: !_isHide,//是否显示
             child: Center(
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
            child: RefreshIndicator(
              onRefresh:pullToRefresh,
              child: ListView.builder(
                  //条目数 +1代表了banner的条目
                  itemCount: articles.length+1,
                  itemBuilder: (BuildContext context, int index) => buildItem(index),
                  controller: _controller,
              ),
            ),
          )
         ],
        )
    );
  }

  //文章列表数据
  Future getArticleList() async{
    print("HomePage getArticleList");
     Api.getArticleList(curPage, (ArticleListEntity data){
       print("HomePage getArticleList=$data");
      ///文章总数
      totalCount =data.pageCount;
      if (curPage == 0) {
        articles.clear();
      }
      curPage++;
      articles.addAll(data.datas);
       //to ensure the object is still in the tree
       //if(mounted){
         //更新UI
         setState(() {

         });
       //}
    }, (error) {
      ToastUtils.showToast(error.errorMsg!);
    }
    );
  }

  //顶部Banner
  Future getBanner() async{
    print("HomePage getBanner");
      Api.getBanner((List<BannerEntity> bannerList){
        banners.clear();
        banners.addAll(bannerList);
        //更新UI
        setState(() {

        });

      }, (error) {
        ToastUtils.showToast(error.errorMsg!);
      }
      );
  }

  //下拉刷新
  Future<void> pullToRefresh() async {
    print("HomePage pullToRefresh");
    curPage = 0;
    ///组合两个异步任务，创建一个都完成后的新的Future
    Iterable<Future> futures = [getBanner()/*,getArticleList()*/];
    await Future.wait(futures);
    Iterable<Future> futures2 = [getArticleList()];
    await Future.wait(futures2);
    _isHide =false;
    setState(() {

    });
   return;
  }

  //文章Item
  Widget buildItem(int index) {
    if(index ==0){
      return  SizedBox(
        //MediaQuery.of(context).size.height屏幕高度
        //MediaQuery.of(context).size.width屏幕宽度
        width: MediaQuery.of(context).size.width,
        //1.5是banner宽高比，0.8是viewportFraction的值
        height: MediaQuery.of(context).size.width / 1.5 * 0.8,
        child:bannerView() ,
      );
    }
    ArticleListDatas itemData = articles[index - 1];
    return  ArticleItem(itemData);
  }

  Widget? bannerView() {
    List<Widget> list = banners.map((element) {
      return Image.network(element.imagePath,fit: BoxFit.contain,);
    }).toList();
    return list.isNotEmpty?BannerView(
      list,
      intervalDuration: const Duration(seconds: 3), bannerViewClick: (int index) {
          // 点击跳转WebView
         Navigator.pushNamed((context), "webview_page",
              arguments: jsonEncode({
                "url": banners[index].url,
                "title": banners[index].title
         }));
    },
    ):null;
  }
}