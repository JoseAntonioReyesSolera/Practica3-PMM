import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ManaCostWidget extends StatelessWidget {
  final String manaCost;

  ManaCostWidget({required this.manaCost});

  @override
  Widget build(BuildContext context) {
    // Parseamos el costo de maná y obtenemos las URLs de los símbolos
    final manaSymbols = ManaCostParser.parseManaCost(manaCost);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: manaSymbols.map((url) {
        return Padding(
          padding: const EdgeInsets.all(4.0),
          child: SvgPicture.network(
            url,
            width: 30, // Ajusta el tamaño según lo necesites
            height: 30, // Ajusta el tamaño según lo necesites
          ),
        );
      }).toList(),
    );
  }
}

class ManaCostParser {
  // Método para obtener las URLs de los símbolos de maná
  static List<String> parseManaCost(String manaCost) {
    // Lista para almacenar las URLs de los símbolos de maná
    List<String> manaSymbols = [];

    // Expresión regular para extraer los símbolos o números dentro de los corchetes
    final regex = RegExp(r'\{([^}]+)\}');

    // Buscar todas las coincidencias de los símbolos de maná
    final matches = regex.allMatches(manaCost);

    for (var match in matches) {
      final symbol = match.group(1);

      if (symbol != null) {
        // Si el símbolo es un número, se usa un SVG con el número
        if (RegExp(r'\d').hasMatch(symbol)) {
          manaSymbols.add("https://svgs.scryfall.io/card-symbols/${symbol}.svg");
        }
        // Si el símbolo es una letra (como U, G, etc.), se usa el SVG correspondiente
        else {
          manaSymbols.add("https://svgs.scryfall.io/card-symbols/${symbol}.svg");
        }
      }
    }

    return manaSymbols;
  }
}
