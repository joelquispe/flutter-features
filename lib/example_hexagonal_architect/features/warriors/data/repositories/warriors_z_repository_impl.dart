import 'package:flutter_features/example_hexagonal_architect/features/warriors/data/data_sources/api/warriors_z_api.dart';
import 'package:flutter_features/example_hexagonal_architect/features/warriors/domain/entities/Warrior_z.dart';


import 'package:flutter_features/example_hexagonal_architect/features/warriors/domain/repositories/warriors_z_repository.dart';

class WarriorsZRepositoryImpl implements WarriorsZRepository {
  WarriorsZApi api;

  WarriorsZRepositoryImpl(this.api);

  @override
  Future<List<WarriorZ>> findAll() async {
    final response = await api.findAll();
    final data = response
        .map((value) => WarriorZ(
            id: value.id,
            name: value.name,
            ki: value.ki,
            maxKi: value.maxKi,
            race: value.race,
            gender: value.gender,
            description: value.description,
            image: value.image,
            affiliation: value.affiliation))
        .toList();
    return data;
  }
}
