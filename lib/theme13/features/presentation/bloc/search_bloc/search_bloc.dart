import 'dart:async';

import 'package:basics_2/theme13/features/domain/use_cases/search_person.dart';
import 'package:basics_2/theme13/features/presentation/bloc/search_bloc/search_event.dart';
import 'package:basics_2/theme13/features/presentation/bloc/search_bloc/search_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/error/failure.dart';
import '../../../domain/entities/person_entity.dart';

const SERVER_FAILURE_MESSAGE = 'Server Failure';
const CACHED_FAILURE_MESSAGE = 'Cache Failure';

class PersonSearchBloc extends Bloc<PersonSearchEvent, PersonSearchState> {
  SearchPerson searchPerson;

  PersonSearchBloc({required this.searchPerson}) : super(PersonSearchEmpty()) {
    on<SearchPersons>(_onEvent);
  }

  int page = 1;
  int pageCount=0;

  FutureOr<void> _onEvent(
      SearchPersons event, Emitter<PersonSearchState> emit) async {

    var oldPerson = <PersonEntity>[];
    if(pageCount==0||page<=pageCount){
      if (state is PersonSearchLoading) return;
      if (state is PersonSearchLoaded) {
        pageCount=(state as PersonSearchLoaded).persons[0].pages!;
        oldPerson = (state as PersonSearchLoaded).persons;
      }
      emit(PersonSearchLoading(oldPerson, isFirstFetch: page == 1));

      final failureOrPerson = await searchPerson(
          SearchPersonParams(query: event.personQuery, page: page));
      failureOrPerson.fold(
              (failure) =>
              emit(PersonSearchError(message: _mapFailureToMessage(failure))),
              (person) {
            page++;
            final persons = (state as PersonSearchLoading).oldPersonsList;
            persons.addAll(person);
            emit(PersonSearchLoaded(persons: persons));
          });
    }else{
      return;
    }


  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHED_FAILURE_MESSAGE;
      default:
        return 'Unexpected Error';
    }
  }
}
