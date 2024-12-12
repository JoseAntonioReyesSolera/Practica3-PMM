import 'package:flutter/material.dart';
import 'package:scryfall_api/models/sets_response.dart' as sets_response;
import 'package:card_swiper/card_swiper.dart';  // Importa el paquete Swiper
import 'package:flutter_svg/flutter_svg.dart';


class CardSwiper extends StatelessWidget {
  final List<sets_response.Set> sets;
  final Function(String) onSetTap;

  CardSwiper({required this.sets, required this.onSetTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: Swiper(
        itemCount: sets.length,
        layout: SwiperLayout.STACK,
        itemWidth: 250,
        itemHeight: 200,
        itemBuilder: (context, index) {
          final set = sets[index];
          return GestureDetector(
            onTap: () => onSetTap(set.code),  // Callback al tocar un set
            child: Card(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              elevation: 4,
              child: Container(
                width: 150,
                child: Column(
                  children: [
                    SvgPicture.network(
                      set.iconSvgUri,
                      width: 100,
                      height: 100,
                    ),
                    Text(
                      set.name,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      set.setType.name,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      set.releasedAt.toString().substring(0,10),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
