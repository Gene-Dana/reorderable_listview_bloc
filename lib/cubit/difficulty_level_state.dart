part of 'difficulty_level_cubit.dart';

class DifficultyLevelsState extends Equatable {
  final Name name;
  final List<DiffLevel> levels;
  final FormzStatus status;

  const DifficultyLevelsState({
    this.name = const Name.pure(),
    this.levels = const [DiffLevel.pure()],
    this.status = FormzStatus.pure,
  });

  DifficultyLevelsState copyWith({
    Name name,
    List<DiffLevel> levels,
    FormzStatus status,
  }) {
    return DifficultyLevelsState(
      name: name ?? this.name,
      levels: levels ?? this.levels,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [name, levels, status];
}
