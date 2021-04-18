import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/models/number_quote.dart';
import 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit() : super(FavoriteState(favourites: []));

  void addFavorite(NumberQuote numberQuote) {
    final List<NumberQuote> list = <NumberQuote>[
      ...state.favourites,
      numberQuote,
    ];
    list.sort((a, b) => a.number.compareTo(b.number));
    emit(FavoriteState(
      favourites: list,
    ));
  }

  void removeFavorite(NumberQuote numberQuote) {
    final List<NumberQuote> list = state.favourites;
    list.removeWhere((n) => n == numberQuote);
    list.sort((a, b) => a.number.compareTo(b.number));
    emit(FavoriteState(favourites: state.favourites));
  }
}
