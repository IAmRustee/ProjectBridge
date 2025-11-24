import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'word.dart'; // Ensure you have created this file

// 🚨 CRITICAL: REPLACE 'YOUR_LAN_IP' with the IPv4 address you found
// Be aware of IP because you're stupid
// Go watch frieren
const String API_URL = 'http://10.0.2.2/flutter_api/fetch_words.php';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Japanese Dictionary',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const WordListScreen(),
    );
  }
}

class WordListScreen extends StatefulWidget {
  const WordListScreen({super.key});

  @override
  State<WordListScreen> createState() => _WordListScreenState();
}

class _WordListScreenState extends State<WordListScreen> {
  late Future<List<Word>> futureWords;

  @override
  void initState() {
    super.initState();
    futureWords = fetchWords();
  }

  Future<List<Word>> fetchWords() async {
    final response = await http.get(Uri.parse(API_URL));

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((json) => Word.fromJson(json)).toList();
    } else {
      throw Exception(
        'Failed to load words from $API_URL. Status Code: ${response.statusCode}',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Japanese Dictionary (15,000 words)')),
      body: FutureBuilder<List<Word>>(
        future: futureWords,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
                textAlign: TextAlign.center,
              ),
            );
          } else if (snapshot.hasData) {
            final words = snapshot.data!;

            return ListView.builder(
              itemCount: words.length,
              itemBuilder: (context, index) {
                final word = words[index];
                return ListTile(
                  title: Text(
                    word.japanese,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text('${word.romaji}\n${word.english}'),
                  isThreeLine: true,
                );
              },
            );
          } else {
            return const Center(child: Text('No words found.'));
          }
        },
      ),
    );
  }
}
