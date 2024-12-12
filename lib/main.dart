import 'package:flutter/material.dart';
import 'package:scryfall_api/providers/scryfall_provider.dart';
import 'package:scryfall_api/screens/screens.dart';
import 'package:provider/provider.dart';

void main() => runApp(AppState());

class AppState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ScryfallProvider(),
          lazy: false,
        )
      ],
      child: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cartes',
      initialRoute: 'home',
      routes: {
        'home': (BuildContext context) => HomeScreen(),
        'set_cards': (BuildContext context) => SetCardsScreen(setCode: ModalRoute.of(context)?.settings.arguments as String),
      },
      theme: ThemeData.light()
          .copyWith(appBarTheme: const AppBarTheme(color: Colors.indigo)),
    );
  }
}
