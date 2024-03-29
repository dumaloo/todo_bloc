class Todo {
  final String name;
  final DateTime createdAt;
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
