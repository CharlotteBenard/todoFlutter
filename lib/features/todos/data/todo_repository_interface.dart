import 'package:repo_bookstore_flutter/features/todos/domain/todo.dart';

abstract class ITodoRepository {
  Future<List<Todo>> getAll();
  Future<Todo?> getOne(String id);
  Future<void> insert(Todo todo);
  Future<void> update(Todo todo);
  Future<void> delete(String id);
}
