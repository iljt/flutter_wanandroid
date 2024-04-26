import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:path_provider/path_provider.dart';
import '../api/Api.dart';
import 'BaseEntity.dart';
import 'BaseListEntity.dart';
import 'ErrorEntity.dart';

class HttpManager{
  static  final HttpManager _instance= HttpManager._internal();
  Dio? dio;
  PersistCookieJar? cookieJar;

  factory HttpManager.getInstance(){
    return _instance;
  }

  HttpManager._internal(){
      BaseOptions options = BaseOptions(
          baseUrl: Api.baseUrl,
          contentType: Headers.jsonContentType,
          responseType: ResponseType.json,
          receiveDataWhenStatusError: false,
          connectTimeout: const Duration(seconds:30),
          receiveTimeout: const Duration(seconds:3),
          headers: {
            "version": '5.4.3+1',
            "Authorization": '',
          });
      dio =Dio(options);
      //是否开启请求日志
      dio?.interceptors.add(LogInterceptor(requestBody: true,responseBody: true));
      //Cookie管理 某些接口可用来判断登录状态，如收藏列表、收藏、取消收藏等等
      getCookieJar().then((PersistCookieJar? cj) {
        dio?.interceptors.add(CookieManager(cj as CookieJar));
      });
      //添加拦截器
     /* dio?.interceptors.add(InterceptorsWrapper(onRequest: (RequestOptions options, RequestInterceptorHandler handler) {

        print("请求之前 header = ${options.headers.toString()}");
        // 如果你想完成请求并返回一些自定义数据，你可以使用 `handler.resolve(response)`。
        // 如果你想终止请求并触发一个错误，你可以使用 `handler.reject(error)`。
        return handler.next(options); //continue
      }, onResponse: (Response response, ResponseInterceptorHandler handler) {
        print("响应之前");
        // 如果你想终止请求并触发一个错误，你可以使用 `handler.reject(error)`。
        return handler.next(response); // continue
      }, onError: (DioError e, ErrorInterceptorHandler handler) {
        print("错误之前");
        // 如果你想完成请求并返回一些自定义数据，你可以使用 `handler.resolve(response)`。
        return handler.next(e);
      }));*/
  }

  Future<PersistCookieJar?> getCookieJar() async {
    if (cookieJar == null) {
      Directory appDocDir = await getApplicationDocumentsDirectory();
      String appDocPath = appDocDir.path;
      cookieJar = PersistCookieJar(storage: FileStorage(appDocPath));
    }
    return cookieJar;
  }

  // 请求，返回参数为 T
  // method：请求方法
  // path：请求地址
  // params：请求参数
  // success：请求成功回调
  // error：请求失败回调
  ///默认get请求
  Future resuest<T>(String url,{String method = "get",Map<String,dynamic>? params,  required Function(T) success ,required Function(ErrorEntity) error}) async{
    try{
     Response response = await dio!.request(url,queryParameters: params,options: Options(method: method));
     if (response != null && response.statusCode == 200) {
       BaseEntity entity = BaseEntity<T>.fromJson(response.data);
       print("BaseEntity entity= ${entity.toString()}");
       if (entity.errorCode == 0) {
         success(entity.data);
       } else {
         error(ErrorEntity(errorCode: entity.errorCode, errorMsg: entity.errorMsg));
       }
     } else {
       error(ErrorEntity(errorCode: -1, errorMsg: "未知错误"));
     }
    } on DioException catch(e){
      error(createErrorEntity(e));
    }
  }

  // 请求，返回参数为 List<T>
  // method：请求方法
  // path：请求地址
  // params：请求参数
  // success：请求成功回调
  // error：请求失败回调
  ///默认get请求
  Future resuestList<T>(String url,{String method = "get",Map<String,dynamic>? params,  required Function(List<T>) success ,required Function(ErrorEntity) error}) async{
    try{
      Response response = await dio!.request(url,queryParameters: params,options: Options(method: method));
      if (response != null && response.statusCode == 200) {
        BaseListEntity entity = BaseListEntity<T>.fromJson(response.data);
        if (entity.errorCode == 0) {
          success(entity.data as List<T>);
        } else {
          error(ErrorEntity(errorCode: entity.errorCode, errorMsg: entity.errorMsg));
        }
      } else {
        error(ErrorEntity(errorCode: -1, errorMsg: "未知错误"));
      }
    } on DioException catch(e){
      error!(createErrorEntity(e));
    }
  }


  // 错误信息
  ErrorEntity createErrorEntity(DioException error) {
    switch (error.type) {
      case DioExceptionType.cancel:
        {
          return ErrorEntity(errorCode: -1, errorMsg: "请求取消");
        }
        break;
      case DioExceptionType.connectionTimeout:
        {
          return ErrorEntity(errorCode: -1, errorMsg: "连接超时");
        }
        break;
      case DioExceptionType.sendTimeout:
        {
          return ErrorEntity(errorCode: -1, errorMsg: "请求超时");
        }
        break;
      case DioExceptionType.receiveTimeout:
        {
          return ErrorEntity(errorCode: -1, errorMsg: "响应超时");
        }
        break;
      case DioExceptionType.badResponse:
        {
          try {
            int? errCode = error.response?.statusCode;
            String? errMsg = error.response?.statusMessage;
            return ErrorEntity(errorCode: errCode, errorMsg: errMsg);
//          switch (errCode) {
//            case 400: {
//              return ErrorEntity(errorCode: errCode, errorMsg: "请求语法错误");
//            }
//            break;
//            case 403: {
//              return ErrorEntity(errorCode: errCode, errorMsg: "服务器拒绝执行");
//            }
//            break;
//            case 404: {
//              return ErrorEntity(errorCode: errCode, errorMsg: "无法连接服务器");
//            }
//            break;
//            case 405: {
//              return ErrorEntity(errorCode: errCode, errorMsg: "请求方法被禁止");
//            }
//            break;
//            case 500: {
//              return ErrorEntity(errorCode: errCode, errorMsg: "服务器内部错误");
//            }
//            break;
//            case 502: {
//              return ErrorEntity(errorCode: errCode, errorMsg: "无效的请求");
//            }
//            break;
//            case 503: {
//              return ErrorEntity(errorCode: errCode, errorMsg: "服务器挂了");
//            }
//            break;
//            case 505: {
//              return ErrorEntity(errorCode: errCode, errorMsg: "不支持HTTP协议请求");
//            }
//            break;
//            default: {
//              return ErrorEntity(errorCode: errCode, errorMsg: "未知错误");
//            }
//          }
          } on Exception catch (_) {
            return ErrorEntity(errorCode: -1, errorMsg: "未知错误");
          }
        }
        break;
      default:
        {
          return ErrorEntity(errorCode: -1, errorMsg: error.message);
        }
    }
  }
}


