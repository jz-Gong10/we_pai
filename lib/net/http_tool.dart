import 'dart:developer';

import 'package:dio/dio.dart';

/// 简单封装的网络请求工具，基于 dio
class HttpTool {
	HttpTool._internal() {
		final options = BaseOptions(
			connectTimeout: const Duration(seconds: 10),
			receiveTimeout: const Duration(seconds: 10),
			responseType: ResponseType.json,
			headers: {
				'Accept': 'application/json',
			},
		);

		dio = Dio(options);

		dio.interceptors.add(
			InterceptorsWrapper(
				onRequest: (options, handler) {
					// 全局请求前处理（可注入 token 等）
					log('HTTP > ${options.method} ${options.uri}');
					handler.next(options);
				},
				onResponse: (response, handler) {
					log('HTTP < ${response.statusCode} ${response.requestOptions.uri}');
					handler.next(response);
				},
				onError: (err, handler) {
					log('HTTP ! ${err.type} ${err.requestOptions.uri}');
					handler.next(err);
				},
			),
		);
	}

	late final Dio dio;

	static final HttpTool _instance = HttpTool._internal();
	factory HttpTool() => _instance;

	/// 设置 baseUrl
	void setBaseUrl(String url) {
		dio.options.baseUrl = url;
	}

	/// 设置 token（例如 Bearer）
	void setToken(String token) {
		dio.options.headers['Authorization'] = 'Bearer $token';
	}

	void removeToken() {
		dio.options.headers.remove('Authorization');
	}

	/// 简单的 GET
	Future<Response<dynamic>> get(
		String path, {
		Map<String, dynamic>? queryParameters,
		Options? options,
		CancelToken? cancelToken,
	}) async {
		try {
			final resp = await dio.get(
				path,
				queryParameters: queryParameters,
				options: options,
				cancelToken: cancelToken,
			);
			return resp;
		} on DioException catch (e) {
			throw _wrapDioError(e);
		}
	}

	/// 简单的 POST
	Future<Response<dynamic>> post(
		String path, {
		dynamic data,
		Map<String, dynamic>? queryParameters,
		Options? options,
		CancelToken? cancelToken,
	}) async {
		try {
			final resp = await dio.post(
				path,
				data: data,
				queryParameters: queryParameters,
				options: options,
				cancelToken: cancelToken,
			);
			return resp;
		} on DioException catch (e) {
			throw _wrapDioError(e);
		}
	}

	/// 通用请求
	Future<Response<dynamic>> request(
		String path, {
		String method = 'GET',
		dynamic data,
		Map<String, dynamic>? queryParameters,
		Options? options,
		CancelToken? cancelToken,
	}) async {
		try {
			final resp = await dio.request(
				path,
				data: data,
				options: options?.copyWith(method: method) ?? Options(method: method),
				queryParameters: queryParameters,
				cancelToken: cancelToken,
			);
			return resp;
		} on DioException catch (e) {
			throw _wrapDioError(e);
		}
	}

	/// 取消请求
	void cancelRequests(CancelToken token, [String? reason]) {
		token.cancel(reason);
	}

	ApiException _wrapDioError(DioException e) {
		if (e.type == DioExceptionType.connectionTimeout ||
				e.type == DioExceptionType.receiveTimeout ||
				e.type == DioExceptionType.sendTimeout) {
			return ApiException(-1, '请求超时');
		}

		if (e.response != null) {
			final status = e.response?.statusCode ?? 0;
			final message = e.response?.statusMessage ?? e.message;
			return ApiException(status, message ?? 'Unknown error');
		}

		return ApiException(-2, e.message ?? '网络错误');
	}
}

/// 简单的 API 异常封装
class ApiException implements Exception {
	final int code;
	final String message;

	ApiException(this.code, this.message);

	@override
	String toString() => 'ApiException($code): $message';
}

/*
 使用示例：

 final http = HttpTool();
 http.setBaseUrl('https://api.example.com');
 http.setToken('your-token');

 // GET
 final resp = await http.get('/users', queryParameters: {'page': 1});
 if (resp.statusCode == 200) {
	 final data = resp.data; // JSON
 }

 // POST
 final postResp = await http.post('/login', data: {'name': 'a', 'pwd': 'b'});

 */

