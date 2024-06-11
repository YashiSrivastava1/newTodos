// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:new_todo/todo.dart';
// import 'package:new_todo/supabaseHandler.dart';

// class ToDoListNotifier extends StateNotifier<List<ToDo>> {
//   ToDoListNotifier() : super([]) {
//     loadToDos();
//   }

//   final SupabaseHandler _supabaseHandler = SupabaseHandler();

//   Future<void> loadToDos() async {
//     final todos = await _supabaseHandler.readData();
//     state = todos.map<ToDo>((todo) => ToDo.fromJson(todo)).toList();
//   }

//   void addToDoItem(String task) async {
//     final newToDo = ToDo(
//       id: DateTime.now().millisecondsSinceEpoch.toString(),
//       todoText: task,
//       isDone: false,
//     );
//     state = [...state, newToDo];
//     await _supabaseHandler.addData(newToDo.todoText, newToDo.isDone);
//     loadToDos();
//   }

//   void updateToDoStatus(ToDo todo) async {
//     final updatedToDo = todo.copyWith(isDone: !todo.isDone);
//     state = [
//       for (final t in state)
//         if (t.id == todo.id) updatedToDo else t
//     ];
//     await _supabaseHandler.updateData(int.parse(todo.id), updatedToDo.isDone);
//   }

//   void deleteToDoItem(String id) async {
//     state = state.where((todo) => todo.id != id).toList();
//     await _supabaseHandler.deleteData(int.parse(id));
//   }
// }

// final todoListProvider = StateNotifierProvider<ToDoListNotifier, List<ToDo>>((ref) {
//   return ToDoListNotifier();
// });
