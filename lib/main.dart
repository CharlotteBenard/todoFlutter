import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'features/todos/presentation/views/todo_view.dart';

void main() {
  runApp(const ProviderScope(
    child: TodoApp(),
  ));
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: const Text('Todos'),
            ),
            body: const TodoView()),
      ),
    );
  }
}
