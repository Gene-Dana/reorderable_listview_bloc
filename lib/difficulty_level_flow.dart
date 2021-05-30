import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:flow_builder/flow_builder.dart';

List<Page> onGenerateProfilePages(DifficultyLevels profile, List<Page> pages) {
  return [
    MaterialPage<void>(
        child: DifficultyLevelsForm(), name: '/difficultylevelsform'),
  ];
}

class DifficultyLevelsFlow extends StatelessWidget {
  const DifficultyLevelsFlow({Key? key}) : super(key: key);

  static Route<DifficultyLevels> route() {
    return MaterialPageRoute(builder: (_) => DifficultyLevelsFlow());
  }

  @override
  Widget build(BuildContext context) {
    return const FlowBuilder<DifficultyLevels>(
      state: DifficultyLevels(),
      onGeneratePages: onGenerateProfilePages,
    );
  }
}

///===================================================================
class DifficultyLevelsForm extends StatefulWidget {
  @override
  State<DifficultyLevelsForm> createState() => _DifficultyLevelsFormState();
}

class _DifficultyLevelsFormState extends State<DifficultyLevelsForm> {
  List<String> items = ['1', '2', '3', '4'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () => context.flow<DifficultyLevels>().complete(),
        ),
        title: const Text('Name'),
      ),
      body: DiffLevelsView(list: items),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
      ),
    );
  }
}

/// This is the stateful widget that the main application instantiates.
class DiffLevelsView extends StatefulWidget {
  const DiffLevelsView({Key? key, required this.list}) : super(key: key);

  final List<String> list;

  @override
  State<DiffLevelsView> createState() => _DiffLevelsViewState();
}

/// This is the private State class that goes with DiffLevelsView.
class _DiffLevelsViewState extends State<DiffLevelsView> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.list.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text('${widget.list[index]}'),
        );
      },
    );
  }
}

class DifficultyLevels extends Equatable {
  const DifficultyLevels({this.levels});

  final List<String>? levels;

  DifficultyLevels copyWith({List<String>? levels}) {
    return DifficultyLevels(
      levels: levels ?? this.levels,
    );
  }

  @override
  List<Object?> get props => [levels];
}
