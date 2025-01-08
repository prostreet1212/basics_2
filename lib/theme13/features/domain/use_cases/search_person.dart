import 'package:basics_2/theme13/core/usecases/usecase.dart';
import 'package:basics_2/theme13/features/domain/repositories/person_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../core/error/failure.dart';
import '../entities/person_entity.dart';

class SearchPerson extends UseCase<List<PersonEntity>,SearchPersonParams>{
  final PersonRepository personRepository;

  SearchPerson(this.personRepository);

  Future<Either<Failure, List<PersonEntity>>> call(SearchPersonParams params) async {
    return await personRepository.searchPerson(params.query);
  }
}

class SearchPersonParams extends Equatable{
  final String query;

  SearchPersonParams({required this.query});

  @override
  // TODO: implement props
  List<Object?> get props => [query];


}