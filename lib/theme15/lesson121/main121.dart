

import 'package:basics_2/theme15/lesson121/models/location.dart';
import 'package:basics_2/theme15/lesson121/models/user.dart';

void main(){


  User userA=User(name: 'Dima',age: 4,locations: [Location(zipcode: '123456')]);
//print(userA.name);
//print(userA.infoUser());
print(userA.toJson());
}