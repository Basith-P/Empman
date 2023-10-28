import 'package:dio/dio.dart';
import 'package:empman/core/env.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dioProvider = Provider((_) => Dio(
      BaseOptions(baseUrl: baseUrl),
    ));

final themeModeProvider = StateProvider<ThemeMode>((_) => ThemeMode.system);
