import 'package:repo_bookstore_flutter/features/todos/data/todo_repository.dart';
import 'package:repo_bookstore_flutter/features/todos/domain/todo.dart';
import 'package:riverpod/riverpod.dart';

import '../../data/todo_repository_interface.dart';

final todoViewModelProvider = StateNotifierProvider<TodoViewModel, TodoState>(
    (ref) => TodoViewModel(todoRepo: ref.watch(todoRepositoryProvider)));

enum TodoStatus { initial, success, error, loading }

extension TodoStatusX on TodoStatus {
  bool get isInitial => this == TodoStatus.initial;
  bool get isSuccess => this == TodoStatus.success;
  bool get isError => this == TodoStatus.error;
  bool get isLoading => this == TodoStatus.loading;
}

class TodoState {
  TodoState({this.status = TodoStatus.initial, this.todos = const []});

  TodoStatus status;
  List<Todo> todos;

  TodoState copyWith({TodoStatus? status, List<Todo>? todos}) {
    return TodoState(
      status: status ?? this.status,
      todos: todos ?? this.todos,
    );
  }
}

class TodoViewModel extends StateNotifier<TodoState> {
  TodoViewModel({required this.todoRepo}) : super(TodoState()) {
    getAllTodos();
  }

  final ITodoRepository todoRepo;

  getAllTodos() async {
    state = state.copyWith(status: TodoStatus.loading);
    final todosList = await todoRepo.getAll();
    state = state.copyWith(status: TodoStatus.success, todos: todosList);
  }

  addTodo(Todo todo) async {
    state = state.copyWith(status: TodoStatus.loading);
    await todoRepo.insert(todo);
    state = state
        .copyWith(status: TodoStatus.success, todos: [...state.todos, todo]);
  }

  removeTodo(String id) async {
    state = state.copyWith(status: TodoStatus.loading);
    await todoRepo.delete(id);
    List<Todo> todosList = state.todos;
    todosList.removeWhere((todo) => todo.id == id);
    state = state.copyWith(status: TodoStatus.success, todos: todosList);
  }
}
