

import 'package:basics_2/theme13/common/app_colors.dart';
import 'package:basics_2/theme13/features/presentation/bloc/person_list_cubit/person_list_cubit.dart';
import 'package:basics_2/theme13/features/presentation/bloc/search_bloc/search_bloc.dart';
import 'package:basics_2/theme13/features/presentation/pages/home_page.dart';
import 'package:basics_2/theme13/locator_service.dart' as di;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'locator_service.dart';


void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PersonListCubit>(create: (context)=>sl<PersonListCubit>()..loadPerson()),
        BlocProvider<PersonSearchBloc>(create: (context)=>sl<PersonSearchBloc>()),
      ],
      child: MaterialApp(
        theme: ThemeData.dark().copyWith(
          useMaterial3: false,
          colorScheme: ColorScheme.dark(
            surface:AppColors.mainBackground,
          ),
        scaffoldBackgroundColor: AppColors.greyColor),
        home:  HomePage(),
      ),
    );
  }
}


