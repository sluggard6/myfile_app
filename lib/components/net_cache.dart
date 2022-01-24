import 'dart:collection';
import 'package:dio/dio.dart';
import 'global.dart';

class CacheObject {
  CacheObject(this.response)
      : timeStamp = DateTime.now().millisecondsSinceEpoch;
  Response response;
  int timeStamp;

  @override
  bool operator ==(other) {
    return response.hashCode == other.hashCode;
  }

  @override
  int get hashCode => response.realUri.hashCode;
}

class NetCache extends Interceptor {
  // 为确保迭代器顺序和对象插入时间一致顺序一致，我们使用LinkedHashMap
  var cache = LinkedHashMap<String, CacheObject>();

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    if (!(Global.profile.cacheConfig?.enable as bool)) handler.next(options);
    super.onRequest(options, handler);
  }
}
