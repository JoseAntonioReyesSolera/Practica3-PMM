import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:scryfall_api/models/carts_response.dart' as carts_response;
import 'package:scryfall_api/models/sets_response.dart' as sets_response;
/// Provider para interactuar con la API de Scryfall.
///
/// Permite obtener los sets disponibles y las cartas de un set específico.
/// Notifica a los widgets cuando los datos cambian.
class ScryfallProvider extends ChangeNotifier {
  final String _baseUrl = 'api.scryfall.com';

  /// Lista de sets disponibles obtenidos desde la API.
  List<sets_response.Set> availableSets = [];

  /// Mapa que almacena las cartas agrupadas por el código del set.
  Map<String, List<carts_response.Carta>> cardsBySet = {};

  /// Constructor que inicializa el proveedor y carga los sets disponibles.
  ScryfallProvider() {
    getAvailableSets();
    loadRandomCards();
  }

  /// Obtiene los sets disponibles desde la API de Scryfall.
  Future<void> getAvailableSets() async {
    final url = Uri.https(_baseUrl, '/sets');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final setsResponse = sets_response.TodoSets.fromJson(json.decode(response.body));
        availableSets = setsResponse.data;
        notifyListeners();
      } else {
        throw Exception('Error al obtener los sets disponibles.');
      }
    } catch (e) {
      print('Error al obtener los sets disponibles: $e');
    }
  }

  /// Obtiene las cartas de un set específico.
  ///
  /// Si ya se tienen las cartas del set almacenadas en [cardsBySet],
  /// se omite la llamada a la API.
  Future<void> getCardsBySet(String setCode) async {
    if (cardsBySet.containsKey(setCode)) return;

    final url = Uri.https(_baseUrl, '/cards/search', {
      'q': 'set:$setCode',
    });
    print(url);
    try {
      final response = await http.get(url);
      print(response.body); // Ver contenido de la respuesta


      if (response.statusCode == 200) {
        // Verificar si la respuesta tiene contenido
        final body = response.body;
        if (body.isEmpty) {
          print('Respuesta vacía del set $setCode');
          return;
        }

        // Intentar deserializar la respuesta
        final cardsResponse = carts_response.TodoCartas.fromRawJson(body);

        cardsBySet[setCode] = cardsResponse.data;
        notifyListeners();
      } else {
        throw Exception('Error al obtener las cartas del set: $setCode.');
      }
    } catch (e) {
      print('Error al obtener las cartas del set $setCode: $e');
    }
  }
   /// Lista de cartas aleatorias.
  List<carts_response.Carta> randomCards = [];

  /// Obtiene una carta aleatoria desde la API y la añade a la lista de cartas aleatorias.
  Future<void> getRandomCard() async {
    final url = Uri.https(_baseUrl, '/cards/random');
    print(url);

    try {
      final response = await http.get(url);
      print(response.body.toString);

      if (response.statusCode == 200) {
        final card = carts_response.Carta.fromJson(json.decode(response.body));
        randomCards.add(card);
        notifyListeners();
      } else {
        throw Exception('Error al obtener una carta aleatoria.');
      }
    } catch (e) {
      print('Error al obtener una carta aleatoria: $e');
    }
  }

  /// Carga varias cartas aleatorias al iniciar.
  Future<void> loadRandomCards({int count = 50}) async {
    randomCards.clear(); // Limpiar las cartas anteriores
    for (int i = 0; i < count; i++) {
      await getRandomCard();
    }
  }
}
