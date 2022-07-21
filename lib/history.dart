import 'package:flutter/material.dart';
import 'landingScreen.dart';
import 'dataClass.dart';

double height1 = 70.0;

class HistoryCard extends StatefulWidget {
  const HistoryCard({Key? key}) : super(key: key);
  @override
  State<HistoryCard> createState() => _HistoryCardState();
}

class _HistoryCardState extends State<HistoryCard> {
  //DataClass dt = new DataClass(1, 1, DateTime.now(), 11);
  Map data = {};
  bool isExpanded = false;
  List<IconData> icon = [Icons.arrow_drop_down, Icons.arrow_drop_up];

  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context)!.settings.arguments as Map;
    return Padding(
      padding: EdgeInsets.all(7),
      child: AnimatedContainer(
        padding: EdgeInsets.fromLTRB(15, 20, 0, 0),
        decoration: BoxDecoration(
            color: Colors.teal,
            borderRadius: BorderRadius.all(Radius.circular(7))),
        duration: new Duration(milliseconds: 500),
        height: height1,
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                data['date'].toString(),
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              TextButton(
                child: Icon(
                  Icons.arrow_drop_down,
                  size: 30,
                ),
                onPressed: () {
                  setState(() {
                    if (height1 == 70.0) {
                      height1 = 400.0;
                    } else {
                      height1 = 70.0;
                    }
                  });
                  if (isExpanded) {
                    !isExpanded;
                  } else {
                    isExpanded;
                  }
                  print(isExpanded);
                },
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Visibility(
            visible: isExpanded,
            child: Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Starting Reading"),
                  Text(data['startReading'].toString())
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

class History extends StatefulWidget {
  const History({Key? key}) : super(key: key);

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  List<HistoryCard> historyList = [
    HistoryCard(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('History'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.teal,
      ),
      body: ListView.builder(
        itemCount: historyList.length,
        itemBuilder: (context, index) {
          return historyList[index];
        },
      ),
    );
  }
}
