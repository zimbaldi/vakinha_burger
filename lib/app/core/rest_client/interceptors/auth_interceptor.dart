import 'package:delivery_app/app/core/global/global_context.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthInterceptor extends Interceptor {
  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final sp = await SharedPreferences.getInstance();
    final accessToken = sp.getString('accessToken');
    options.headers['Authorization'] = 'Bearer $accessToken';

    return handler.next(options); //havia esquecido o return
  }

  @override
  Future<void> onError(DioError err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      //Redirecionar o usuário para tela de home
      GlobalContext.i.loginExpire();
      handler.next(err);
    } else {
      handler.next(err);
    }
  }
}
