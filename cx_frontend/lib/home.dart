// ignore_for_file: avoid_web_libraries_in_flutter

import 'dart:convert';
import 'dart:html' as html;
import 'package:csv/csv.dart';
import 'package:cx_frontend/scryfall.dart' as scryfall;
import 'package:flutter/material.dart';

import 'apis.dart';

class CxHome extends StatefulWidget {
  const CxHome({super.key});

  @override
  State<CxHome> createState() => _CxHomeState();
}

class _CxHomeState extends State<CxHome> {
  late Future<scryfall.SetCodes> setData;
  Future<List<scryfall.Card>>? cardList;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final multiplierController = TextEditingController();
  late int nmMultiplier;
  double spMultiplier = 95;
  double pldMultiplier = 90;
  double hpMultiplier = 80;

  String selectedSetCode = "";

  List<scryfall.Card> selectedSetData = [];

  DataTable _createDataTable(List<scryfall.Card> cards, int multiplier) {
    return DataTable(
      dividerThickness: 2,
      columns: _createColumns(),
      rows: _createRows(cards, multiplier),
      columnSpacing: 25,
    );
  }

  List<DataColumn> _createColumns() {
    return [
      const DataColumn(label: Text("Collector #")),
      const DataColumn(label: Text("Card Name")),
      const DataColumn(label: Text("USD Nonfoil Price")),
      const DataColumn(label: Text("NM Price")),
      const DataColumn(label: Text("USD Foil Price")),
      const DataColumn(label: Text("NM Foil Price")),
      const DataColumn(label: Text("USD Etched Foil Price")),
      const DataColumn(label: Text("NM Etched Foil Price")),
    ];
  }

  List<DataRow> _createRows(List<scryfall.Card> cardList, int multiplier) {
    return cardList
        .map((cardData) => DataRow(cells: [
              DataCell(Text(cardData.collectorNumber!)),
              DataCell(Text(cardData.name!)),
              DataCell(Text(cardData.prices!.usd!)),
              DataCell(
                Text(double.tryParse(cardData.prices!.usd!) != null ||
                        cardData.prices!.usd != "No price available"
                    ? getNMPrice(
                            double.parse(cardData.prices!.usd!), multiplier)
                        .toString()
                    : cardData.prices!.usd!),
              ),
              DataCell(Text(cardData.prices!.usdFoil!)),
              DataCell(
                Text(double.tryParse(cardData.prices!.usdFoil!) != null ||
                        cardData.prices!.usdFoil != "No price available"
                    ? getNMPrice(
                            double.parse(cardData.prices!.usdFoil!), multiplier)
                        .toString()
                    : cardData.prices!.usdFoil!),
              ),
              DataCell(Text(cardData.prices!.usdEtched!)),
              DataCell(
                Text(double.tryParse(cardData.prices!.usdEtched!) != null ||
                        cardData.prices!.usdEtched != "No price available"
                    ? getNMPrice(double.parse(cardData.prices!.usdEtched!),
                            multiplier)
                        .toString()
                    : cardData.prices!.usdEtched!),
              ),
            ]))
        .toList();
  }

  double formatPricing(double price) {
    return ((price / 5.0).round() * 5) < 30 ? 30 : (price / 5.0).round() * 5;
  }

  int getNMPrice(double price, int multiplier) {
    return formatPricing((price * multiplier)).toInt();
  }

  int getGradedPrice(int price, double multiplier) {
    return (price * multiplier).toInt();
  }

  // int geMidPricing(int tcgId, int multiplier) {
  //   Future<tcg.Prices> tcgPrices;
  // }

