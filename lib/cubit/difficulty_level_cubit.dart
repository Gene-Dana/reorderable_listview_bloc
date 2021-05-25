import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:reorderable_listview_bloc/models/models.dart';

part 'difficulty_level_state.dart';

class DifficultyLevelsCubit extends Cubit<DifficultyLevelsState> {
  DifficultyLevelsCubit() : super(DifficultyLevelsState());

  void addLevel() {
    final List<DiffLevel> levels = List.from(state.levels);

    if (levels.length < 20) {
      levels..add(DiffLevel.pure());

      emit(state.copyWith(
        levels: levels,
        status: Formz.validate(
          List.from(levels)..add(state.name),
        ),
      ));
    }
  }

  void nameChanged(String value) {
    final name = Name.dirty(value);

    emit(state.copyWith(
      name: name,
      status: Formz.validate(
        List.from(state.levels)..add(name),
      ),
    ));
  }

  void levelChanged(String value, int i) {
    final level = DiffLevel.dirty(value);
    List<DiffLevel> levels = List.from(state.levels);
    levels[i] = level;

    emit(state.copyWith(
      levels: levels,
      status: Formz.validate(
        List.from(levels)..add(state.name),
      ),
    ));
  }

  void orderChanged(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) {
      newIndex -= 1;
    }

    final item = state.levels[oldIndex];

    final reorderedList = List.of(state.levels)
      ..removeAt(oldIndex)
      ..insert(newIndex, item);

    emit(state.copyWith(levels: reorderedList));
  }

  void submitDifficultyLevel() {}
}
