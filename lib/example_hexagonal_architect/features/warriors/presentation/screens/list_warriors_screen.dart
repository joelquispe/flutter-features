import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_features/example_hexagonal_architect/features/warriors/presentation/cubits/list_warriors_cubit/list_warriors_cubit.dart';

class ListWarriorsScreen extends StatefulWidget {
  const ListWarriorsScreen({super.key});

  @override
  State<ListWarriorsScreen> createState() => _ListWarriorsScreenState();
}

class _ListWarriorsScreenState extends State<ListWarriorsScreen> {
  late final ListWarriorsCubit listWarriorsCubit;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listWarriorsCubit = context.read<ListWarriorsCubit>();
    listWarriorsCubit.findAll();
  }

  @override
  Widget build(BuildContext context) {
    // final listWarriorsCubit = BlocProvider.of<ListWarriorsCubit>(context);
    return BlocBuilder<ListWarriorsCubit, ListWarriorsState>(
        builder: (context, state) {
      if (state is ListWarriorsFetchSuccess) {
        final items = state.data;
        return ListView.separated(
            separatorBuilder: (context, index) {
              return Divider(
                thickness: 1,
                height: 10,
                color: Colors.grey.shade300,
              );
            },
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return ListTile(
                leading: Image.network(
                  item.image,
                  width: 50,
                  fit: BoxFit.contain,
                ),
                title: Text(item.name),
              );
            });
      } else if (state is ListWarriorsFetchFailed) {
        return Center(
          child: Text(state.message),
        );
      }
      return Center(
        child: CircularProgressIndicator(),
      );
    });
  }
}