  List<String> generateCsvRow(scryfall.Card cardData) {
    String type = "simple";
    // ignore: non_constant_identifier_names
    String SKU = '${cardData.set}-${cardData.collectorNumber}';
    String isPublished = "1";
    String visibility = "visible";
    String inStock = "1";
    String regularPrice = "150";
    String category = "Singles";
    String nil = "0";

    int nmPrice = cardData.prices!.usd! != 'No price available'
        ? getNMPrice(double.parse(cardData.prices!.usd!), nmMultiplier)
        : 0;
    int spPrice =
        nmPrice > 0 ? getGradedPrice(nmPrice, spMultiplier * 0.01) : 0;
    int pldPrice =
        nmPrice > 0 ? getGradedPrice(nmPrice, pldMultiplier * 0.01) : 0;
    int hpPrice =
        nmPrice > 0 ? getGradedPrice(nmPrice, hpMultiplier * 0.01) : 0;

    int nmFoilPrice = cardData.prices!.usdFoil! != 'No price available'
        ? getNMPrice(double.parse(cardData.prices!.usdFoil!), nmMultiplier)
        : 0;
    int spFoilPrice =
        nmFoilPrice > 0 ? getGradedPrice(nmFoilPrice, spMultiplier * 0.01) : 0;
    int pldFoilPrice =
        nmFoilPrice > 0 ? getGradedPrice(nmFoilPrice, pldMultiplier * 0.01) : 0;
    int hpFoilPrice =
        nmFoilPrice > 0 ? getGradedPrice(nmFoilPrice, hpMultiplier * 0.01) : 0;

    int nmEtchedPrice = cardData.prices!.usdEtched != 'No price available'
        ? getNMPrice(double.parse(cardData.prices!.usdEtched!), nmMultiplier)
        : 0;
    int spEtchedPrice = nmEtchedPrice > 0
        ? getGradedPrice(nmEtchedPrice, spMultiplier * 0.01)
        : 0;
    int pldEtchedPrice = nmEtchedPrice > 0
        ? getGradedPrice(nmEtchedPrice, pldMultiplier * 0.01)
        : 0;
    int hpEtchedPrice = nmEtchedPrice > 0
        ? getGradedPrice(nmEtchedPrice, hpMultiplier * 0.01)
        : 0;

    List<String> cardDataRow = [
      type,
      SKU,
      cardData.name!,
      isPublished,
      visibility,
      inStock,
      regularPrice,
      category,
      cardData.foil!
          ? "yes"
          : cardData.finishes!.contains("etched")
              ? "yes"
              : "",
      nil,
      nmEtchedPrice > 0 ? nmEtchedPrice.toString() : nmFoilPrice.toString(),
      nil,
      nmEtchedPrice > 0 ? spEtchedPrice.toString() : spFoilPrice.toString(),
      nil,
      nmEtchedPrice > 0 ? pldEtchedPrice.toString() : pldFoilPrice.toString(),
      nil,
      nmEtchedPrice > 0 ? hpEtchedPrice.toString() : hpFoilPrice.toString(),
      cardData.nonfoil! ? "yes" : "",
      nil,
      nmPrice.toString(),
      nil,
      spPrice.toString(),
      nil,
      pldPrice.toString(),
      nil,
      hpPrice.toString(),
      cardData.id!,
      "1",
      cardData.set!,
      cardData.rarity!,
      getTypes(cardData).join(","),
      getColors(cardData).join(","),
    ];

    return cardDataRow;
  }

  List<String> getColors(scryfall.Card cardData) {
    if (cardData.colors != null) {
      return cardData.colors!.isEmpty ? ["C"] : cardData.colors!;
    }

    if (cardData.colors == null && cardData.cardFaces!.isNotEmpty) {
      return cardData.cardFaces![0].colors!.isEmpty
          ? ["C"]
          : cardData.cardFaces![0].colors!;
    }

    return ["C"];
  }

  List<String> getTypes(scryfall.Card cardData) {
    bool hasMultipleFaces; // = cardData.typeLine!.indexOf("//") > 0;
    bool hasSubtypes; // = cardData.typeLine!.indexOf("—") > 0;

    String cardTypes = cardData.typeLine!;

    hasMultipleFaces = cardTypes.indexOf("//") > 0;

    cardTypes = hasMultipleFaces
        ? cardTypes.substring(0, cardTypes.indexOf(" // "))
        : cardTypes;

    hasSubtypes = cardTypes.indexOf("—") > 0;

    cardTypes = hasSubtypes
        ? cardTypes.substring(0, cardTypes.indexOf(" — "))
        : cardTypes.trim();

    return cardTypes.split(" ");
  }

  void generateCsv(List<scryfall.Card> cards, String setCode) {
    List<String> rowHeader = [
      "Type",
      "SKU",
      "Name",
      "Published",
      "Visibility in catalog",
      "In stock?",
      "Regular price",
      "Categories",
      "Meta: _is_foil",
      "Meta: _is_foil_qlty_near_mint_qty",
      "Meta: _is_foil_qlty_near_mint_price",
      "Meta: _is_foil_qlty_slight_pld_qty",
      "Meta: _is_foil_qlty_slight_pld_price",
      "Meta: _is_foil_qlty_played_qty",
      "Meta: _is_foil_qlty_played_price",
      "Meta: _is_foil_qlty_heavily_pld_qty",
      "Meta: _is_foil_qlty_heavily_pld_price",
      "Meta: _is_nonfoil",
      "Meta: _is_nonfoil_qlty_near_mint_qty",
      "Meta: _is_nonfoil_qlty_near_mint_price",
      "Meta: _is_nonfoil_qlty_slight_pld_qty",
      "Meta: _is_nonfoil_qlty_slight_pld_price",
      "Meta: _is_nonfoil_qlty_played_qty",
      "Meta: _is_nonfoil_qlty_played_price",
      "Meta: _is_nonfoil_qlty_heavily_pld_qty",
      "Meta: _is_nonfoil_qlty_heavily_pld_price",
      "Meta: _mtg_id",
      "Meta: _is_card_item",
      "Meta: _mtg_set_code",
      "Meta: _mtg_rarity",
      "Meta: _mtg_types",
      "Meta: _mtg_colors"
    ];

    List<List<dynamic>> rows = [];

    rows.add(rowHeader);

    for (scryfall.Card card in cards) {
      rows.add(generateCsvRow(card));
    }

    String csv = const ListToCsvConverter().convert(rows);
    final bytes = utf8.encode(csv);
    final blob = html.Blob([bytes]);
    final url = html.Url.createObjectUrlFromBlob(blob);

    final anchor = html.document.createElement('a') as html.AnchorElement
      ..href = url
      ..style.display = 'none'
      ..download = '$setCode - ${DateTime.now()}.csv';
    //finally add the csv anchor to body
    html.document.body!.children.add(anchor);
    // Cause download by calling this function
    anchor.click();
    //revoke the object
    html.Url.revokeObjectUrl(url);
  }

