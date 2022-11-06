import 'dart:async';
import 'package:eve_flutter/models/movie.dart';
import 'package:eve_flutter/view/main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sizer/sizer.dart';


final boxA = Provider<List<Movie>>((ref) => []);

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Future.delayed(Duration(milliseconds: 500));
  await Hive.initFlutter();
  //fav movies
  final movieBox = await Hive.openBox<Movie>('movies');

  //1page popular
  final box = await Hive.openBox<String>('data');

SystemChrome.setPreferredOrientations([
  DeviceOrientation.portraitUp,
  DeviceOrientation.portraitDown,

]);


  runApp(ProviderScope(
    overrides: [
      boxA.overrideWithValue(movieBox.values.toList().cast<Movie>())
    ],
      child: Home()));
}


class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return  Sizer(
        builder: (context, orientation, deviceType) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData.dark().copyWith(
                scaffoldBackgroundColor: Colors.black,
                appBarTheme: AppBarTheme(
                  backgroundColor: Colors.black,
                    systemOverlayStyle: SystemUiOverlayStyle(
                        statusBarBrightness: Brightness.light
                    ))
            ),
            home: MainPage(),
          );
        }
    );
  }
}







