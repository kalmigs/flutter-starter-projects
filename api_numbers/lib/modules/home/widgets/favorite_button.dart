import 'package:api_numbers/blocs/blocs.dart';
import 'package:api_numbers/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteButton extends StatelessWidget {
  const FavoriteButton({
    Key? key,
    required this.textController,
  }) : super(key: key);

  final TextEditingController textController;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final numberQuoteState = context.watch<NumberQuoteBloc>().state;
        final favoriteState = context.watch<FavoriteCubit>().state;

        final bool isFavorite = favoriteState.favourites.where((f) {
          if (numberQuoteState is NumberQuoteSuccess) {
            return f == numberQuoteState.numberQuote;
          }
          return false;
        }).isNotEmpty;

        return SizedBox(
          height: 50,
          child: Visibility(
            visible: textController.text.isNotEmpty &&
                numberQuoteState is! NumberQuoteLoading,
            child: IconButton(
                icon: Icon(
                  Icons.favorite,
                  color: isFavorite ? Colors.redAccent : colDarkGreen,
                ),
                onPressed: () {
                  if (isFavorite) {
                    if (numberQuoteState is NumberQuoteSuccess) {
                      BlocProvider.of<FavoriteCubit>(context)
                          .removeFavorite(numberQuoteState.numberQuote);
                    }
                  } else {
                    if (numberQuoteState is NumberQuoteSuccess) {
                      BlocProvider.of<FavoriteCubit>(context)
                          .addFavorite(numberQuoteState.numberQuote);
                    }
                  }
                }),
          ),
        );
      },
    );
  }
}
