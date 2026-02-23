import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import '../api/api_config.dart';

class DioService {
  static final DioService _instence = DioService._internal();
  factory DioService() => _instence;
  DioService._internal();

  late Dio _dio;

  Dio get dio => _dio;

  void init() {
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiConfig.baseUrl,
        connectTimeout: Duration(milliseconds: ApiConfig.connectTimeout),
        receiveTimeout: Duration(microseconds: ApiConfig.recieveTimeout),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    // 添加拦截器
    _dio.interceptors.addAll([
      _authInterceptor(), // 认证拦截器
      _errorInterceptor(), // 错误拦截器
      PrettyDioLogger(
        // 日志拦截器
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
        responseBody: true,
        error: true,
        compact: true,
        maxWidth: 90,
      ),
    ]);
  }

  // 认证拦截器 - 自动添加token
  Interceptor _authInterceptor() {
    return InterceptorsWrapper(
      onRequest: (options, handler) {
        // 从本地存储获取token（这里简化处理）
        String? token = _getToken();
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        return handler.next(options);
      },
    );
  }

  // 错误拦截器
  Interceptor _errorInterceptor() {
    return InterceptorsWrapper(
      onError: (error, handler) {
        // 统一错误处理
        String errorMessage = _handleError(error);
        error = error.copyWith(message: errorMessage);
        return handler.next(error);
      },
    );
  }

  // 模拟获取token的方法
  String? _getToken() {
    // 实际应用中从SharedPreferences获取
    return null;
  }

  // 错误处理
  String _handleError(DioError error) {
    switch (error.type) {
      case DioErrorType.connectionTimeout:
        return '连接超时';
      case DioErrorType.sendTimeout:
        return '发送超时';
      case DioErrorType.receiveTimeout:
        return '接收超时';
      case DioErrorType.badCertificate:
        return '证书错误';
      case DioErrorType.badResponse:
        return _handleResponseError(error.response);
      case DioErrorType.cancel:
        return '请求取消';
      case DioErrorType.connectionError:
        return '网络连接失败';
      case DioErrorType.unknown:
        return '未知错误: ${error.message}';
    }
  }

  String _handleResponseError(Response? response) {
    if (response == null) return '响应为空';

    switch (response.statusCode) {
      case 400:
        return '请求错误(400)';
      case 401:
        return '未授权，请登录(401)';
      case 403:
        return '拒绝访问(403)';
      case 404:
        return '请求地址不存在(404)';
      case 500:
        return '服务器内部错误(500)';
      case 502:
        return '网关错误(502)';
      case 503:
        return '服务不可用(503)';
      default:
        return '连接失败(${response.statusCode})';
    }
  }

  // 设置token（登录后调用）
  void setToken(String token) {
    _dio.options.headers['Authorization'] = 'Bearer $token';
  }

  // 清除token（退出登录时调用）
  void clearToken() {
    _dio.options.headers.remove('Authorization');
  }
}
