import 'dart:convert';

import 'package:basics_2/theme13/core/error/exception.dart';

import '../models/person_model.dart';
import 'package:http/http.dart' as http;

abstract class PersonRemoteDataSource{
  Future<List<PersonModel>> getAllPersons(int page);
  Future<List<PersonModel>> searchPerson(String query,int page);
}

class PersonRemoteDataSourceImpl implements PersonRemoteDataSource{
  final http.Client client;

  PersonRemoteDataSourceImpl({required this.client});

  @override
  Future<List<PersonModel>> getAllPersons(int page)async {
    return _getPersonFromUrl('https://rickandmortyapi.com/api/character/?page=$page');
  }

  @override
  Future<List<PersonModel>> searchPerson(String query,int page) async{
   return _getPersonFromUrl('https://rickandmortyapi.com/api/character/?name=$query&page=$page');
  }

  Future<List<PersonModel>>_getPersonFromUrl(String url)async{
    print(url);
  //  try{
      final response=await client.get(
          Uri.parse(url),
          headers:{'Content-Type': 'application/json'} );
      if(response.statusCode==200){
        final persons=json.decode(response.body);
        int pages=persons['info']['pages'];
        return (persons['results'] as List).map((person)
        {
          //var p=PersonModel.fromJson(person);
          var p=PersonModel.fromJsonWithPages(person,pages);
          return p;
        }
        ).toList();
      }else{
        throw ServerException();
      }
 /*   }catch(e){
      throw ServerException();
    }*/

  }
  
}