import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/blocs.dart';
import '../../../utils/colors.dart';

class GetRandomNumberQuoteButton extends StatelessWidget {
  const GetRandomNumberQuoteButton({
    Key? key,
    required GlobalKey<FormState> formKey,
  })   : _formKey = formKey,
        super(key: key);

  final GlobalKey<FormState> _formKey;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: 40,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      onPressed: () {
        final FormState state = _formKey.currentState!;
        state.reset();
        BlocProvider.of<NumberQuoteBloc>(context)
            .add(const NumberQuoteRandomRequested());
      },
      color: collightYellow,
      child: const Text(
        'Get Random Number Quote',
        style: TextStyle(
          color: colDarkGreen,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
