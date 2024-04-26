import 'dart:convert';

import 'package:flutter/material.dart';
import '../api/Api.dart';
import '../entity/article_list_entity.dart';
import '../util/ToastUtils.dart';

class ArticleItem extends StatefulWidget {
  ArticleListDatas itemData;

  ArticleItem(this.itemData, {super.key});

  @override
  State<StatefulWidget> createState() {
    return ArticleItemState();
  }
}

class ArticleItemState extends State<ArticleItem>{
  bool collect = false;

  @override
  Widget build(BuildContext context) {
    print("ArticleItem build");
    ///时间与作者
    Row author = Row( //水平线性布局
      children: <Widget>[
        //expanded 最后摆我，相当于linearlayout的weight权重
        Expanded(
            child: Text.rich(TextSpan(children: [
              const TextSpan(text: "作者: "),
              TextSpan(
                  text: widget.itemData.author,
                  style: const TextStyle(color: Colors.green))
            ]))),
        Text(widget.itemData.niceDate)//时间
      ],
    );

    ///标题
    Text title = Text(
      widget.itemData.title,
      style: const TextStyle(fontSize: 16.0, color: Colors.black),
      textAlign: TextAlign.left,
    );

    var img= 'assets/images/collect_normal.png';
    collect=widget.itemData.collect;
    print("ArticleItem collect= ${widget.itemData.collect}");
    if(collect){
      img= 'assets/images/collect_selected.png';
    }else{
      img= 'assets/images/collect_normal.png';
    }
    ///章节名
    Row chapterName =Row(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 1,
          child:  Text(widget.itemData.chapterName,style: const TextStyle(color: Colors.green)),
        ),
        InkWell(child: Image.asset(img,width: 20,height: 20),
          onTap: (){
            if(collect){
              articleUnCollect(widget.itemData);
            }else{
              addCollect(widget.itemData);
            }
          },)

      ],
    );

    Column column = Column( //垂直线性布局
      crossAxisAlignment: CrossAxisAlignment.start, //子控件左对齐
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: author,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
          child: title,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 10.0),
          child: chapterName,
        ),
      ],
    );
    return GestureDetector(
      onTap: (){
        // 点击跳转WebView
        Navigator.pushNamed((context), "webview_page",
            arguments: jsonEncode({
              "url": widget.itemData.link,
              "title": widget.itemData.title
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
        child: column,
      ) ,
    );
  }


  Future addCollect(ArticleListDatas itemData) async{
    print("ArticleItem addCollect");
    Api.addCollect(itemData.id, (Object? data){
      print("ArticleItem addCollect= $data");
      //to ensure the object is still in the tree
      setState(() {
        itemData.collect =true;
        widget.itemData=itemData;
      });
    }, (error) {
      ToastUtils.showToast(error.errorMsg!);
    }
    );
  }

  Future articleUnCollect(ArticleListDatas itemData) async{
    print("ArticleItem articleUnCollect");
    Api.articleCollect(itemData.id, (Object? data){
      print("ArticleItem articleUnCollect= $data");
      //to ensure the object is still in the tree
      setState(() {
        itemData.collect =false;
        widget.itemData=itemData;
      });
    }, (error) {
      ToastUtils.showToast(error.errorMsg!);
    }
    );
  }
}

