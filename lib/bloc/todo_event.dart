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

  EditTodo({
    required this.todo,
  });
}

class DeleteTodo extends TodoEvent {
  final Todo todo;

  DeleteTodo({
    required this.todo,
  });
}
