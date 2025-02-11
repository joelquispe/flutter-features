


import 'package:flutter_features/example_hexagonal_architect/features/warriors/domain/entities/Warrior_z.dart';

abstract class WarriorsZRepository{
  Future<List<WarriorZ>> findAll();
}