import 'package:flutter/material.dart';

import '../widgets/todo_form_widget.dart';
import '../widgets/todo_table_widget.dart';

class TodoView extends StatelessWidget {
  const TodoView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [TodoForm(), const Expanded(child: TodoTable())]);
  }
}
