
import 'dart:async';

import 'package:dio/dio.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';
import 'package:flutter/material.dart';

final http = Dio();

FutureOr<void> configureDio() async {
  
  debugPrint("Dio initialization...");
  
  http.interceptors.add(RetryInterceptor(
    dio: http,
    logPrint: debugPrint,
    retries: 3,
    retryDelays: const [
      Duration(seconds: 1),
      Duration(seconds: 2),
      Duration(seconds: 3),
    ]
  ));
}
