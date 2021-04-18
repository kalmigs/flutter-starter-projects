import 'package:equatable/equatable.dart';

class NumberQuote extends Equatable {
  const NumberQuote({
    required this.number,
    required this.quote,
  });
  final double number;
  final String quote;

  @override
  List<Object> get props => [number, quote];
}
