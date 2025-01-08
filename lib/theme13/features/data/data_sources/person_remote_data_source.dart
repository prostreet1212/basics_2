import '../models/person_model.dart';

abstract class PersonRemoteDataSource{
  Future<List<PersonModel>> getAllPersons(int page);
  Future<List<PersonModel>> searchPerson(String query);
}

class PersonRemoteDataSourceImpl implements PersonRemoteDataSource{
  @override
  Future<List<PersonModel>> getAllPersons(int page) {
    // TODO: implement getAllPersons
    throw UnimplementedError();
  }

  @override
  Future<List<PersonModel>> searchPerson(String query) {
    // TODO: implement searchPerson
    throw UnimplementedError();
  }
  
}