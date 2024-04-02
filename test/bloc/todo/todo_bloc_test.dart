import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mockito/mockito.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todo_bloc/bloc/todo_bloc.dart';
import 'package:todo_bloc/bloc/todo_event.dart';
import 'package:todo_bloc/bloc/todo_state.dart';
import 'package:todo_bloc/models/todo_model.dart';

class MockTodoBloc extends Mock implements TodoBloc {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('TodoBloc', () {
    late TodoBloc todoBloc;
    late Todo initialTodo;

    setUpAll(() async {
      // Get the application documents directory
      final appDocumentDir = await getTemporaryDirectory();

      // Initialize Hive with a custom path
      await Hive.initFlutter(appDocumentDir.path);

      // Register Hive adapter and open box
      Hive.registerAdapter(TodoAdapter());
      await Hive.openBox<Todo>('todolist');
    });

    setUp(() {
      initialTodo = Todo(
        id: DateTime.now().millisecondsSinceEpoch,
        name: 'Test Todo',
        createdAt: DateTime.now(),
      );

      todoBloc = TodoBloc();
    });

    tearDown(() {
      todoBloc.close();
    });

    test('Initial state is TodoState with empty todo list', () {
      expect(todoBloc.state, TodoState([]));
    });

    test('Emits TodoState with added todo when AddTodo event is added', () {
      final expectedState = TodoState([initialTodo]);

      todoBloc.add(AddTodo(name: 'Test Todo'));

      expectLater(todoBloc.stream, emitsInOrder([expectedState]));
    });

    test('Emits TodoState with deleted todo when DeleteTodo event is added',
        () {
      final expectedState = TodoState([]);

      todoBloc.add(DeleteTodo(todo: initialTodo));

      expectLater(todoBloc.stream, emitsInOrder([expectedState]));
    });

    test('Emits TodoState with edited todo when EditTodo event is added', () {
      final updatedTodo = initialTodo.copyWith(name: 'Updated Todo');
      final expectedState = TodoState([updatedTodo]);

      todoBloc.add(EditTodo(
        todo: initialTodo,
        newName: 'Updated Todo',
        newCreatedAt: DateTime.now(),
      ));

      expectLater(todoBloc.stream, emitsInOrder([expectedState]));
    });

    test('Emits TodoState with toggled todo completion', () {
      final toggledTodo = initialTodo.copyWith(isCompleted: true);
      final expectedState = TodoState([toggledTodo]);

      todoBloc.add(ToggleTodoCompletion(
        todo: initialTodo,
        isCompleted: true,
      ));

      expectLater(todoBloc.stream, emitsInOrder([expectedState]));
    });

    test('Emits TodoState with all todos when LoadTodos event is added', () {
      final expectedState = TodoState([initialTodo]);

      todoBloc.add(LoadTodos());

      expectLater(todoBloc.stream, emitsInOrder([expectedState]));
    });
  });
}
