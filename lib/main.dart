import 'package:empman/core/global_keys.dart';
import 'package:empman/core/providers.dart';
import 'package:empman/core/utils/widgets/loaders.dart';
import 'package:empman/features/auth/views/login_page.dart';
import 'package:empman/views/main_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  Future<bool> getIsLoggedIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool isLoggedin = prefs.getBool('isLoggedin') ?? false;
    return isLoggedin;
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
      ),
      darkTheme: ThemeData.dark(useMaterial3: true),
      themeMode: ref.watch(themeModeProvider),
      debugShowCheckedModeBanner: false,
      scaffoldMessengerKey: scaffoldMessengerKey,
      home: FutureBuilder(
          future: getIsLoggedIn(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return loaderPrimary;
            }
            if (snapshot.hasError) {
              debugPrint(snapshot.error.toString());
              return const Center(
                child: Text('Something went wrong'),
              );
            }
            return snapshot.data ? const MainLayout() : const LogingPage();
          }),
    );
  }
}
