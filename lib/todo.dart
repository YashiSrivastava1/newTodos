// class ToDo {
//   String? id;
//   String? todoText;
//   bool isDone;

//   ToDo({
//     required this.id,
//     required this.todoText,
//     this.isDone = false,
//   });

//   static List<ToDo> todoList() {
//     return [
//       ToDo(id: '01', todoText: 'Buy groceries', isDone: true),
//       ToDo(id: '02', todoText: 'Walk the dog', isDone: true),
//       ToDo(id: '03', todoText: 'Finish homework', isDone: false),
//       ToDo(id: '04', todoText: 'Clean the house', isDone: false),
//       ToDo(id: '05', todoText: 'Prepare dinner', isDone: false),
//     ];
//   }
// }

class ToDo {
  final String id;
  final String todoText;
  late final bool isDone;

  ToDo({
    required this.id,
    required this.todoText,
    this.isDone = false,
  });

  factory ToDo.fromJson(Map<String, dynamic> json) {
    return ToDo(
      id: json['id'].toString(),
      todoText: json['task'],
      isDone: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'task': todoText,
      'status': isDone,
    };
  }

  ToDo copyWith({String? id, String? todoText, bool? isDone}) {
    return ToDo(
      id: id ?? this.id,
      todoText: todoText ?? this.todoText,
      isDone: isDone ?? this.isDone,
    );
  }

  static todoList() {}
}
