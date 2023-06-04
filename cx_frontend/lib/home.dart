import 'dart:convert';
import 'package:cx_frontend/scryfall.dart' as scryfall;
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class CxHome extends StatefulWidget {
  const CxHome({super.key});

  @override
  State<CxHome> createState() => _CxHomeState();
}

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

void generateCsv(List<scryfall.Card> cards) {
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
    "Meta: _is_foil_qlty_slightly_pld_qty",
    "Meta: _is_foil_qlty_slightly_pld_price",
    "Meta: _is_foil_qlty_played_qty",
    "Meta: _is_foil_qlty_played_price",
    "Meta: _is_foil_qlty_heavily_pld_qty",
    "Meta: _is_foil_qlty_heavily_pld_price",
    "Meta: _is_nonfoil",
    "Meta: _is_nonfoil_qlty_near_mint_qty",
    "Meta: _is_nonfoil_qlty_near_mint_price",
    "Meta: _is_nonfoil_qlty_slightly_pld_qty",
    "Meta: _is_nonfoil_qlty_slightly_pld_price",
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


}

class _CxHomeState extends State<CxHome> {
  late Future<scryfall.SetCodes> setData;
  Future<List<scryfall.Card>>? cardList;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final multiplierController = TextEditingController();
  double spMultiplier = 95;
  double pldMultiplier = 90;
  double hpMultiplier = 80;

  String selectedSetCode = "";

  DataTable _createDataTable(List<scryfall.Card> cards, int multiplier) {
    return DataTable(
      dividerThickness: 2,
      columns: _createColumns(),
      rows: _createRows(cards, multiplier),
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
                    ? formatPricing(
                            (double.parse(cardData.prices!.usd!) * multiplier))
                        .roundToDouble()
                        .toString()
                    : cardData.prices!.usd!),
              ),
              DataCell(Text(cardData.prices!.usdFoil!)),
              DataCell(
                Text(double.tryParse(cardData.prices!.usdFoil!) != null ||
                        cardData.prices!.usdFoil != "No price available"
                    ? (double.parse(cardData.prices!.usdFoil!) * multiplier)
                        .toString()
                    : cardData.prices!.usdFoil!),
              ),
              DataCell(Text(cardData.prices!.usdEtched!)),
              DataCell(
                Text(double.tryParse(cardData.prices!.usdEtched!) != null ||
                        cardData.prices!.usdEtched != "No price available"
                    ? (double.parse(cardData.prices!.usdEtched!) * multiplier)
                        .toString()
                    : cardData.prices!.usd!),
              ),
            ]))
        .toList();
  }

  double formatPricing(double price) {
    // ((price/5.0).round() * 5)
    
    if (price < 10) {
      return 10;
    } else if (price > 10 && price < 15) {
      return 15;
    } else if (price > 15 && price < 20) {
      return 20;
    }

    return price;
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
                          ? "Enter a valid numeric value"
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
      )),
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

                if (snapshot.hasData) {
                  debugPrint(multiplierController.text);
                  return SingleChildScrollView(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: _createDataTable(
                        snapshot.data!,
                        int.parse(multiplierController.text),
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
        onPressed: () {
          return;
        },
      ),
    );
  }
}
