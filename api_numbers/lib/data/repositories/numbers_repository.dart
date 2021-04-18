import '../models/number_quote.dart';
import '../providers/numbers_provider.dart';

class NumbersRepository {
  NumbersRepository({NumbersProvider? numbersProvider})
      : _provider = numbersProvider ?? NumbersProvider();

  final NumbersProvider _provider;

  Future<NumberQuote> getNumberQuote(double number) async {
    final NumberQuote numberQuote = await _provider.getNumberQuote(number);
    return numberQuote;
  }

  Future<NumberQuote> getRandomNumberQuote() async {
    final NumberQuote numberQuote = await _provider.getRandomNumberQuote();
    return numberQuote;
  }
}
