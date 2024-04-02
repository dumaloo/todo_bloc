import 'package:flutter_test/flutter_test.dart';
import 'package:todo_bloc/bloc/todo_event.dart';
import 'package:todo_bloc/models/todo_model.dart';

void main() {
  group('TodoEvent', () {
    group('AddTodo', () {
      test('toString() returns correct representation', () {
        final event = AddTodo(name: 'New Todo');
        expect(event.toString(), 'AddTodo { name: New Todo }');
      });
    });

    group('EditTodo', () {
      test('toString() returns correct representation', () {
        final todo = Todo(
          id: DateTime.now().millisecondsSinceEpoch,
          name: 'Todo',
          createdAt: DateTime.now(),
          isCompleted: false,
        );
        final newCreatedAt = DateTime.now();
        final event = EditTodo(
          todo: todo,
          newName: 'Updated Todo',
          newCreatedAt: newCreatedAt,
        );

        expect(
          event.toString(),
          'EditTodo { todo: $todo, newName: Updated Todo, newCreatedAt: $newCreatedAt }',
        );
      });
    });

    group('DeleteTodo', () {
      test('toString() returns correct representation', () {
        final todo = Todo(
            id: DateTime.now().millisecondsSinceEpoch,
            name: 'Todo to delete',
            createdAt: DateTime.now());
        final event = DeleteTodo(todo: todo);
        expect(event.toString(), 'DeleteTodo { todo: $todo }');
      });
    });

    group('ToggleTodoCompletion', () {
      test('toString() returns correct representation', () {
        final todo = Todo(
            id: DateTime.now().millisecondsSinceEpoch,
            name: 'Todo to toggle',
            createdAt: DateTime.now());
        final event = ToggleTodoCompletion(todo: todo, isCompleted: true);
        expect(event.toString(),
            'ToggleTodoCompletion { todo: $todo, isCompleted: true }');
      });
    });

    group('LoadTodos', () {
      test('toString() returns correct representation', () {
        final event = LoadTodos();
        expect(event.toString(), 'LoadTodos');
      });
    });
  });
}
