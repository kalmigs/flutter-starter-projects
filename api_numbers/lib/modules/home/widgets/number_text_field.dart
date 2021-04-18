import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/blocs.dart';
import '../../../utils/colors.dart';

class NumberTextField extends StatelessWidget {
  const NumberTextField({
    Key? key,
    required this.textController,
    required this.formKey,
  }) : super(key: key);

  final TextEditingController textController;
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: BlocListener<NumberQuoteBloc, NumberQuoteState>(
        listener: (_, state) {
          if (state is NumberQuoteSuccess) {
            textController.text = state.numberQuote.number.toString();
          }
        },
        child: TextFormField(
          controller: textController,
          cursorColor: Colors.indigo[200],
          style: const TextStyle(color: coloffWhite),
          onFieldSubmitted: (val) {
            final FormState state = formKey.currentState!;
            if (state.validate()) {
              state.save();
              final double number = double.tryParse(textController.text) ?? 1.0;
              BlocProvider.of<NumberQuoteBloc>(context)
                  .add(NumberQuoteRequested(number: number));
            }
          },
          validator: (val) {
            if (double.tryParse(val ?? '') != null) {
              return null;
            } else {
              return 'Input a valid number';
            }
          },
          decoration: const InputDecoration(
            hintText: 'Input number here...',
            hintStyle: TextStyle(color: coloffWhite),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: colDarkGreen, width: 2),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: coloffWhite, width: 2),
            ),
          ),
        ),
      ),
    );
  }
}
