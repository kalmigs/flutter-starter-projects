import 'package:api_numbers/blocs/blocs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import 'data/data.dart';
import 'modules/home/home_page.dart';
import 'numbers_bloc_observer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = NumbersBlocObserver();

  final NumbersRepository repo = NumbersRepository(
    numbersProvider: NumbersProvider(
      client: http.Client(),
    ),
  );

  runApp(App(repo: repo));
}

class App extends StatelessWidget {
  const App({required this.repo});

  final NumbersRepository repo;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<NumberQuoteBloc>(
            create: (_) => NumberQuoteBloc(repo: repo),
          ),
          BlocProvider<FavoriteCubit>(
            create: (_) => FavoriteCubit(),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Number Quotes API',
          home: HomePage(),
        ));
  }
}
