class Word {
  final String japanese;
  final String romaji;
  final String english;

  Word({
    required this.japanese,
    required this.romaji,
    required this.english,
  });

  // Factory method to create a Word object from the JSON map
  factory Word.fromJson(Map<String, dynamic> json) {
    return Word(
      // Keys must match the column names from your PHP script: 'japanese', 'romaji', 'english'
      japanese: json['japanese'] as String,
      romaji: json['romaji'] as String,
      english: json['english'] as String,
    );
  }
}