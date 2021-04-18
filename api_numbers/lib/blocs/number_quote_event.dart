import 'package:equatable/equatable.dart';

abstract class NumberQuoteEvent extends Equatable {
  const NumberQuoteEvent();
}

class NumberQuoteRequested extends NumberQuoteEvent {
  const NumberQuoteRequested({required this.number});

  final double number;

  @override
  List<Object> get props => [number];
}

class NumberQuoteRandomRequested extends NumberQuoteEvent {
  const NumberQuoteRandomRequested();

  @override
  List<Object> get props => [];
}
