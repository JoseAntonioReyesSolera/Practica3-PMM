import 'package:flutter/material.dart';
import 'package:scryfall_api/providers/scryfall_provider.dart';
import 'package:provider/provider.dart';
import 'package:scryfall_api/screens/details_screen.dart';

class SetCardsScreen extends StatelessWidget {
  final String setCode; // El código del set que seleccionó el usuario.

  SetCardsScreen({required this.setCode});

  @override
  Widget build(BuildContext context) {
    final scryfallProvider = Provider.of<ScryfallProvider>(context);

    // Cargar las cartas del set si no están cargadas
    // Este es un cambio: el método se llama fuera de la construcción de la UI.
    Future<void> loadCards() async {
      if (!scryfallProvider.cardsBySet.containsKey(setCode)) {
        await scryfallProvider.getCardsBySet(setCode);
      }
    }

    // Iniciar la carga de cartas al renderizar el widget
    loadCards();

    return Scaffold(
      appBar: AppBar(
        title: Text('Cartas del Set $setCode'),
      ),
      body: Consumer<ScryfallProvider>(
        builder: (context, provider, child) {
          // Verificar si las cartas están cargadas
          if (!provider.cardsBySet.containsKey(setCode)) {
            return Center(child: CircularProgressIndicator());
          }

          // Obtener las cartas del set
          final cards = provider.cardsBySet[setCode];

           return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 0.7,
            ),
            itemCount: cards?.length ?? 0,
            itemBuilder: (context, index) {
              final card = cards![index];
              return GestureDetector(
                onTap: () {
                  // Navegar a la pantalla de detalles con la carta seleccionada
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailsScreen(carta: card),
                    ),
                  );
                },
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      Image.network(card.imageUris?.small ?? 'https://example.com/default_image.png'),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          card.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}