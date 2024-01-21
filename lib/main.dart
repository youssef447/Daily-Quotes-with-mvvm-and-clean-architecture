import 'package:bloc/bloc.dart';
import 'package:dailyquotes/core/utils/globales.dart';
import 'package:dailyquotes/core/utils/themes.dart';
import 'package:dailyquotes/view/homeScreen.dart';
import 'package:flutter/material.dart';

import 'core/Di/injection.dart';
import 'core/utils/apiConstants.dart';
import 'model/services/Network/local/cach_helper.dart';
import 'model/services/Network/remote/dio_helper.dart';
import 'view-model/blocObserver.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  DioHelper.init(baseUrl: ApiConstants.baseUrl);
  configurationDependencies();
    Bloc.observer = MyBlocObserver();


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height - AppBar().preferredSize.height;
    width = MediaQuery.of(context).size.width;
    return MaterialApp(
      title: 'Daily Quotes',
      debugShowCheckedModeBanner: false,
      theme: darkTheme,
      home: const HomeScreen(),
    );
  }
}
