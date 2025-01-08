

import 'package:basics_2/theme12/lesson93/model/user.dart';

abstract class UserState {}

class UserEmptyState extends UserState {}

class UserLoadingState extends UserState {}

class UserLoadedState extends UserState {
  List<User> loadedUser;
  UserLoadedState({
    required this.loadedUser,
  });
}

class UserErrorState extends UserState {}