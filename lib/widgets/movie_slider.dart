import 'package:flutter/material.dart';
import 'package:scryfall_api/models/carts_response.dart';
import 'package:scryfall_api/screens/details_screen.dart';

class RandomCardSlider extends StatelessWidget {
  final List<Carta> cards;

  const RandomCardSlider({Key? key, required this.cards}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (cards.isEmpty) {
      return Container(
        width: double.infinity,
        height: 260,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    return Container(
      width: double.infinity,
      height: 260,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text('Cartas aleatorias',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ),
          SizedBox(height: 5),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: cards.length,
              itemBuilder: (_, int index) => _CardPoster(card: cards[index]),
            ),
          )
        ],
      ),
    );
  }
}

class _CardPoster extends StatelessWidget {
  final Carta card;

  const _CardPoster({Key? key, required this.card}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      height: 190,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              // Navegar a la pantalla de detalles
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailsScreen(carta: card),
                ),
              );
            },
              child: FadeInImage(
                placeholder: AssetImage('assets/no-image.jpg'),
                image: NetworkImage(card.imageUris?.normal ?? ''),
                width: 130,
                height: 180,
              ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            card.name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
