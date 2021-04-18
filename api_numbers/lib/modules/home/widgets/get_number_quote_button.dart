import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/blocs.dart';
import '../../../utils/colors.dart';

class GetNumberQuoteButton extends StatefulWidget {
  const GetNumberQuoteButton({
    Key? key,
    required GlobalKey<FormState> formKey,
    required this.textController,
  })   : _formKey = formKey,
        super(key: key);

  final GlobalKey<FormState> _formKey;
  final TextEditingController textController;

  @override
  _GetNumberQuoteButtonState createState() => _GetNumberQuoteButtonState();
}

class _GetNumberQuoteButtonState extends State<GetNumberQuoteButton> {
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: 40,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      onPressed: () {
        final FormState state = widget._formKey.currentState!;
        if (state.validate()) {
          state.save();
          final double number =
              double.tryParse(widget.textController.text) ?? 1.0;
          BlocProvider.of<NumberQuoteBloc>(context)
              .add(NumberQuoteRequested(number: number));
        }
      },
      color: collightYellow,
      child: const Text(
        'Get Number Quote',
        style: TextStyle(
          color: colDarkGreen,
          fontWeight: FontWeight.bold,
        ),
      ),
      // ),
    );
  }
}
