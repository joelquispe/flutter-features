


import 'package:flutter_features/example_hexagonal_architect/features/warriors/domain/entities/Warrior_z.dart';
import 'package:flutter_features/example_hexagonal_architect/features/warriors/domain/repositories/warriors_z_repository.dart';
import 'package:flutter_features/example_hexagonal_architect/features/warriors/domain/services/warrios_z_service.dart';

class FindAllWarriorsZUseCase {
  WarriorsZService service;

  FindAllWarriorsZUseCase(this.service);

  Future<List<WarriorZ>> call()async{
    return service.findAll();
  }
}