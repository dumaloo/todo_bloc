import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:todo_bloc/bloc/todo_event.dart';
import 'package:todo_bloc/bloc/todo_state.dart';
import 'package:todo_bloc/models/todo_model.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc() : super(TodoState([])) {
    // Add a todo
    on<AddTodo>((event, emit) {
      if (event.name.isEmpty) {
        addError(Exception('Title is empty'));
        return;
      }
      // Create a new todo
      final newTodo = Todo(
        name: event.name,
        createdAt: DateTime.now(),
      );

      // Add the new todo to the list of todos
      emit(TodoState([...state.todos, newTodo]));
    });

    // Delete a todo
    on<DeleteTodo>((event, emit) {
      // Remove the todo from the list of todos
      emit(TodoState(state.todos..remove(event.todo)));
    });

    // Edit a todo
    on<EditTodo>((event, emit) {
      final updatedTodos = state.todos.map((todo) {
        // Check if the todo is the one being edited
        if (todo == event.todo) {
          // If it is, return a new todo with the updated name
          // return event.todo.copyWith(name: event.newName);

          // If it is, return a new todo with the updated name and createdAt
          return (Todo(
            name: event.newName,
            createdAt: event.newCreatedAt,
          ));
        } else {
          // Otherwise, return the original todo
          return todo;
        }
      }).toList();
      emit(TodoState(updatedTodos));
      Logger().i('Edited Todo - $updatedTodos');
    });

    // Toggle todo completion
    on<ToggleTodoCompletion>((event, emit) {
      final updatedTodos = state.todos.map((todo) {
        // Check if the todo is the one being toggled
        if (todo == event.todo) {
          // If it is, return a new todo with the updated completion status
          return todo.copyWith(isCompleted: event.isCompleted);
        } else {
          // Otherwise, return the original todo
          return todo;
        }
      }).toList();
      emit(TodoState(updatedTodos));
    });
  }
  @override
  void onChange(Change<TodoState> change) {
    Logger().i('TodoBloc - $change');
    super.onChange(change);
  }

  @override
  void onEvent(TodoEvent event) {
    Logger().i('TodoBloc - $event');
    super.onEvent(event);
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    Logger().e('TodoBloc - $error');
    super.onError(error, stackTrace);
  }
}
