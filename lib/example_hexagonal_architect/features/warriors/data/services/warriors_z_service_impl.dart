

import 'package:flutter_features/example_hexagonal_architect/features/warriors/domain/entities/Warrior_z.dart';
import 'package:flutter_features/example_hexagonal_architect/features/warriors/domain/repositories/warriors_z_repository.dart';
import 'package:flutter_features/example_hexagonal_architect/features/warriors/domain/services/warrios_z_service.dart';

class WarriorsZServiceImpl implements WarriorsZService{
  WarriorsZRepository repository;

  WarriorsZServiceImpl(this.repository);
  
  @override
  Future<List<WarriorZ>> findAll()async {
    return repository.findAll();
  }

}