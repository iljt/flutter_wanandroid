import 'package:flutter_wanandroid/entity/user_info_entity.dart';

import '../entity/article_list_entity.dart';
import '../entity/banner_entity.dart';
import '../entity/collect_article_list_entity.dart';
import '../entity/navigation_entity.dart';
import '../entity/project_entity.dart';
import '../entity/project_list_entity.dart';
import '../net/ErrorEntity.dart';
import '../net/HttpManager.dart';

class Api{
  static var  baseUrl = "https://www.wanandroid.com/";

  //首页文章列表 http://www.wanandroid.com/article/list/0/json  GET请求
  static const String ARTICLE_LIST = "article/list/";
  //首页banner  GET请求
  static const String BANNER = "banner/json";
  //登录 POST请求
  static const LOGIN = "user/login";
  //注册 POST请求
  static const REGISTER = "user/register";
  //退出  GET请求
  static const LOGOUT = "user/logout/json";
  //项目分类 GET请求
  static const String PROJECT = "project/tree/json";
  //项目列表数据 GET请求
  static const String PROJECT_LIST = "project/list/";
  //导航数据 GET请求
  static const String NAVIGITION = "navi/json";
  // 获取个人积分，需要登录后访问 GET请求
  static const String userCoin = "lg/coin/userinfo/json";

  // 收藏文章 POST请求  https://www.wanandroid.com/lg/collect/1165/json 参数：文章id，拼接在链接中。
  static const String ADD_COLLECT = "lg/collect/";
  //收藏页文章列表 GET请求 https://www.wanandroid.com/lg/collect/list/0/json 参数： 页码：拼接在链接中，从0开始。
  static const String COLLECT_LIST = "lg/collect/list/";
 // 收藏页取消收藏  POST请求  https://www.wanandroid.com/lg/uncollect/2805/json 参数：id: 拼接在链接上 originId: 列表页下发，无则为-1
  static const String UNCOLLECT = "lg/uncollect/";
 // 文章列表取消收藏  POST请求  https://www.wanandroid.com/lg/uncollect_originId/2333/json 参数：id: 拼接在链接上
   static const String ARTICLE_UNCOLLECT = "lg/uncollect_originId/";


  ///首页文章列表
  static getArticleList(int pageNum, Function(ArticleListEntity) success,Function(ErrorEntity) error) {
    HttpManager.getInstance().resuest<ArticleListEntity>('$ARTICLE_LIST$pageNum/json',params: {},success:(ArticleListEntity data){
      success(data);
    },error: (ErrorEntity errorEntity){
      error(errorEntity);
    });
  }

  ///首页Banner
  static getBanner(Function(List<BannerEntity>) success,Function(ErrorEntity) error) async{
    HttpManager.getInstance().resuestList<BannerEntity>(BANNER,params: {},success:(List<BannerEntity> bannerList) {
      success(bannerList);
    },error: (ErrorEntity errorEntity){
      error(errorEntity);
    });
  }

  ///注册
  static userRegister(String account,String password,Function(UserInfoEntity) success,Function(ErrorEntity) error) {
    HttpManager.getInstance().resuest<UserInfoEntity>(REGISTER,method:"post",params: {
      "username": account,
      "password": password,
      "repassword": password
    },success:(UserInfoEntity data){
      success(data);
    },error: (ErrorEntity errorEntity){
      error(errorEntity);
    });
  }

  ///登录
  static userLogin(String account,String password,Function(UserInfoEntity) success,Function(ErrorEntity) error) {
    HttpManager.getInstance().resuest<UserInfoEntity>(LOGIN,method:"post",params: {
      "username": account,
      "password": password
    },success:(UserInfoEntity data){
      success(data);
    },error: (ErrorEntity errorEntity){
      error(errorEntity);
    });
  }

  ///退出登录
  static userLoginOut(Function(Object?) success,Function(ErrorEntity) error) {
    HttpManager.getInstance().resuest<Object?>(LOGOUT,params: {
    },success:(Object? data){
      success(data);
    },error: (ErrorEntity errorEntity){
      error(errorEntity);
    });
  }

  ///项目分类
  static getProjectTabData(Function(List<ProjectEntity>) success,Function(ErrorEntity) error) async{
    HttpManager.getInstance().resuestList<ProjectEntity>(PROJECT,params: {},success:(List<ProjectEntity> tabList) {
      success(tabList);
    },error: (ErrorEntity errorEntity){
      error(errorEntity);
    });
  }

  ///项目分类列表
  static getProjectList(int pageNum,int cid, Function(ProjectListEntity) success,Function(ErrorEntity) error) {
    HttpManager.getInstance().resuest<ProjectListEntity>('$PROJECT_LIST$pageNum/json',params: {
      "cid":cid
    },success:(ProjectListEntity data){
      success(data);
    },error: (ErrorEntity errorEntity){
      error(errorEntity);
    });
  }

  ///导航数据
  static getNavigationData(Function(List<NavigationData>) success,Function(ErrorEntity) error) async{
    HttpManager.getInstance().resuestList<NavigationData>(NAVIGITION,params: {},success:(List<NavigationData> navigationList) {
      success(navigationList);
    },error: (ErrorEntity errorEntity){
      error(errorEntity);
    });
  }

  ///收藏页收藏列表
  static getCollectList(int pageNum, Function(CollectArticleListData) success,Function(ErrorEntity) error) {
    HttpManager.getInstance().resuest<CollectArticleListData>('$COLLECT_LIST$pageNum/json',params: {},success:(CollectArticleListData data){
      success(data);
    },error: (ErrorEntity errorEntity){
      error(errorEntity);
    });
  }

  ///收藏文章
  static addCollect(int id,Function(Object?) success,Function(ErrorEntity) error) {
    HttpManager.getInstance().resuest<Object?>('$ADD_COLLECT$id/json',method:"post",params: {
    },success:(Object? data){
      success(data);
    },error: (ErrorEntity errorEntity){
      error(errorEntity);
    });
  }

  ///收藏页取消收藏
  static unCollect(int id,int originId,Function(Object?) success,Function(ErrorEntity) error) {
    HttpManager.getInstance().resuest<Object?>('$UNCOLLECT$id/json',method:"post",params: {'originId':originId},success:(Object? data){
      success(data);
    },error: (ErrorEntity errorEntity){
      error(errorEntity);
    });
  }

  ///文章列表取消收藏
  static articleCollect(int id,Function(Object?) success,Function(ErrorEntity) error) {
    HttpManager.getInstance().resuest<Object?>('$ARTICLE_UNCOLLECT$id/json',method:"post",params: {
    },success:(Object? data){
      success(data);
    },error: (ErrorEntity errorEntity){
      error(errorEntity);
    });
  }

}