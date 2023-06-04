import 'dart:core';

class Product {
  String? setCode;
  String? cardName;
  String? collectorNumber;
  bool? isFoil;
  double? nmFoilPrice;
  double? spFoilPrice;
  double? pldFoilPrice;
  double? hpFoilPrice;
  double? nmPrice;
  double? spPrice;
  double? pldPrice;
  double? hpPrice;
  String? scryfallId;
  List<String>? colors;
  List<String>? types;
  String? rarity;

  Product({
    this.setCode,
    this.scryfallId,
    this.cardName,
    this.collectorNumber,
    this.isFoil,
    this.colors,
    this.types,
    this.rarity,
    this.nmFoilPrice,
    this.spFoilPrice,
    this.pldFoilPrice,
    this.hpFoilPrice,
    this.nmPrice,
    this.spPrice,
    this.pldPrice,
    this.hpPrice,
  });
}
