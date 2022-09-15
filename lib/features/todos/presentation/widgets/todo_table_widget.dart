import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/todo.dart';
import '../viewmodels/todo_viewmodel.dart';

class TodoTable extends ConsumerWidget {
  const TodoTable({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Todo> todos = ref.watch(todoViewModelProvider).todos;
    TodoStatus status = ref.watch(todoViewModelProvider).status;
    final todoViewModel = ref.read(todoViewModelProvider.notifier);
    return Container(
      child: status.isSuccess
          ? DataTable(
              columns: _createTodoTableColumns(),
              rows: _createTodoTableRows(todos, todoViewModel),
            )
          : status.isLoading
              ? const Center(child: CircularProgressIndicator())
              : status.isError
                  ? const Text('Erreur')
                  : const SizedBox(),
    );
  }

  List<DataColumn> _createTodoTableColumns() {
    return [
      const DataColumn(label: Text('ID')),
      const DataColumn(label: Text('Todo')),
      const DataColumn(label: Text('Action')),
    ];
  }

  List<DataRow> _createTodoTableRows(
      List<Todo> todos, TodoViewModel todoViewModel) {
    return todos
        .map((todo) => DataRow(cells: [
              DataCell(Text('#${todo.id}')),
              DataCell(Text(todo.title)),
              DataCell(IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () async {
                  await todoViewModel.removeTodo(todo.id);
                },
              )),
            ]))
        .toList();
  }
}
