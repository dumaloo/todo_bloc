import 'package:todo_bloc/models/todo_model.dart';

sealed class TodoEvent {}

class AddTodo extends TodoEvent {
  final String name;

  AddTodo({
    required this.name,
  });
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
}

class DeleteTodo extends TodoEvent {
  final Todo todo;

  DeleteTodo({
    required this.todo,
  });
}

class ToggleTodoCompletion extends TodoEvent {
  final Todo todo;
  final bool isCompleted;
  ToggleTodoCompletion({required this.todo, required this.isCompleted});
}
