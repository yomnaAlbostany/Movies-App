import 'package:flutter/material.dart';
import 'package:movies_app/core/network/dio_factory.dart';
import 'package:movies_app/core/router/app_route.dart';
import 'package:movies_app/core/router/routes.dart';
import 'package:movies_app/core/style/app_color.dart';
import 'package:movies_app/features/home/logic/favorite_provider.dart';
import 'package:provider/provider.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  DioFactory.init();
  runApp(MyApp()) ;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=>FavoriteProvider()..loadFavorites())
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.dark(primary: AppColor.primaryColor),
        ),
        onGenerateRoute: AppRoute().onGenerateRoute,
        initialRoute: Routes.splash,
      ),
    );
  }
}
