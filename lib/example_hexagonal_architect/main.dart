import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_features/example_hexagonal_architect/core/injections.dart';
import 'package:flutter_features/example_hexagonal_architect/features/warriors/presentation/cubits/list_warriors_cubit/list_warriors_cubit.dart';
import 'package:flutter_features/example_hexagonal_architect/features/warriors/presentation/screens/list_warriors_screen.dart';

void main() async{
  setupInjections();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ListWarriorsCubit>(),
      child: MaterialApp(
        title: 'Dragon Ball Api rest',
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Guerreros Z'),
          ),
          body: ListWarriorsScreen(),
        ),
      ),
    );
  }
}
