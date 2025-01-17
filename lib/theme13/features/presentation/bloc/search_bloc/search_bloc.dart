import 'dart:async';

import 'package:basics_2/theme13/features/domain/use_cases/search_person.dart';
import 'package:basics_2/theme13/features/presentation/bloc/search_bloc/search_event.dart';
import 'package:basics_2/theme13/features/presentation/bloc/search_bloc/search_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/error/failure.dart';



const SERVER_FAILURE_MESSAGE = 'Server Failure';
const CACHED_FAILURE_MESSAGE = 'Cache Failure';

class PersonSearchBloc extends Bloc<PersonSearchEvent,PersonSearchState> {
  SearchPerson searchPerson;

  PersonSearchBloc({required this.searchPerson}) :super(PersonSearchEmpty()) {
    on<SearchPersons>(_onEvent);
  }
  FutureOr<void> _onEvent(
      SearchPersons event, Emitter<PersonSearchState> emit) async {
    emit(PersonSearchLoading());
    final failureOrPerson =
    await searchPerson(SearchPersonParams(query: event.personQuery,page: event.page));
    emit(failureOrPerson.fold(
            (failure) => PersonSearchError(message: _mapFailureToMessage(failure)),
            (person) => PersonSearchLoaded(persons: person)));
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
