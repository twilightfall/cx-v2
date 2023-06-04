class Set {
  String? object;
  String? id;
  String? code;
  int? tcgplayerId;
  String? name;
  String? uri;
  String? scryfallUri;
  String? searchUri;
  String? releasedAt;
  String? setType;
  int? cardCount;
  bool? digital;
  bool? nonfoilOnly;
  bool? foilOnly;
  String? iconSvgUri;

  Set(
      {this.object,
      this.id,
      this.code,
      this.tcgplayerId,
      this.name,
      this.uri,
      this.scryfallUri,
      this.searchUri,
      this.releasedAt,
      this.setType,
      this.cardCount,
      this.digital,
      this.nonfoilOnly,
      this.foilOnly,
      this.iconSvgUri});

  Set.fromJson(Map<String, dynamic> json) {
    object = json['object'];
    id = json['id'];
    code = json['code'];
    tcgplayerId = json['tcgplayer_id'];
    name = json['name'];
    uri = json['uri'];
    scryfallUri = json['scryfall_uri'];
    searchUri = json['search_uri'];
    releasedAt = json['released_at'];
    setType = json['set_type'];
    cardCount = json['card_count'];
    digital = json['digital'];
    nonfoilOnly = json['nonfoil_only'];
    foilOnly = json['foil_only'];
    iconSvgUri = json['icon_svg_uri'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['object'] = object;
    data['id'] = id;
    data['code'] = code;
    data['tcgplayer_id'] = tcgplayerId;
    data['name'] = name;
    data['uri'] = uri;
    data['scryfall_uri'] = scryfallUri;
    data['search_uri'] = searchUri;
    data['released_at'] = releasedAt;
    data['set_type'] = setType;
    data['card_count'] = cardCount;
    data['digital'] = digital;
    data['nonfoil_only'] = nonfoilOnly;
    data['foil_only'] = foilOnly;
    data['icon_svg_uri'] = iconSvgUri;
    return data;
  }
}

class SetCodes {
  String? object;
  bool? hasMore;
  List<Set>? data;

  SetCodes({this.object, this.hasMore, this.data});

  SetCodes.fromJson(Map<String, dynamic> json) {
    object = json['object'];
    hasMore = json['has_more'];
    if (json['data'] != null) {
      data = <Set>[];
      json['data'].forEach((v) {
        data!.add(Set.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['object'] = object;
    data['has_more'] = hasMore;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Card {
  String? object;
  String? id;
  String? oracleId;
  List<int>? multiverseIds;
  int? tcgplayerId;
  int? tcgplayerEtchedId;
  int? cardmarketId;
  String? name;
  String? lang;
  String? releasedAt;
  String? uri;
  String? scryfallUri;
  String? layout;
  bool? highresImage;
  String? imageStatus;
  int? cmc;
  String? manaCost;
  String? typeLine;
  List<String>? colorIdentity;
  List<String>? colorIndicator;
  List<String>? colors;
  List<String>? keywords;
  String? oracleText;
  String? power;
  String? toughness;
  String? loyalty;
  List<CardFaces>? cardFaces;
  Legalities? legalities;
  List<String>? games;
  bool? reserved;
  bool? foil;
  bool? nonfoil;
  List<String>? finishes;
  bool? oversized;
  bool? promo;
  bool? reprint;
  bool? variation;
  String? setId;
  String? set;
  String? setName;
  String? setType;
  String? setUri;
  String? setSearchUri;
  String? scryfallSetUri;
  String? rulingsUri;
  String? printsSearchUri;
  String? collectorNumber;
  bool? digital;
  String? rarity;
  String? artist;
  List<String>? artistIds;
  String? borderColor;
  String? frame;
  List<String>? frameEffects;
  String? securityStamp;
  bool? fullArt;
  bool? textless;
  bool? booster;
  bool? storySpotlight;
  List<String>? promoTypes;
  int? edhrecRank;
  Prices? prices;
  RelatedUris? relatedUris;
  PurchaseUris? purchaseUris;

  Card(
      {this.object,
      this.id,
      this.oracleId,
      this.multiverseIds,
      this.tcgplayerId,
      this.tcgplayerEtchedId,
      this.cardmarketId,
      this.name,
      this.lang,
      this.releasedAt,
      this.uri,
      this.scryfallUri,
      this.layout,
      this.highresImage,
      this.imageStatus,
      this.cmc,
      this.manaCost,
      this.typeLine,
      this.colorIdentity,
      this.colorIndicator,
      this.colors,
      this.keywords,
      this.oracleText,
      this.power,
      this.toughness,
      this.loyalty,
      this.cardFaces,
      this.legalities,
      this.games,
      this.reserved,
      this.foil,
      this.nonfoil,
      this.finishes,
      this.oversized,
      this.promo,
      this.reprint,
      this.variation,
      this.setId,
      this.set,
      this.setName,
      this.setType,
      this.setUri,
      this.setSearchUri,
      this.scryfallSetUri,
      this.rulingsUri,
      this.printsSearchUri,
      this.collectorNumber,
      this.digital,
      this.rarity,
      this.artist,
      this.artistIds,
      this.borderColor,
      this.frame,
      this.frameEffects,
      this.securityStamp,
      this.fullArt,
      this.textless,
      this.booster,
      this.storySpotlight,
      this.promoTypes,
      this.edhrecRank,
      this.prices,
      this.relatedUris,
      this.purchaseUris});

  Card.fromJson(Map<String, dynamic> json) {
    object = json['object'];
    id = json['id'];
    oracleId = json['oracle_id'];
    if (json['multiverse_ids'] != null) {
      multiverseIds = <int>[];
      json['multiverse_ids'].forEach((v) {
        multiverseIds!.add((v));
      });
    }
    tcgplayerId = json['tcgplayer_id'];
    tcgplayerEtchedId = json['tcgplayer_etched_id'];
    cardmarketId = json['cardmarket_id'];
    name = json['name'];
    lang = json['lang'];
    releasedAt = json['released_at'];
    uri = json['uri'];
    scryfallUri = json['scryfall_uri'];
    layout = json['layout'];
    highresImage = json['highres_image'];
    imageStatus = json['image_status'];
    cmc = json['cmc'];
    manaCost = json['mana_cost'];
    typeLine = json['type_line'];
    colorIdentity = (json['color_identity'] as List<dynamic>).cast<String>();
    if (json['color_indicator'] != null) {
      colorIndicator =
          (json['color_indicator'] as List<dynamic>).cast<String>();
    }
    if (json['colors'] != null) {
      colors = (json['colors'] as List<dynamic>).cast<String>();
    }
    keywords = (json['keywords'] as List<dynamic>).cast<String>();
    if (json['oracle_text'] != null) {
      oracleText = json['oracle_text'];
    }
    power = json['power'];
    toughness = json['toughness'];
    loyalty = json['loyalty'];
    if (json['card_faces'] != null) {
      cardFaces = <CardFaces>[];
      json['card_faces'].forEach((v) {
        cardFaces!.add(CardFaces.fromJson(v));
      });
    }
    legalities = json['legalities'] != null
        ? Legalities.fromJson(json['legalities'])
        : null;
    games = (json['games'] as List<dynamic>).cast<String>();
    reserved = json['reserved'];
    foil = json['foil'];
    nonfoil = json['nonfoil'];
    finishes = (json['finishes'] as List<dynamic>).cast<String>();
    oversized = json['oversized'];
    promo = json['promo'];
    reprint = json['reprint'];
    variation = json['variation'];
    setId = json['set_id'];
    set = json['set'];
    setName = json['set_name'];
    setType = json['set_type'];
    setUri = json['set_uri'];
    setSearchUri = json['set_search_uri'];
    scryfallSetUri = json['scryfall_set_uri'];
    rulingsUri = json['rulings_uri'];
    printsSearchUri = json['prints_search_uri'];
    collectorNumber = json['collector_number'];
    digital = json['digital'];
    rarity = json['rarity'];
    artist = json['artist'];
    artistIds = (json['artist_ids'] as List<dynamic>).cast<String>();
    borderColor = json['border_color'];
    frame = json['frame'];
    if (json['frame_effects'] != null) {
      frameEffects = (json['frame_effects'] as List<dynamic>).cast<String>();
    }
    securityStamp = json['security_stamp'];
    fullArt = json['full_art'];
    textless = json['textless'];
    booster = json['booster'];
    storySpotlight = json['story_spotlight'];
    if (json['promo_types'] != null) {
      promoTypes = (json['promo_types'] as List<dynamic>).cast<String>();
    }
    edhrecRank = json['edhrec_rank'];
    prices = json['prices'] != null ? Prices.fromJson(json['prices']) : null;
    relatedUris = json['related_uris'] != null
        ? RelatedUris.fromJson(json['related_uris'])
        : null;
    purchaseUris = json['purchase_uris'] != null
        ? PurchaseUris.fromJson(json['purchase_uris'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['object'] = object;
    data['id'] = id;
    data['oracle_id'] = oracleId;
    data['multiverse_ids'] = multiverseIds;
    data['tcgplayer_id'] = tcgplayerId;
    data['tcgplayer_etched_id'] = tcgplayerEtchedId;
    data['cardmarket_id'] = cardmarketId;
    data['name'] = name;
    data['lang'] = lang;
    data['released_at'] = releasedAt;
    data['uri'] = uri;
    data['scryfall_uri'] = scryfallUri;
    data['layout'] = layout;
    data['highres_image'] = highresImage;
    data['image_status'] = imageStatus;
    data['cmc'] = cmc;
    data['type_line'] = typeLine;
    data['color_identity'] = colorIdentity;
    data['color_indicator'] = colorIndicator;
    data['colors'] = colors;
    data['keywords'] = keywords;
    data['oracle_text'] = oracleText;
    data['power'] = power;
    data['toughness'] = toughness;
    data['loyalty'] = loyalty;
    if (cardFaces != null) {
      data['card_faces'] = cardFaces!.map((v) => v.toJson()).toList();
    }
    if (legalities != null) {
      data['legalities'] = legalities!.toJson();
    }
    data['games'] = games;
    data['reserved'] = reserved;
    data['foil'] = foil;
    data['nonfoil'] = nonfoil;
    data['finishes'] = finishes;
    data['oversized'] = oversized;
    data['promo'] = promo;
    data['reprint'] = reprint;
    data['variation'] = variation;
    data['set_id'] = setId;
    data['set'] = set;
    data['set_name'] = setName;
    data['set_type'] = setType;
    data['set_uri'] = setUri;
    data['set_search_uri'] = setSearchUri;
    data['scryfall_set_uri'] = scryfallSetUri;
    data['rulings_uri'] = rulingsUri;
    data['prints_search_uri'] = printsSearchUri;
    data['collector_number'] = collectorNumber;
    data['digital'] = digital;
    data['rarity'] = rarity;
    data['artist'] = artist;
    data['artist_ids'] = artistIds;
    data['border_color'] = borderColor;
    data['frame'] = frame;
    data['frame_effects'] = frameEffects;
    data['security_stamp'] = securityStamp;
    data['full_art'] = fullArt;
    data['textless'] = textless;
    data['booster'] = booster;
    data['story_spotlight'] = storySpotlight;
    data['promo_types'] = promoTypes;
    data['edhrec_rank'] = edhrecRank;
    if (prices != null) {
      data['prices'] = prices!.toJson();
    }
    if (relatedUris != null) {
      data['related_uris'] = relatedUris!.toJson();
    }
    if (purchaseUris != null) {
      data['purchase_uris'] = purchaseUris!.toJson();
    }
    return data;
  }
}

class CardFaces {
  String? object;
  String? name;
  String? manaCost;
  String? typeLine;
  String? oracleText;
  List<String>? colors;
  String? power;
  String? toughness;
  String? watermark;
  String? artist;
  String? artistId;
  String? illustrationId;
  ImageUris? imageUris;
  String? flavorText;
  List<String>? colorIndicator;
  String? loyalty;

  CardFaces(
      {this.object,
      this.name,
      this.manaCost,
      this.typeLine,
      this.oracleText,
      this.colors,
      this.power,
      this.toughness,
      this.watermark,
      this.artist,
      this.artistId,
      this.illustrationId,
      this.imageUris,
      this.flavorText,
      this.colorIndicator,
      this.loyalty});

  CardFaces.fromJson(Map<String, dynamic> json) {
    object = json['object'];
    name = json['name'];
    manaCost = json['mana_cost'];
    typeLine = json['type_line'];
    oracleText = json['oracle_text'];
    if (json['colors'] != null) {
      colors = (json['colors'] as List<dynamic>).cast<String>();
    }
    power = json['power'];
    toughness = json['toughness'];
    watermark = json['watermark'];
    artist = json['artist'];
    artistId = json['artist_id'];
    illustrationId = json['illustration_id'];
    imageUris = json['image_uris'] != null
        ? ImageUris.fromJson(json['image_uris'])
        : null;
    flavorText = json['flavor_text'];
    if (json['color_indicator'] != null) {
      colorIndicator =
          (json['color_indicator'] as List<dynamic>).cast<String>();
    }
    loyalty = json['loyalty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['object'] = object;
    data['name'] = name;
    data['mana_cost'] = manaCost;
    data['type_line'] = typeLine;
    data['oracle_text'] = oracleText;
    data['colors'] = colors;
    data['power'] = power;
    data['toughness'] = toughness;
    data['watermark'] = watermark;
    data['artist'] = artist;
    data['artist_id'] = artistId;
    data['illustration_id'] = illustrationId;
    if (imageUris != null) {
      data['image_uris'] = imageUris!.toJson();
    }
    data['flavor_text'] = flavorText;
    data['color_indicator'] = colorIndicator;
    data['loyalty'] = loyalty;
    return data;
  }
}

class ImageUris {
  String? small;
  String? normal;
  String? large;
  String? png;
  String? artCrop;
  String? borderCrop;

  ImageUris(
      {this.small,
      this.normal,
      this.large,
      this.png,
      this.artCrop,
      this.borderCrop});

  ImageUris.fromJson(Map<String, dynamic> json) {
    small = json['small'];
    normal = json['normal'];
    large = json['large'];
    png = json['png'];
    artCrop = json['art_crop'];
    borderCrop = json['border_crop'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['small'] = small;
    data['normal'] = normal;
    data['large'] = large;
    data['png'] = png;
    data['art_crop'] = artCrop;
    data['border_crop'] = borderCrop;
    return data;
  }
}

class Legalities {
  String? standard;
  String? future;
  String? historic;
  String? gladiator;
  String? pioneer;
  String? explorer;
  String? modern;
  String? legacy;
  String? pauper;
  String? vintage;
  String? penny;
  String? commander;
  String? oathbreaker;
  String? brawl;
  String? historicbrawl;
  String? alchemy;
  String? paupercommander;
  String? duel;
  String? oldschool;
  String? premodern;
  String? predh;

  Legalities(
      {this.standard,
      this.future,
      this.historic,
      this.gladiator,
      this.pioneer,
      this.explorer,
      this.modern,
      this.legacy,
      this.pauper,
      this.vintage,
      this.penny,
      this.commander,
      this.oathbreaker,
      this.brawl,
      this.historicbrawl,
      this.alchemy,
      this.paupercommander,
      this.duel,
      this.oldschool,
      this.premodern,
      this.predh});

  Legalities.fromJson(Map<String, dynamic> json) {
    standard = json['standard'];
    future = json['future'];
    historic = json['historic'];
    gladiator = json['gladiator'];
    pioneer = json['pioneer'];
    explorer = json['explorer'];
    modern = json['modern'];
    legacy = json['legacy'];
    pauper = json['pauper'];
    vintage = json['vintage'];
    penny = json['penny'];
    commander = json['commander'];
    oathbreaker = json['oathbreaker'];
    brawl = json['brawl'];
    historicbrawl = json['historicbrawl'];
    alchemy = json['alchemy'];
    paupercommander = json['paupercommander'];
    duel = json['duel'];
    oldschool = json['oldschool'];
    premodern = json['premodern'];
    predh = json['predh'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['standard'] = standard;
    data['future'] = future;
    data['historic'] = historic;
    data['gladiator'] = gladiator;
    data['pioneer'] = pioneer;
    data['explorer'] = explorer;
    data['modern'] = modern;
    data['legacy'] = legacy;
    data['pauper'] = pauper;
    data['vintage'] = vintage;
    data['penny'] = penny;
    data['commander'] = commander;
    data['oathbreaker'] = oathbreaker;
    data['brawl'] = brawl;
    data['historicbrawl'] = historicbrawl;
    data['alchemy'] = alchemy;
    data['paupercommander'] = paupercommander;
    data['duel'] = duel;
    data['oldschool'] = oldschool;
    data['premodern'] = premodern;
    data['predh'] = predh;
    return data;
  }
}

class Prices {
  String? usd;
  String? usdFoil;
  String? usdEtched;
  String? eur;
  String? eurFoil;
  String? tix;

  Prices(
      {this.usd,
      this.usdFoil,
      this.usdEtched,
      this.eur,
      this.eurFoil,
      this.tix});

  Prices.fromJson(Map<String, dynamic> json) {
    usd = json['usd'] ?? "No price available";
    usdFoil = json['usd_foil'] ?? "No price available";
    usdEtched = json['usd_etched'] ?? "No price available";
    eur = json['eur'] ?? "No price available";
    eurFoil = json['eur_foil'] ?? "No price available";
    tix = json['tix'] ?? "No price available";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['usd'] = usd;
    data['usd_foil'] = usdFoil;
    data['usd_etched'] = usdEtched;
    data['eur'] = eur;
    data['eur_foil'] = eurFoil;
    data['tix'] = tix;
    return data;
  }
}

class RelatedUris {
  String? tcgplayerInfiniteArticles;
  String? tcgplayerInfiniteDecks;
  String? edhrec;

  RelatedUris(
      {this.tcgplayerInfiniteArticles,
      this.tcgplayerInfiniteDecks,
      this.edhrec});

  RelatedUris.fromJson(Map<String, dynamic> json) {
    tcgplayerInfiniteArticles = json['tcgplayer_infinite_articles'];
    tcgplayerInfiniteDecks = json['tcgplayer_infinite_decks'];
    edhrec = json['edhrec'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['tcgplayer_infinite_articles'] = tcgplayerInfiniteArticles;
    data['tcgplayer_infinite_decks'] = tcgplayerInfiniteDecks;
    data['edhrec'] = edhrec;
    return data;
  }
}

class PurchaseUris {
  String? tcgplayer;
  String? cardmarket;
  String? cardhoarder;

  PurchaseUris({this.tcgplayer, this.cardmarket, this.cardhoarder});

  PurchaseUris.fromJson(Map<String, dynamic> json) {
    tcgplayer = json['tcgplayer'];
    cardmarket = json['cardmarket'];
    cardhoarder = json['cardhoarder'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['tcgplayer'] = tcgplayer;
    data['cardmarket'] = cardmarket;
    data['cardhoarder'] = cardhoarder;
    return data;
  }
}

class CardList {
  String? object;
  int? totalCards;
  bool? hasMore;
  String? nextPage;
  List<Card>? data;

  CardList(
      {this.object, this.totalCards, this.hasMore, this.nextPage, this.data});

  CardList.fromJson(Map<String, dynamic> json) {
    object = json['object'];
    totalCards = json['total_cards'];
    hasMore = json['has_more'];
    nextPage = json['next_page'];
    if (json['data'] != null) {
      data = <Card>[];
      json['data'].forEach((v) {
        data!.add(Card.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['object'] = object;
    data['total_cards'] = totalCards;
    data['has_more'] = hasMore;
    data['next_page'] = nextPage;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
