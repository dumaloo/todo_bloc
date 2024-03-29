import 'package:hive/hive.dart';

part 'todo_model.g.dart';

@HiveType(typeId: 0)
class Todo {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final DateTime createdAt;

  @HiveField(2)
  bool isCompleted;

  Todo({
    required this.name,
    required this.createdAt,
    this.isCompleted = false,
  });

  Todo copyWith({String? name, DateTime? createdAt, bool? isCompleted}) {
    return Todo(
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  @override
  String toString() {
    return 'Todo:\n'
        '  name: $name\n'
        '  createdAt: $createdAt';
  }
}
