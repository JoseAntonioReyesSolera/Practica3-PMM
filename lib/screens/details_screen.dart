import 'package:flutter/material.dart';
import 'package:scryfall_api/models/carts_response.dart';
import 'package:scryfall_api/widgets/mana_cost_widget.dart';  // Asegúrate de importar la clase Carta

class DetailsScreen extends StatelessWidget {
  final Carta carta; // Recibimos la carta seleccionada como argumento

  DetailsScreen({required this.carta}); // Constructor que recibe la carta

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(carta.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Mostrar la imagen de la carta en grande
            Image.network(carta.imageUris?.normal ?? 'https://example.com/default_image.png'),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  ManaCostWidget(manaCost: carta.manaCost),
                  Text(
                    carta.name,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    carta.typeLine ?? "Tipo no disponible",
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    (carta.power != null && carta.toughness != null)
                    ? "${carta.power} / ${carta.toughness}"
                    : "${carta.power ?? ""}${carta.toughness ?? ""}",
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 10),
                  Text(
                    carta.oracleText,
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
