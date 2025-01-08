import 'package:basics_2/theme12/lesson93/bloc/user_bloc.dart';
import 'package:basics_2/theme12/lesson93/bloc/user_event.dart';
import 'package:basics_2/theme12/lesson93/services/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/internet_cubit.dart';
import '../widgets/action_buttons.dart';
import '../widgets/user_list.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  //final userRepository = UserRepository();

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => UserRepository(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context)
          => UserBloc(userRepository: context.read<UserRepository>())
            ..add(UserLoadEvent()),
          ),
          BlocProvider(create: (context)=>ConnectionCubit())

        ],
        child: Scaffold(
          appBar: AppBar(
            title: BlocBuilder<ConnectionCubit,MyConnectionState>(
                builder: (context,state){
                 return state.connected?
                   Text('User List (В сети)')
                 :Text('User List (Нет соединения с интернет)',
                 style: TextStyle(
                   color: Colors.red
                 ),);
                }),
            centerTitle: true,
          ),
          backgroundColor: Colors.white,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ActionButtons(),
              Expanded(
                child: UserList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
