import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/data.dart';
import '../data/models/number_quote.dart';
import 'blocs.dart';

class NumberQuoteBloc extends Bloc<NumberQuoteEvent, NumberQuoteState> {
  NumberQuoteBloc({required NumbersRepository repo})
      : _repo = repo,
        super(NumberQuoteInitial());

  final NumbersRepository _repo;

  @override
  Stream<NumberQuoteState> mapEventToState(NumberQuoteEvent event) async* {
    if (event is NumberQuoteRequested) {
      yield* _mapNumberQuoteRequestedToState(event);
    } else if (event is NumberQuoteRandomRequested) {
      yield* _mapNumberQuoteRandomRequestedToState(event);
    }
  }

  Stream<NumberQuoteState> _mapNumberQuoteRequestedToState(
      NumberQuoteRequested event) async* {
    yield NumberQuoteLoading();
    try {
      final NumberQuote numberQuote = await _repo.getNumberQuote(event.number);
      yield NumberQuoteSuccess(numberQuote: numberQuote);
    } catch (e) {
      NumberQuoteFailure();
    }
  }

  Stream<NumberQuoteState> _mapNumberQuoteRandomRequestedToState(
      NumberQuoteRandomRequested event) async* {
    yield NumberQuoteLoading();
    try {
      final NumberQuote numberQuote = await _repo.getRandomNumberQuote();
      yield NumberQuoteSuccess(numberQuote: numberQuote);
    } catch (e) {
      NumberQuoteFailure();
    }
  }
}
