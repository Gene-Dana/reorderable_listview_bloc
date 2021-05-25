import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reorderable_listview_bloc/cubit/cubit.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Reorderable Listview',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DifficultyLevelsScreen(),
    );
  }
}

class DifficultyLevelsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: BlocProvider(
          create: (_) => DifficultyLevelsCubit(),
          child: Body(),
        ),
      ),
    );
  }
}

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _Name(),
        SizedBox(height: 20),
        IconButton(
            icon: Icon(Icons.add),
            onPressed: () => context.read<DifficultyLevelsCubit>().addLevel()),
        _Levels(),
        SizedBox(height: 20),
        _Submit(),
      ],
    );
  }
}

class _Name extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DifficultyLevelsCubit, DifficultyLevelsState>(
      buildWhen: (previous, current) => previous.name != current.name,
      builder: (context, state) {
        return TextField(
          onChanged: (name) =>
              context.read<DifficultyLevelsCubit>().nameChanged(name),
          decoration: InputDecoration(
            labelText: 'Name',
            helperText: '',
            errorText: state.name.invalid ? 'invalid name' : null,
          ),
        );
      },
    );
  }
}

class _Levels extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DifficultyLevelsCubit, DifficultyLevelsState>(
      builder: (context, state) {
        print('rebuild');
        return Flexible(
          child: ReorderableListView(
            shrinkWrap: true,
            children: state.levels
                .asMap()
                .map((i, lvl) => MapEntry(
                      i,
                      ListTile(
                        key: ValueKey(i),
                        title: TextField(
                          onChanged: (lvl) => context
                              .read<DifficultyLevelsCubit>()
                              .levelChanged(lvl, i),
                          decoration: InputDecoration(
                            labelText: 'Level',
                            helperText: '',
                            errorText: state.levels[i].invalid
                                ? 'invalid level'
                                : null,
                          ),
                        ),
                        trailing: Icon(Icons.menu),
                      ),
                    ))
                .values
                .toList(),
            onReorder: (int oldIndex, int newIndex) => context
                .read<DifficultyLevelsCubit>()
                .orderChanged(oldIndex, newIndex),
          ),
        );
      },
    );
  }
}

class _Submit extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () =>
          context.read<DifficultyLevelsCubit>().submitDifficultyLevel(),
      child: Text('Submit'),
    );
  }
}
