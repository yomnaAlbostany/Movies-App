import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_pretty_dio_logger/flutter_pretty_dio_logger.dart';
import 'package:movies_app/core/network/api_constants.dart';

class DioFactory {
  static late Dio dio;

  static void init() async {
    const timeout = Duration(seconds: 120);
    dio = Dio(
        BaseOptions(
          baseUrl: ApiConstants.baseUrl,
          headers: {
            'Authorization':
                'Bearer ${ApiConstants.apiKey}',
            'accept': 'application/json',
          },
          connectTimeout: timeout,
          receiveTimeout: timeout,
          sendTimeout: timeout,
        ),
      )
      ..interceptors.add(
        PrettyDioLogger(
          requestBody: true,
          requestHeader: true,
          responseBody: true,
        ),
      );
  }

  static Future<Response> getData({
    required String path,
    Map<String, dynamic>? queryParams,
  }) async {
    try {
      final response = await dio.get(path, queryParameters: queryParams);
      return response;
    } catch (e) {
      log('API Error: $e');
      rethrow;
    }
  }
}
