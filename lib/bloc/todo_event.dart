import 'package:todo_bloc/models/todo_model.dart';

sealed class TodoEvent {}

class AddTodo extends TodoEvent {
  final String name;

  AddTodo({
    required this.name,
  });

  @override
  String toString() {
    return 'AddTodo { name: $name }';
  }
}

class EditTodo extends TodoEvent {
  final Todo todo;
  final String newName;
  final DateTime newCreatedAt;

  EditTodo({
    required this.todo,
    required this.newName,
    required this.newCreatedAt,
  });

  @override
  String toString() {
    return 'EditTodo { todo: $todo, newName: $newName, newCreatedAt: $newCreatedAt }';
  }
}

class DeleteTodo extends TodoEvent {
  final Todo todo;

  DeleteTodo({
    required this.todo,
  });

  @override
  String toString() {
    return 'DeleteTodo { todo: $todo }';
  }
}

class ToggleTodoCompletion extends TodoEvent {
  final Todo todo;
  final bool isCompleted;
  ToggleTodoCompletion({required this.todo, required this.isCompleted});

  @override
  String toString() {
    return 'ToggleTodoCompletion { todo: $todo, isCompleted: $isCompleted }';
  }
}

class LoadTodos extends TodoEvent {
  @override
  String toString() => 'LoadTodos';
}
