import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/blocs.dart';
import '../../../utils/colors.dart';

class QuoteWidget extends StatelessWidget {
  const QuoteWidget({Key? key}) : super(key: key);

  static const TextStyle styleQuote =
      TextStyle(color: coloffWhite, fontSize: 22);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: BlocBuilder<NumberQuoteBloc, NumberQuoteState>(
        builder: (_, state) {
          if (state is NumberQuoteInitial) {
            return const SelectableText(
              'Welcome to Numbers API',
              textAlign: TextAlign.center,
              style: styleQuote,
            );
          } else if (state is NumberQuoteLoading) {
            return const SelectableText(
              'Loading...',
              textAlign: TextAlign.center,
              style: styleQuote,
            );
          } else if (state is NumberQuoteSuccess) {
            return SelectableText(
              state.numberQuote.quote,
              textAlign: TextAlign.center,
              style: styleQuote,
            );
          }

          // Failure
          return const SelectableText(
            'Something went wrong',
            textAlign: TextAlign.center,
            style: styleQuote,
          );
        },
      ),
    );
  }
}
