void _translate() {
  final jaText = inputController.text;

  // 1. Check for empty input
  if (jaText.trim().isEmpty) {
    _showSnackBar('Please enter text to translate.');
    setState(() => translatedText = topPlaceholder);
    return;
  }

  //"Translating" message
  setState(() => translatedText = 'Translating...');

  // 2 Define the API endpoint
  final url = Uri.parse('https://translate.argosopentech.com/translate');

  // 3. Create the JSON payload (NMT algorithm)
  final payload = jsonEncode({
    'q': jaText, 
    'source': 'ja', // Source Language: Japanese
    'target': 'en', // Target Language: English
    'format': 'text'
  });

  // 4. Send the HTTP POST request
  http.post(
    url,
    headers: {'Content-Type': 'application/json'},
    body: payload,
  ).then((response) {
    // 5. Processing the response
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      // Extract the result from the server's JSON response
      setState(() => translatedText = data['translatedText'] ?? 'Error parsing result.');
    } else {
      setState(() => translatedText = 'Translation Failed. Status: ${response.statusCode}');
    }
  }).catchError((e) {
    // 6. Handle network errors
    setState(() => translatedText = 'Network Error: Cannot reach translation service. Check your internet connection.');
  });
}