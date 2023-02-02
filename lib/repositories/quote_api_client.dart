import 'dart:convert';

import 'package:anime_quotes_bloc/models/models.dart';
import 'package:http/http.dart' as http;

class QuoteAPIClient {
  final http.Client client;

  QuoteAPIClient({
    required this.client,
  });

  Future<Quote> fetchQuote() async {
    const url = 'https://animechan.vercel.app/api/random';

    final response = await client.get(Uri.parse(url));

    if (response.statusCode != 200) {
      throw Exception('Error of getting quote');
    }

    return Quote.fromJson(jsonDecode(response.body));
  }
}
