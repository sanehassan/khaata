import 'package:flutter/material.dart';

import 'landingScreen.dart';

double height1 = 70.0;

class History extends StatefulWidget {
  const History({Key? key}) : super(key: key);

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('History'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.teal,
      ),
      body: (hiss != null)
          ? SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  HistoryCardList(),
                ],
              ),
            )
          : Center(
              child: Text("Nothing to show"),
            ),
    );
  }
}

class HistoryCardList extends StatefulWidget {
  HistoryCardList({
    Key? key,
  }) : super(key: key);

  @override
  State<HistoryCardList> createState() => _HistoryCardListState();
}

class Cards {
  bool isExpanded;
  final String header;
  final String initialPetrolReading;
  final String endingPetrolReading;
  final String currentPetrolPrice;
  final String petrolSale;
  final String initialDieselReading;
  final String endingDieselReading;
  final String currentDieselPrice;
  final String dieselSale;
  final String petrolStock;
  final String dieselStock;

  Cards({
    required this.header,
    required this.initialPetrolReading,
    required this.endingPetrolReading,
    required this.currentPetrolPrice,
    required this.petrolSale,
    required this.initialDieselReading,
    required this.endingDieselReading,
    required this.currentDieselPrice,
    required this.dieselSale,
    required this.petrolStock,
    required this.dieselStock,
    this.isExpanded: false,
  });
  Cards.fromMap(Map map)
      : this.header = map['header'],
        this.initialPetrolReading = map['initialPetrolReading'],
        this.endingPetrolReading = map['endingPetrolReading'],
        this.currentPetrolPrice = map['currentPetrolPrice'],
        this.petrolSale = map['petrolSale'],
        this.initialDieselReading = map['initialDieselReading'],
        this.endingDieselReading = map['endingDieselReading'],
        this.currentDieselPrice = map['currentDieselPrice'],
        this.dieselSale = map['dieselSale'],
        this.petrolStock = map['petrolStock'],
        this.dieselStock = map['dieselStock'],
        this.isExpanded = map['isExpanded'];
  // Map<String, String> toJason() => {'header': header, 'body': body};
  Map<String, dynamic> toJson() {
    return {
      "header": header,
      "initialPetrolReading": initialPetrolReading,
      "endingPetrolReading": endingPetrolReading,
      "currentPetrolPrice": currentPetrolPrice,
      "petrolSale": petrolSale,
      "initialDieselReading": initialDieselReading,
      "endingDieselReading": endingDieselReading,
      "currentDieselPrice": currentDieselPrice,
      "dieselSale": dieselSale,
      "petrolStock": petrolStock,
      "dieselStock": dieselStock,
      "isExpanded": false,
    };
  }
}

class _HistoryCardListState extends State<HistoryCardList> {
  @override
  Widget build(BuildContext context) {
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          hiss[index].isExpanded = !hiss[index].isExpanded;
          print(index);
        });
      },
      children: hiss.map((Cards card) {
        return ExpansionPanel(
          canTapOnHeader: true,
          backgroundColor: Colors.teal.shade400,
          headerBuilder: (context, isExpanded) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                card.header,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            );
          },
          isExpanded: card.isExpanded,
          body: Container(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Initial Petrol Reading"),
                      Text(card.initialPetrolReading)
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Final Petrol Reading"),
                      Text(card.endingPetrolReading)
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Petrol Sale"),
                      Text('${card.petrolSale} Rs')
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Remaining Petrol Stock "),
                      Text('${card.petrolStock} ltr')
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Initial Diesel Reading"),
                      Text(card.initialDieselReading)
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Final Diesel Reading"),
                      Text(card.endingDieselReading)
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Diesel Sale"),
                      Text('${card.dieselSale} Rs')
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Remaining Diesel Stock "),
                      Text('${card.dieselStock} ltr')
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
