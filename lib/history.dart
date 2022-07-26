import 'package:flutter/material.dart';
import 'package:khaata/history.dart';
import 'landingScreen.dart';
import 'dataClass.dart';
import 'package:hive/hive.dart';
part 'history.g.dart';

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
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              HistoryCardList(),
            ],
          ),
        ));
  }
}

class HistoryCardList extends StatefulWidget {
  HistoryCardList({
    Key? key,
  }) : super(key: key);

  @override
  State<HistoryCardList> createState() => _HistoryCardListState();
}

@HiveType(typeId: 0)
class Cards extends HiveObject {
  bool isExpanded;

  @HiveField(0)
  final String header;
  @HiveField(1)
  final String body;
  Cards({this.isExpanded: false, required this.header, required this.body});
  // Cards.fromMap(Map map)
  //     : this.header = map['header'],
  //       this.isExpanded = map['isExpanded'],
  //       this.body = map['body'];
  // Map<String, String> toJason() => {'header': header, 'body': body};
}

class _HistoryCardListState extends State<HistoryCardList> {
  @override
  Widget build(BuildContext context) {
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          data[index].isExpanded = !data[index].isExpanded;
          print(index);
        });
      },
      children: data.map((Cards card) {
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
                    children: [Text(card.body), Text(card.body)],
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
