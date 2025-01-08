import 'dart:developer';

import 'package:basics_2/theme12/lesson93/bloc/user_bloc.dart';
import 'package:basics_2/theme12/lesson93/bloc/user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserList extends StatelessWidget {
  const UserList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserBloc, UserState>(
      listener: (context,state){
        log(state.toString());
        if(state is UserLoadedState){
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Users is loaded'))
          );
        }
      },
      builder: (context, state) {
        if (state is UserEmptyState) {
          return Center(
            child: Text(
              'No data reeived. Please button "Load"',
              style: TextStyle(fontSize: 20),
            ),
          );
        }
        if(state is UserLoadingState){
          return Center(child: CircularProgressIndicator());
        }
        if(state is UserLoadedState){
          return ListView.builder(
              itemCount: state.loadedUser.length,
              itemBuilder: (context, index) {
                return Container(
                  color: index % 2 == 0 ? Colors.white : Colors.blue[50],
                  child: ListTile(
                    leading: Text(
                      'ID: ${state.loadedUser[index].id}',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    title: Column(
                      children: [
                        Text(
                          'My name: ${state.loadedUser[index].name}',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Column(
                          children: [
                            Text(
                              'Email: ${state.loadedUser[index].email}',
                              style: TextStyle(fontStyle: FontStyle.italic),
                            ),
                            Text(
                              'Phone: ${state.loadedUser[index].phone}',
                              style: TextStyle(fontStyle: FontStyle.italic),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              });
        }
        if(state is UserErrorState){
          return Center(
            child: Text('Error fetching users',style: TextStyle(fontSize:  20),),
          );
        }
        return SizedBox.shrink();

      },
    );
  }
}
