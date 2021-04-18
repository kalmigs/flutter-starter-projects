import 'package:api_numbers/modules/favorites/favorites_page.dart';
import 'package:api_numbers/utils/colors.dart';
import 'package:flutter/material.dart';

class ToFavoritesPageButton extends StatelessWidget {
  const ToFavoritesPageButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: MaterialButton(
        padding: const EdgeInsets.all(20),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => FavoritesPage()),
          );
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(Icons.favorite, color: Colors.redAccent),
            SizedBox(width: 7),
            Text(
              'Favorites',
              style: TextStyle(color: coloffWhite, fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