  @override
  void initState() {
    super.initState();
    setData = getSetCodes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("CX Price Extractor v2"),
        backgroundColor: Colors.yellow,
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text("Set extraction data on this panel!"),
            ),
            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Select Set Code: $selectedSetCode'),
                    FutureBuilder(
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return DropdownButtonFormField<String>(
                            isExpanded: true,
                            items: snapshot.data!.data!
                                .where((set) =>
                                    set.setType != 'token' &&
                                    set.setType != 'minigame' &&
                                    set.setType != 'memorabilia' &&
                                    set.digital == false)
                                .map(
                                  (e) => DropdownMenuItem<String>(
                                    value: e.code!,
                                    child: Text(e.name!),
                                  ),
                                )
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                selectedSetCode = value!;
                              });
                            },
                          );
                        }

                        if (snapshot.hasError) {
                          return const Text("ERROR");
                        }

                        return const Text('LOADING SETS...');
                      },
                      future: setData,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 5, bottom: 5),
                      child: Divider(
                        height: 5,
                        thickness: 2.5,
                        indent: 15,
                        endIndent: 15,
                        color: Colors.black,
                      ),
                    ),
                    const Text("Set multiplier: "),
                    TextFormField(
                      decoration: const InputDecoration(
                        hintText: "Multiplier value for pricing: ",
                      ),
                      validator: (value) {
                        return value!.isEmpty || int.tryParse(value) == null
                            ? "Enter a valid integer numeric value (whole numbers only!)"
                            : null;
                      },
                      controller: multiplierController,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 5, bottom: 5),
                      child: Divider(
                        height: 5,
                        thickness: 2.5,
                        indent: 15,
                        endIndent: 15,
                        color: Colors.black,
                      ),
                    ),
                    const Text("Percentages for SP, PLD, and HP prices:"),
                    Text('SP Price percentage (Default 0.95): $spMultiplier%'),
                    Slider(
                      value: spMultiplier,
                      max: 100,
                      divisions: 100,
                      label: spMultiplier.round().toString(),
                      onChanged: (value) {
                        setState(() {
                          spMultiplier = value;
                        });
                      },
                    ),
                    Text('PLD Price percentage (Default 0.9): $pldMultiplier%'),
                    Slider(
                      value: pldMultiplier,
                      max: 100,
                      divisions: 100,
                      label: pldMultiplier.round().toString(),
                      onChanged: (value) {
                        setState(() {
                          pldMultiplier = value;
                        });
                      },
                    ),
                    Text('HP Price percentage (Default 0.8): $hpMultiplier%'),
                    Slider(
                      value: hpMultiplier,
                      max: 100,
                      divisions: 100,
                      label: hpMultiplier.round().toString(),
                      onChanged: (value) {
                        setState(() {
                          hpMultiplier = value;
                        });
                      },
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 5, bottom: 5),
                      child: Divider(
                        height: 5,
                        thickness: 2.5,
                        indent: 15,
                        endIndent: 15,
                        color: Colors.black,
                      ),
                    ),
                    Center(
                      child: MaterialButton(
                        color: Colors.blueAccent,
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              nmMultiplier =
                                  int.parse(multiplierController.text);
                              cardList = getCardList(selectedSetCode);
                            });
                          }
                        },
                        child: const Text("SEARCH"),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Center(
            child: FutureBuilder(
              builder: ((context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text(snapshot.error.toString()),
                  );
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Text("LOADING DATA");
                }

                if (snapshot.hasData) {
                  selectedSetData = snapshot.data!;
                  return SingleChildScrollView(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: _createDataTable(
                        snapshot.data!,
                        nmMultiplier,
                      ),
                    ),
                  );
                }
                return const Center(
                  child: Text("INPUT PARAMS IN SIDEBAR TO START"),
                );
              }),
              future: cardList,
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.download),
        onPressed: () {
          if (selectedSetData.isNotEmpty) {
            generateCsv(selectedSetData, selectedSetCode);
          }
        },
      ),
    );
  }
}
