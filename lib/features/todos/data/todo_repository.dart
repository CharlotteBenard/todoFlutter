import 'package:repo_bookstore_flutter/features/todos/data/todo_repository_interface.dart';
import 'package:repo_bookstore_flutter/features/todos/domain/todo.dart';
import 'package:repo_bookstore_flutter/shared/api/api_repository.dart';
import 'package:repo_bookstore_flutter/shared/api/api_repository_interface.dart';
import 'package:riverpod/riverpod.dart';

final todoRepositoryProvider = Provider<ITodoRepository>(
    (ref) => TodoRepository(apiRepository: ref.watch(apiRepositoryProvider)));

class TodoRepository implements ITodoRepository {
  TodoRepository({required this.apiRepository});

  final IApiRepository apiRepository;

  @override
  Future<List<Todo>> getAll() async {
    final todos = Future.delayed(const Duration(seconds: 1), () async {
      var items = await apiRepository.get('todos');
      return List<Todo>.from(items.data.map((item) => Todo.fromMap(item)));
    });
    return todos;
  }

  @override
  Future<Todo?> getOne(int id) async {
    final todo = Future.delayed(const Duration(seconds: 1), () async {
      var item = await apiRepository.get('todos/$id');
      return item.data != null ? Todo.fromMap(item.data) : null;
    });
    return todo;
  }

  @override
  Future<void> insert(Todo todo) async {
    await Future.delayed(const Duration(seconds: 1));
    await apiRepository.post('todos', todo.toMap());
  }

  @override
  Future<void> update(Todo todo) async {
    await Future.delayed(const Duration(seconds: 1));
    await apiRepository.put('todos/${todo.id}', todo.toMap());
  }

  @override
  Future<void> delete(String id) async {
    await Future.delayed(const Duration(seconds: 1));
    await apiRepository.delete('todos/$id');
  }
}
