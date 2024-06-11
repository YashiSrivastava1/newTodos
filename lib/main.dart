import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/services.dart';
import 'package:new_todo/supabaseHandler.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'home.dart';
import 'splashScreen.dart';
import 'package:supabase/supabase.dart';

void main() {
  Supabase.initialize(url: SupabaseHandler.supabaseURL, anonKey: SupabaseHandler.supabaseKey);
  runApp(ProviderScope(child: MyApp()));
}

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => SplashScreen(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => Home(),
    ),
  ],
);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'ToDo App',
      routerDelegate: router.routerDelegate,
      routeInformationParser: router.routeInformationParser,
      routeInformationProvider: router.routeInformationProvider,
    );
  }
}


// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'ToDo App',
//       theme: ThemeData(
//        // primarySwatch:  const Color.fromARGB(229, 0, 0, 0),
//       ),
//       home: Home(
        
//       ),
//     );



// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       title: 'TodoApp',
//       home: HomePage(),
//     );
//   }
// }

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   final _future = Supabase.instance.client
//       .from('todoTable')
//       .select();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: FutureBuilder(
//         future: _future,
//         builder: (context, snapshot) {
//           if (!snapshot.hasData) {
//             return const Center(child: CircularProgressIndicator());
//           }
//           final todoTable = snapshot.data!;
//           return ListView.builder(
//             itemCount: todoTable.length,
//             itemBuilder: ((context, index) {
//               final country = todoTable[index];
//               return ListTile(
//                 title: Text(todoTable['name']),
//               );
//             }),
//           );
//         },
//       ),
//     );
//   }
// }
