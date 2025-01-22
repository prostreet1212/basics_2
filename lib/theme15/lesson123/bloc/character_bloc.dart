import 'package:basics_2/theme15/lesson123/data/repositories/character_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../data/models/character.dart';

part 'character_bloc.freezed.dart';

//part 'character_bloc.g.dart';
part 'character_event.dart';

part 'character_state.dart';

class CharacterBloc extends Bloc<CharacterEvent, CharacterState> {
  final CharacterRepo characterRepo;

  CharacterBloc({required this.characterRepo})
      : super(CharacterState.loading()) {
    on<CharacterEventFetch>((event, emit) async {
      emit(CharacterState.loading());
      try {
        Character _characterLoaded =
            await characterRepo.getCharacter(event.page, event.name);
        emit(CharacterState.loaded(characterLoaded: _characterLoaded));
      } catch (e) {
        emit(CharacterState.error());
      }
    });
  }
}
