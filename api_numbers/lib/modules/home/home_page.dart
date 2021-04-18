import 'package:flutter/material.dart';

import '../../utils/colors.dart';
import 'widgets/favorite_button.dart';
import 'widgets/get_number_quote_button.dart';
import 'widgets/get_random_number_quote_button.dart';
import 'widgets/number_text_field.dart';
import 'widgets/quote_widget.dart';
import 'widgets/to_favorites_page_button.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController textController;

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: colGreen,
        body: Stack(
          children: [
            const ToFavoritesPageButton(),
            Center(
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const QuoteWidget(),
                      FavoriteButton(textController: textController),
                      const SizedBox(height: 30),
                      NumberTextField(
                        textController: textController,
                        formKey: _formKey,
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GetNumberQuoteButton(
                            formKey: _formKey,
                            textController: textController,
                          ),
                          const SizedBox(width: 20),
                          GetRandomNumberQuoteButton(formKey: _formKey),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
