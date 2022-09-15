import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../domain/todo.dart';
import '../viewmodels/todo_viewmodel.dart';

class TodoForm extends ConsumerWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _titleFieldController = TextEditingController();
  final TextEditingController _yearFieldController = TextEditingController();

  TodoForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Form(
      key: _formKey,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              controller: _titleFieldController,
              decoration: const InputDecoration(
                labelText: 'Titre',
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez indiquer un titre';
                }
                return null;
              },
            ),
            Container(
                margin: const EdgeInsets.only(top: 10.0),
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await ref.read(todoViewModelProvider.notifier).addTodo(
                          Todo(const Uuid().v1(), _titleFieldController.text));
                      _titleFieldController.clear();
                      _yearFieldController.clear();
                    }
                  },
                  child: const Text('Ajouter le todo'),
                )),
          ],
        ),
      ),
    );
  }
}
