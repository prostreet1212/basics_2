
import 'package:basics_2/theme12/lesson93/model/user.dart';
import 'package:basics_2/theme12/lesson93/services/user_api_provider.dart';

class UserRepository{
  final UserProvider _userProvider=UserProvider();
  Future<List<User>>getAllUsers()=>_userProvider.getUsers();
}