import 'package:crud_perpustakaan/insert.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class BookListPage extends StatefulWidget {
  const BookListPage({super.key});

  @override
  _BookListPageState createState() => _BookListPageState();
}

class _BookListPageState extends State<BookListPage> {
  //variabel untuk menyimpan daftar buku
  List<Map<String, dynamic>> books = [];

  @override
  void initState() {
    super.initState();
    fetchBooks();
    // Memanggil fungsi fech data buku
  }

  // Fungsi fetch data buku
  Future<void> fetchBooks() async {
    final response = await Supabase.instance.client.from('books').select();

    setState(() {
      books = List<Map<String, dynamic>>.from(response);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Books List'),
        backgroundColor: Colors.amber[400],
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: fetchBooks,
          ),
        ],
      ),
      body: books.isEmpty
          ? const Center(
              child: CircularProgressIndicator()) //Menampikan loading indicator
          : ListView.builder(
              itemCount: books.length,
              itemBuilder: (context, index) {
                final book = books[index];
                return ListTile(
                    title: Text(book['title'] ?? 'No Title',
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(book['author'] ?? 'Unknown Author',
                            style: TextStyle(
                                fontSize: 13, color: Colors.grey.shade900)),
                        Text(book['description'] ?? 'No Description',
                            style: TextStyle(
                                fontSize: 12, color: Colors.grey.shade800)),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(icon: Icon(Icons.edit), onPressed: () {}),
                        IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              // Delete book
                              IconButton(
                                  icon: Icon(Icons.delete),
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                              title: Text('Delete Book'),
                                              content: Text(
                                                  'Are you sure you want to delete this book?'),
                                              actions: [
                                                TextButton(
                                                  child: Text('Yes'),
                                                  onPressed: () async {
                                                    // await deleteBook(book['id']);
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                              ]);
                                        });
                                  });
                            })
                      ],
                    ));
              },
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightBlue[200],
        foregroundColor: Colors.black,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddBookPage()),
          );
        },
         child: const Icon(Icons.add),
      ),
    );
  }
}
