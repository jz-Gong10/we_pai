import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import '../api/api_config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DioService {
  static final DioService _instence = DioService._internal();
  factory DioService() => _instence;
  DioService._internal();

  late Dio _dio;
  String? _token; // 添加实例变量存储token

  Dio get dio {
    if (!_dioInitialized) {
      init();
      _dioInitialized = true;
    }
    return _dio;
  } //当首次调用dio时初始化dio对象

  bool _dioInitialized = false;

  void init() {
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiConfig.baseUrl,
        connectTimeout: Duration(milliseconds: ApiConfig.connectTimeout),
        receiveTimeout: Duration(milliseconds: ApiConfig.recieveTimeout),
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
      onRequest: (options, handler) async {
        // 从实例变量获取token
        String? token = _token;
        if (token == null) {
          // 如果实例变量中没有token，尝试从SharedPreferences获取
          SharedPreferences prefs = await SharedPreferences.getInstance();
          token = prefs.getString('token');
          if (token != null) {
            _token = token; // 更新实例变量
          }
        }
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

  // 从SharedPreferences获取token（保留此方法以保持兼容性）
  Future<String?> _getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  // 错误处理
  String _handleError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return '连接超时';
      case DioExceptionType.sendTimeout:
        return '发送超时';
      case DioExceptionType.receiveTimeout:
        return '接收超时';
      case DioExceptionType.badCertificate:
        return '证书错误';
      case DioExceptionType.badResponse:
        return _handleResponseError(error.response);
      case DioExceptionType.cancel:
        return '请求取消';
      case DioExceptionType.connectionError:
        return '网络连接失败';
      case DioExceptionType.unknown:
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
    _token = token; // 更新实例变量
    if (!_dioInitialized) {
      init();
      _dioInitialized = true;
    }
    _dio.options.headers['Authorization'] = 'Bearer $token';
  }

  // 清除token（退出登录时调用）
  void clearToken() {
    _token = null; // 清除实例变量
    _dio.options.headers.remove('Authorization');
  }
}
