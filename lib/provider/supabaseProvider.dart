// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:new_todo/supabaseHandler.dart';
// import 'package:new_todo/todo.dart';
// //import 'supabaseHandler.dart';
// //import 'todo.dart';

// final supabaseProvider = Provider((ref) => SupabaseHandler());

// final todoListProvider =
//     StateNotifierProvider<ToDoListNotifier, List<ToDo>>((ref) {
//   final supabase = ref.watch(supabaseProvider);
//   return ToDoListNotifier(supabase: supabase);
// });

// class ToDoListNotifier extends StateNotifier<List<ToDo>> {
//   final SupabaseHandler supabase;

//   ToDoListNotifier({required this.supabase}) : super([]) {
//     _initializeToDoList();
//   }

//   Future<void> _initializeToDoList() async {
//     final data = await supabase.readData();
//     final todos = data.map((item) => ToDo.fromJson(item)).toList();
//     state = todos;
//   }

//   Future<void> addToDoItem(String taskValue) async {
//     final newTodo = ToDo(
//       id: DateTime.now().millisecondsSinceEpoch.toString(),
//       todoText: taskValue,
//       isDone: false,
//     );
//     state = [...state, newTodo];
//     await supabase.addData(taskValue, false);
//   }

//   Future<void> updateToDoStatus(ToDo todo) async {
//     final updatedTodo = todo.copyWith(isDone: !todo.isDone);
//     state = [
//       for (final item in state)
//         if (item.id == todo.id) updatedTodo else item
//     ];
//     await supabase.updateData(int.parse(todo.id!), updatedTodo.isDone);
//   }

//   Future<void> deleteToDoItem(String id) async {
//     state = state.where((todo) => todo.id != id).toList();
//     await supabase.deleteData(int.parse(id));
//   }
// }
