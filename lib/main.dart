import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'book_list_page.dart';

Future<void> main() async {
  await Supabase.initialize(
    url: 'https://tzondwyhkjdeqpjtojhj.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InR6b25kd3loa2pkZXFwanRvamhqIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzE3MjY3MDksImV4cCI6MjA0NzMwMjcwOX0.Ijj_35QdPx7qrPTdsvm1Sa6n7JpjFV6xv8o4ClyniBc',
  );
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Digital Library",
      home: BookListPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}