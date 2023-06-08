import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:cx_frontend/scryfall.dart' as scryfall;
import 'package:http/http.dart' as http;

Future<List<scryfall.Card>> getCardList(String setCode) async {
  String url =
      'https://api.scryfall.com/cards/search?order=set&q=set%3A$setCode+unique%3Aprints';

  List<scryfall.Card> responseData = [];
  late bool hasNext;

  try {
    do {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        scryfall.CardList cardList =
            scryfall.CardList.fromJson(jsonDecode(response.body));

        if (cardList.data == null) throw Exception("Null data returned");

        responseData = [...responseData, ...cardList.data!];

        if (cardList.hasMore == true) {
          url = cardList.nextPage!;
          hasNext = true;
        } else {
          hasNext = false;
        }
      } else {
        throw Exception("Error, please try again");
      }
    } while (hasNext);

    return responseData;
  } catch (e) {
    rethrow;
  }
}

Future<scryfall.SetCodes> getSetCodes() async {
  String url = "https://api.scryfall.com/sets";
  //"https://api.ipify.org/?format=json";

  try {
    final response = await http.get(Uri.parse(url));
    debugPrint('debug: ${response.statusCode.toString()}');
    if (response.statusCode == 200) {
      return scryfall.SetCodes.fromJson(json.decode(response.body));
    } else {
      throw Exception("Error, please try again");
    }
  } catch (e) {
    rethrow;
  }
}
