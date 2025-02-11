import 'package:dio/dio.dart';
import 'package:flutter_features/example_hexagonal_architect/features/warriors/data/models/warrior_z_model.dart';

class WarriorsZApi{
  final Dio dio = Dio();

  Future<List<WarriorZModel>> findAll() async {
    final response  = await dio.get('https://dragonball-api.com/api/characters');
    final data = List.from(response.data['items']).map((value)=> WarriorZModel.fromMap(value)).toList();
    return data;
  }
}