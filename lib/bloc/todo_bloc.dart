import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:todo_bloc/bloc/todo_event.dart';
import 'package:todo_bloc/bloc/todo_state.dart';
import 'package:todo_bloc/models/todo_model.dart';
import 'package:hive/hive.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  late Box<Todo> todoBox;

  TodoBloc() : super(TodoState([])) {
    todoBox = Hive.box<Todo>('todolist');

    on<AddTodo>((event, emit) {
      if (event.name.isEmpty) {
        addError(Exception('Title is empty'));
        return;
      }
      final newTodo = Todo(
        id: DateTime.now().millisecondsSinceEpoch, // Unique identifier
        name: event.name,
        createdAt: DateTime.now(),
      );

      todoBox.add(newTodo);
      Logger().i('Added todo: $newTodo');
      emit(TodoState(todoBox.values.toList()));
    });

    on<DeleteTodo>((event, emit) {
      final todoToDelete =
          todoBox.values.firstWhere((todo) => todo.id == event.todo.id);
      todoToDelete.delete();
      Logger().i('Deleted todo: $todoToDelete');
      emit(TodoState(todoBox.values.toList()));
    });

    on<EditTodo>((event, emit) {
      final updatedTodo = event.todo.copyWith(
        name: event.newName,
        createdAt: event.newCreatedAt,
      );
      todoBox.put(event.todo.key, updatedTodo);
      Logger().i('Edited todo: $updatedTodo');
      emit(TodoState(todoBox.values.toList()));
    });

    on<ToggleTodoCompletion>((event, emit) {
      final updatedTodo = event.todo.copyWith(isCompleted: event.isCompleted);
      todoBox.put(event.todo.key, updatedTodo);
      Logger().i('Toggle todo: $updatedTodo');
      emit(TodoState(todoBox.values.toList()));
    });

    on<LoadTodos>((event, emit) {
      emit(TodoState(todoBox.values.toList()));
    });
  }
}
