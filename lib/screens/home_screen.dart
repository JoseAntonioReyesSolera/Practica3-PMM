import 'package:flutter/material.dart';
import 'package:scryfall_api/providers/scryfall_provider.dart';
import 'package:scryfall_api/widgets/widgets.dart';
import 'package:provider/provider.dart';
import 'set_carts_screen.dart';  // Importa la pantalla de cartas

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final scryfallProvider = Provider.of<ScryfallProvider>(context);

    // Asegúrate de que los sets se hayan cargado
    if (scryfallProvider.availableSets.isEmpty) {
      return Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sets de Scryfall'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              // Usamos CardSwiper para mostrar los sets
              CardSwiper(
                sets: scryfallProvider.availableSets,
                onSetTap: (setCode) {
                  // Navegar a la pantalla de cartas del set
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SetCardsScreen(setCode: setCode),
                    ),
                  );
                },
              ),
              SizedBox(height: 100),
            // Slider de cartas aleatorias
            RandomCardSlider(cards: scryfallProvider.randomCards),
            ],
          ),
        ),
      ),
    );
  }
}
