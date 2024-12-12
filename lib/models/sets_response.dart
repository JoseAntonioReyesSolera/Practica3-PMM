import 'dart:convert';

class TodoSets {
    String object;
    bool hasMore;
    List<Set> data;

    TodoSets({
        required this.object,
        required this.hasMore,
        required this.data,
    });

    factory TodoSets.fromRawJson(String str) => TodoSets.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory TodoSets.fromJson(Map<String, dynamic> json) => TodoSets(
        object: json["object"],
        hasMore: json["has_more"],
        data: List<Set>.from(json["data"].map((x) => Set.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "object": object,
        "has_more": hasMore,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Set {
    Object object;
    String id;
    String code;
    String? mtgoCode;
    String? arenaCode;
    int? tcgplayerId;
    String name;
    String uri;
    String scryfallUri;
    String searchUri;
    DateTime releasedAt;
    SetType setType;
    int cardCount;
    bool digital;
    bool nonfoilOnly;
    bool foilOnly;
    String iconSvgUri;
    String? parentSetCode;
    String? blockCode;
    String? block;
    int? printedSize;

    Set({
        required this.object,
        required this.id,
        required this.code,
        this.mtgoCode,
        this.arenaCode,
        this.tcgplayerId,
        required this.name,
        required this.uri,
        required this.scryfallUri,
        required this.searchUri,
        required this.releasedAt,
        required this.setType,
        required this.cardCount,
        required this.digital,
        required this.nonfoilOnly,
        required this.foilOnly,
        required this.iconSvgUri,
        this.parentSetCode,
        this.blockCode,
        this.block,
        this.printedSize,
    });

    factory Set.fromRawJson(String str) => Set.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Set.fromJson(Map<String, dynamic> json) => Set(
        object: objectValues.map[json["object"]]!,
        id: json["id"],
        code: json["code"],
        mtgoCode: json["mtgo_code"],
        arenaCode: json["arena_code"],
        tcgplayerId: json["tcgplayer_id"],
        name: json["name"],
        uri: json["uri"],
        scryfallUri: json["scryfall_uri"],
        searchUri: json["search_uri"],
        releasedAt: DateTime.parse(json["released_at"]),
        setType: setTypeValues.map[json["set_type"]]!,
        cardCount: json["card_count"],
        digital: json["digital"],
        nonfoilOnly: json["nonfoil_only"],
        foilOnly: json["foil_only"],
        iconSvgUri: json["icon_svg_uri"],
        parentSetCode: json["parent_set_code"],
        blockCode: json["block_code"],
        block: json["block"],
        printedSize: json["printed_size"],
    );

    Map<String, dynamic> toJson() => {
        "object": objectValues.reverse[object],
        "id": id,
        "code": code,
        "mtgo_code": mtgoCode,
        "arena_code": arenaCode,
        "tcgplayer_id": tcgplayerId,
        "name": name,
        "uri": uri,
        "scryfall_uri": scryfallUri,
        "search_uri": searchUri,
        "released_at": "${releasedAt.year.toString().padLeft(4, '0')}-${releasedAt.month.toString().padLeft(2, '0')}-${releasedAt.day.toString().padLeft(2, '0')}",
        "set_type": setTypeValues.reverse[setType],
        "card_count": cardCount,
        "digital": digital,
        "nonfoil_only": nonfoilOnly,
        "foil_only": foilOnly,
        "icon_svg_uri": iconSvgUri,
        "parent_set_code": parentSetCode,
        "block_code": blockCode,
        "block": block,
        "printed_size": printedSize,
    };
}

enum Object {
    SET
}

final objectValues = EnumValues({
    "set": Object.SET
});

enum SetType {
    ALCHEMY,
    ARCHENEMY,
    ARSENAL,
    BOX,
    COMMANDER,
    CORE,
    DRAFT_INNOVATION,
    DUEL_DECK,
    EXPANSION,
    FROM_THE_VAULT,
    FUNNY,
    MASTERPIECE,
    MASTERS,
    MEMORABILIA,
    MINIGAME,
    PLANECHASE,
    PREMIUM_DECK,
    PROMO,
    SPELLBOOK,
    STARTER,
    TOKEN,
    TREASURE_CHEST,
    VANGUARD
}

final setTypeValues = EnumValues({
    "alchemy": SetType.ALCHEMY,
    "archenemy": SetType.ARCHENEMY,
    "arsenal": SetType.ARSENAL,
    "box": SetType.BOX,
    "commander": SetType.COMMANDER,
    "core": SetType.CORE,
    "draft_innovation": SetType.DRAFT_INNOVATION,
    "duel_deck": SetType.DUEL_DECK,
    "expansion": SetType.EXPANSION,
    "from_the_vault": SetType.FROM_THE_VAULT,
    "funny": SetType.FUNNY,
    "masterpiece": SetType.MASTERPIECE,
    "masters": SetType.MASTERS,
    "memorabilia": SetType.MEMORABILIA,
    "minigame": SetType.MINIGAME,
    "planechase": SetType.PLANECHASE,
    "premium_deck": SetType.PREMIUM_DECK,
    "promo": SetType.PROMO,
    "spellbook": SetType.SPELLBOOK,
    "starter": SetType.STARTER,
    "token": SetType.TOKEN,
    "treasure_chest": SetType.TREASURE_CHEST,
    "vanguard": SetType.VANGUARD
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
            reverseMap = map.map((k, v) => MapEntry(v, k));
            return reverseMap;
    }
}
