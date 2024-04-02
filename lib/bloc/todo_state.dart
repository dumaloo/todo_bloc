import 'package:todo_bloc/models/todo_model.dart';

class TodoState {
  final List<Todo> todos;

  TodoState(this.todos);

  @override
  String toString() {
    return '${todos.map((todo) => todo.toString()).toList()}';
  }
}
