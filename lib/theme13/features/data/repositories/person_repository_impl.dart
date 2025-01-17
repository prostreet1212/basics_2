import 'package:basics_2/theme13/core/error/exception.dart';
import 'package:basics_2/theme13/core/error/failure.dart';
import 'package:basics_2/theme13/features/data/models/person_model.dart';
import 'package:basics_2/theme13/features/domain/entities/person_entity.dart';
import 'package:basics_2/theme13/features/domain/repositories/person_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../core/platform/network_info.dart';
import '../data_sources/person_local_data_source.dart';
import '../data_sources/person_remote_data_source.dart';

class PersonRepositoryImpl implements PersonRepository {
  final PersonRemoteDataSource remoteDataSource;
  final PersonLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  PersonRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<PersonEntity>>> getAllPersons(int page) async {
    return await _getPersons((){
      return remoteDataSource.getAllPersons(page);
    });
  }

  @override
  Future<Either<Failure, List<PersonEntity>>> searchPerson(String query,int page) async{
    return await _getPersons((){
      return remoteDataSource.searchPerson(query,page);
    }
    );

  }

  Future<Either<Failure,List<PersonModel>>>_getPersons(Future<List<PersonModel>> Function() getPerosns) async {
    if (await networkInfo.isConnected) {
      try{
        final List<PersonModel> remotePerson=await getPerosns();
        localDataSource.personsToCache(remotePerson);
        return Right(remotePerson);
      }on ServerException{
        return Left(ServerFailure());
      }
    }else{
      try{
        final locationPerson=await localDataSource.getLastPersonsFromCache();
        return Right(locationPerson);
      } on CacheException{
        return Left(CacheFailure());
      }
    }
  }

}