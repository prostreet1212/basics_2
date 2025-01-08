import 'package:basics_2/theme13/core/usecases/usecase.dart';
import 'package:basics_2/theme13/features/domain/repositories/person_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../core/error/failure.dart';
import '../entities/person_entity.dart';

class GetAllPersons extends UseCase<List<PersonEntity>,PagePersonParams>{
  final PersonRepository personRepository;

  GetAllPersons(this.personRepository);

  Future<Either<Failure, List<PersonEntity>>> call(PagePersonParams params) async {
    return await personRepository.getAllPersons(params.page);
  }
}

class PagePersonParams extends Equatable{
  final int page;


  PagePersonParams({required this.page});

  @override
  List<Object?> get props =>[page];
}
