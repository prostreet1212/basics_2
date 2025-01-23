import 'package:basics_2/theme15/lesson123/bloc_observable.dart';
import 'package:basics_2/theme15/lesson123/ui/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage=await HydratedStorage.build(
      storageDirectory: await getTemporaryDirectory());

//HydratedBloc.storage=storage;
  //новая реализация
  Bloc.observer = CharacterBlocObservable();
  runApp(
    const MyApp(),
  );
  /*BlocOverrides.runZoned(()=>runApp(
    const MyApp(),
  ),
  blocObserver: CharacterBlocObservable());*/

}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rick and Morty',
      theme:  ThemeData(
        useMaterial3: false,
      brightness: Brightness.light,
      primaryColor: Colors.black,
      fontFamily: 'Georgia',
      textTheme: const TextTheme(
        displayLarge: TextStyle(
            fontSize: 50, fontWeight: FontWeight.bold, color: Colors.white),
        displayMedium: TextStyle(
            fontSize: 30, fontWeight: FontWeight.w700, color: Colors.white),
        displaySmall: TextStyle(fontSize: 24.0, color: Colors.white),
        bodyMedium: TextStyle(
            fontSize: 16.0, fontWeight: FontWeight.w500, color: Colors.white),
        bodyLarge: TextStyle(
            fontSize: 12.0, fontWeight: FontWeight.w200, color: Colors.white),
        bodySmall: TextStyle(
            fontSize: 11.0, fontWeight: FontWeight.w100, color: Colors.grey),
      ),
      ),
      home: HomePage(title: 'Rick and Morty'),
    );
  }
}
