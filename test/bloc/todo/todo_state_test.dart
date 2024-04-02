import 'package:flutter_test/flutter_test.dart';
import 'package:todo_bloc/models/todo_model.dart';
import 'package:todo_bloc/bloc/todo_state.dart';

void main() {
  group('TodoState', () {
    test('toString() returns correct representation', () {
      final currentTime = DateTime(2024, 4, 2, 15, 0);
      final todos = [
        Todo(
          id: currentTime.millisecondsSinceEpoch,
          name: 'Todo 1',
          createdAt: currentTime,
          isCompleted: false,
        ),
        Todo(
          id: currentTime.millisecondsSinceEpoch + 1,
          name: 'Todo 2',
          createdAt: currentTime,
          isCompleted: true,
        ),
      ];
      final state = TodoState(todos);

      expect(
        state.toString(),
        '[Todo { id: ${currentTime.millisecondsSinceEpoch}, name: Todo 1, createdAt: $currentTime, isCompleted: false }, '
        'Todo { id: ${currentTime.millisecondsSinceEpoch + 1}, name: Todo 2, createdAt: $currentTime, isCompleted: true }]',
      );
    });
  });
}
