import 'package:api_numbers/blocs/blocs.dart';
import 'package:api_numbers/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: colGreen,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: coloffWhite),
            onPressed: () => Navigator.pop(context),
          ),
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(Icons.favorite, color: Colors.redAccent),
              SizedBox(width: 7),
              Text(
                'Favorites',
                style: TextStyle(fontSize: 20, color: coloffWhite),
              ),
            ],
          ),
          elevation: 0,
          backgroundColor: colGreen,
        ),
        body: BlocBuilder<FavoriteCubit, FavoriteState>(
          builder: (context, state) {
            return Column(
              children: [
                if (state.favourites.isNotEmpty)
                  const Divider(color: coloffWhite, thickness: 1, height: 1),
                Expanded(
                  child: ListView.builder(
                    itemCount: state.favourites.length,
                    itemBuilder: (context, i) {
                      return Dismissible(
                        onDismissed: (_) =>
                            BlocProvider.of<FavoriteCubit>(context)
                                .removeFavorite(state.favourites[i]),
                        key: Key(state.favourites[i].quote),
                        background: Container(color: coloffWhite),
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(color: coloffWhite),
                            ),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  state.favourites[i].number.toString(),
                                  style: const TextStyle(
                                    color: coloffWhite,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Text(
                                  state.favourites[i].quote,
                                  style: const TextStyle(
                                    color: coloffWhite,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
