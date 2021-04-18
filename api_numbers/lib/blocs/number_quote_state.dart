import 'package:equatable/equatable.dart';

import '../data/models/number_quote.dart';

abstract class NumberQuoteState extends Equatable {
  const NumberQuoteState();

  @override
  List<Object> get props => [];
}

class NumberQuoteInitial extends NumberQuoteState {}

class NumberQuoteLoading extends NumberQuoteState {}

class NumberQuoteSuccess extends NumberQuoteState {
  const NumberQuoteSuccess({required this.numberQuote});

  final NumberQuote numberQuote;

  @override
  List<Object> get props => [numberQuote];
}

class NumberQuoteFailure extends NumberQuoteState {}
