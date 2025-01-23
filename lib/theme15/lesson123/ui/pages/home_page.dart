import 'package:basics_2/theme15/lesson123/bloc/character_bloc.dart';
import 'package:basics_2/theme15/lesson123/ui/pages/search_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repositories/character_repo.dart';

class HomePage extends StatelessWidget {
  final String title;

   HomePage({super.key, required this.title});
  final repository = CharacterRepo();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        backgroundColor: Colors.black54,
        centerTitle: true,
        title: Text(
          title,
          style: Theme.of(context).textTheme.displaySmall,
        ),
      ),
      body:BlocProvider(
          create: (context)=>CharacterBloc(characterRepo: repository),
      child: Container(
        decoration: BoxDecoration(color: Colors.black87),
          child: SearchPage()),) ,
    );
  }
}
