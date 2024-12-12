import 'dart:convert';


class TodoCartas {
  final List<Carta> data;

  TodoCartas({required this.data});

  factory TodoCartas.fromRawJson(String str) {
    final jsonData = json.decode(str);
    return TodoCartas(
      data: List<Carta>.from(jsonData["data"].map((x) => Carta.fromJson(x))),
    );
  }
}

class Carta {
  final String name;
  final String? typeLine;
  final ImageUris? imageUris;
  final String manaCost;
  final String oracleText;
  final String? power;
  final String? toughness;
  final String? setName;

  Carta({
    required this.name,
    this.typeLine,
    this.imageUris,
    required this.manaCost,
    required this.oracleText,
    this.power,
    this.toughness,
    this.setName,
  });

  factory Carta.fromJson(Map<String, dynamic> json) => Carta(
    name: json["name"],
    typeLine: json["type_line"],
    imageUris: json["image_uris"] != null ? ImageUris.fromJson(json["image_uris"]) : null,
    manaCost: json["mana_cost"],
    oracleText: json["oracle_text"], 
    power: json["power"],
    toughness: json["toughness"],
    setName: json["set_name"],
  );
}

class ImageUris {
  final String normal;
  final String small;

  ImageUris({
    required this.normal,
    required this.small,
  });

  factory ImageUris.fromJson(Map<String, dynamic> json) => ImageUris(
    normal: json["normal"],
    small: json["small"],
  );
}
