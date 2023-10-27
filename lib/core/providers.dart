import 'package:dio/dio.dart';
import 'package:emplman/core/env.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dioProvider = Provider((_) => Dio(
      BaseOptions(baseUrl: baseUrl),
    ));
