import 'package:flutter_features/example_hexagonal_architect/features/warriors/data/data_sources/api/warriors_z_api.dart';
import 'package:flutter_features/example_hexagonal_architect/features/warriors/data/repositories/warriors_z_repository_impl.dart';
import 'package:flutter_features/example_hexagonal_architect/features/warriors/data/services/warriors_z_service_impl.dart';
import 'package:flutter_features/example_hexagonal_architect/features/warriors/domain/repositories/warriors_z_repository.dart';
import 'package:flutter_features/example_hexagonal_architect/features/warriors/domain/services/warrios_z_service.dart';
import 'package:flutter_features/example_hexagonal_architect/features/warriors/domain/use_cases/find_all_warriors_z_use_case.dart';
import 'package:flutter_features/example_hexagonal_architect/features/warriors/presentation/cubits/list_warriors_cubit/list_warriors_cubit.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupInjections() async {
  // API
  getIt.registerSingleton<WarriorsZApi>(WarriorsZApi());

  // REPOSITORY
  getIt.registerSingleton<WarriorsZRepository>(
     WarriorsZRepositoryImpl(getIt<WarriorsZApi>()));

  // SERVICE
  getIt.registerSingleton<WarriorsZService>(
      WarriorsZServiceImpl(getIt<WarriorsZRepository>()));

   // USE CASE
  getIt.registerSingleton<FindAllWarriorsZUseCase>(
      FindAllWarriorsZUseCase(getIt<WarriorsZService>()));

  // CUBIT
  getIt.registerFactory(
      () => ListWarriorsCubit(getIt<FindAllWarriorsZUseCase>()));
}
