import 'package:basics_2/theme15/lesson123/data/repositories/character_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../data/models/character.dart';

part 'character_bloc.freezed.dart';
part 'character_bloc.g.dart';
part 'character_event.dart';

part 'character_state.dart';

class CharacterBloc extends HydratedBloc<CharacterEvent, CharacterState> {
  final CharacterRepo characterRepo;

  CharacterBloc({required this.characterRepo})
      : super(CharacterState.loading()) {
    on<CharacterEventFetch>((event, emit) async {
      emit(CharacterState.loading());
      try {

        Character _characterLoaded =
            await characterRepo.getCharacter(event.page, event.name).timeout(Duration(seconds: 5));
        emit(CharacterState.loaded(characterLoaded: _characterLoaded));
      } catch (e) {
        emit(CharacterState.error());
        rethrow;
      }
    });
  }

  @override
  CharacterState? fromJson(Map<String, dynamic> json) {
   return CharacterState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(CharacterState state) {
    return state.toJson();
  }
}
