import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter_features/example_hexagonal_architect/features/warriors/domain/entities/Warrior_z.dart';
import 'package:flutter_features/example_hexagonal_architect/features/warriors/domain/use_cases/find_all_warriors_z_use_case.dart';
import 'package:meta/meta.dart';

part 'list_warriors_state.dart';

class ListWarriorsCubit extends Cubit<ListWarriorsState> {
  FindAllWarriorsZUseCase findAllWarriorsZUseCase;

  ListWarriorsCubit(this.findAllWarriorsZUseCase)
      : super(ListWarriorsInitial());

  Future<void> findAll() async {
    emit(ListWarriorsLoading());
    try {
       final response = await findAllWarriorsZUseCase.call();
      emit(ListWarriorsFetchSuccess(response));
    } catch (e) {
      log(e.toString());
      emit(ListWarriorsFetchFailed(e.toString()));
    }
   
  }
}
