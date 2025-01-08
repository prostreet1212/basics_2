import 'package:basics_2/theme12/lesson93/bloc/user_bloc.dart';
import 'package:basics_2/theme12/lesson93/bloc/user_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ActionButtons extends StatelessWidget {
  const ActionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    //final UserBloc _userBloc = BlocProvider.of<UserBloc>(context);
    final UserBloc _userBloc =context.read<UserBloc>();
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ElevatedButton(
          child: Text('Load'),
          style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
          onPressed: () {
            _userBloc.add(UserLoadEvent());
          },
        ),
        SizedBox(
          width: 8,
        ),
        ElevatedButton(
          child: Text('Clear'),
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
          onPressed: () {
            _userBloc.add(UserClearEvent());
          },
        ),
      ],
    );
  }
}
