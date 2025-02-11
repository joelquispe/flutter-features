part of 'list_warriors_cubit.dart';

@immutable
sealed class ListWarriorsState {}

final class ListWarriorsInitial extends ListWarriorsState {}

final class ListWarriorsFetchSuccess extends ListWarriorsState {
  final List<WarriorZ> data;
  ListWarriorsFetchSuccess(this.data);
}

final class ListWarriorsFetchFailed extends ListWarriorsState {
  final String message;
  ListWarriorsFetchFailed(this.message);
}

final class ListWarriorsLoading extends ListWarriorsState {}
