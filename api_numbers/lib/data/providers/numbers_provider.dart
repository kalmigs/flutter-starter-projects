import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/number_quote.dart';

class NumbersProvider {
  NumbersProvider({http.Client? client}) : _client = client ?? http.Client();

  final http.Client _client;

  Future<NumberQuote> getNumberQuote(double number) async {
    final request = Uri.http('numbersapi.com', '/$number', {'json': ''});
    final response = await _client.get(request);
    if (response.statusCode != 200) throw Exception('Number quote not found.');
    final json = jsonDecode(response.body);
    final NumberQuote numberQuote = NumberQuote(
      number: number,
      quote: json['text'] as String,
    );
    return numberQuote;
  }

  Future<NumberQuote> getRandomNumberQuote() async {
    final request = Uri.http('numbersapi.com', '/random', {'json': ''});
    final response = await _client.get(request);
    if (response.statusCode != 200) throw Exception('Number quote not found.');
    final json = jsonDecode(response.body);
    final NumberQuote numberQuote = NumberQuote(
      number: json['number'] as double,
      quote: json['text'] as String,
    );
    return numberQuote;
  }
}
