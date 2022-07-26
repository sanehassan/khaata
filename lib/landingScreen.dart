import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:khaata/landingScreen.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'dataClass.dart';
import 'history.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  DateTime selectedDate = DateTime.now();

  late String date =
      '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}';
  // var sDate = selectedDate;
  // String dateString = date;

  // final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  // late Future<int> _counter;
  double stock = 0;

  late TextEditingController controller;
  late TextEditingController controllerSt;
  late TextEditingController controllerEnd;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
    controllerSt = TextEditingController();
    controllerEnd = TextEditingController();

    getListTest();
    getData();
    // getList();
  }

  @override
  void dispose() {
    controller.dispose();
    controllerEnd.dispose();
    controllerSt.dispose();
    super.dispose();
  }

  double dieselPrice = 0;
  double showR = 0;
  double finalRead = 0.0;
  double startRead = 0.0;
  String stockString = "Stock";
  String dieselPString = "Diesel Price";
  String petrolPString = "Petrol Price";
  double petrolPrice = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Khata",
          style: TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.teal,
      ),
      drawer: Drawer(
        backgroundColor: Colors.teal,
        child: ListView(
          children: [
            DrawerHeader(
              duration: const Duration(milliseconds: 250),
              curve: Curves.fastOutSlowIn,
              decoration: BoxDecoration(),
              padding: EdgeInsets.only(top: 60),
              child: Text(
                'Menu',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
            ),
            Divider(
              height: 0,
              color: Colors.black,
            ),
            ListTile(
              title: Text("Petrol Price = $petrolPrice"),
              leading: Icon(
                Icons.local_gas_station_rounded,
              ),
              onTap: () {
                openDialog(petrolPString);
              },
            ),
            Divider(
              height: 0,
              color: Colors.black,
            ),
            ListTile(
              title: Text("Diesel Price = $dieselPrice"),
              leading: Icon(
                Icons.local_gas_station_rounded,
              ),
              onTap: () {
                openDialog(dieselPString);
              },
            ),
            Divider(
              height: 0,
              color: Colors.black,
            ),
            ListTile(
              title: Text("Stock = $stock ltr"),
              leading: Icon(
                Icons.store,
              ),
              onTap: () {
                openDialog(stockString);
              },
            ),
            Divider(
              height: 0,
              color: Colors.black,
            ),
            ListTile(
              title: Text("History"),
              leading: Icon(
                Icons.history,
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/history');
              },
            ),
            Divider(
              height: 0,
              color: Colors.black,
            ),
          ],
        ),
      ),
      body: Container(
          padding: EdgeInsets.only(top: 35, left: 20, right: 20),
          child: Column(
            children: [
              TextField(
                autofocus: true,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                keyboardType: TextInputType.number,
                controller: controllerSt,
                decoration: InputDecoration(
                  fillColor: Colors.black,
                  // label: Text("Enter"),
                  border: OutlineInputBorder(

                      //borderSide: BorderSide(color: Colors.yellow)
                      ),
                  hintText: 'Enter Starting Reading',
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                autofocus: true,
                keyboardType: TextInputType.number,
                controller: controllerEnd,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter End Reading',
                ),
              ),
              SizedBox(
                height: 80,
              ),
              TextButton(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                ),
                onPressed: () async {
                  DateTime? newDate = await showDatePicker(
                    context: context,
                    initialDate: selectedDate,
                    firstDate: DateTime(2022),
                    lastDate: DateTime(3000),
                  );
                  if (newDate == null) return;
                  setState(() {
                    selectedDate = newDate;
                    date =
                        '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}';
                  });
                  dDate = date;
                  print(dDate);
                },
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      child: Text("CALCULATE P"),
                      style: ElevatedButton.styleFrom(primary: Colors.teal),
                      onPressed: () {
                        setState(() {
                          showR = calculate(petrolPString);
                          print("Rs : $showR");
                          data.add(Cards(header: date, body: "body"));
                          addList(data: data);
                        });

                        print(data);
                        // String jsonData = jsonEncode(data);
                        // print(jsonData);
                        controllerSt.clear();
                        controllerEnd.clear();

                        // List<String> lists = data
                        //     .map((card) => jsonEncode(card.toJason()))
                        //     .toList();
                        // print(lists);
                      }),
                  ElevatedButton(
                      child: Text("CALCULATE D"),
                      style: ElevatedButton.styleFrom(primary: Colors.teal),
                      onPressed: () {
                        setState(() {
                          showR = calculate(dieselPString);
                          print("Rs: $showR");
                        });
                      }),
                ],
              ),
              SizedBox(
                height: 40,
              ),
              Text(
                "$showR",
                style: TextStyle(
                  fontSize: 40,
                ),
              ),
            ],
          )),
    );
  }

  Future openDialog(String title) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(title),
          content: TextField(
              autofocus: true,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              keyboardType: TextInputType.number,
              decoration: InputDecoration(hintText: "Enter new $title"),
              controller: controller,
              onSubmitted: (_) {
                submit(title);
              }),
          actions: [
            TextButton(
                child: Text("Submit"),
                onPressed: () {
                  setState(() {
                    submit(title);
                  });
                }),
          ],
        ),
      );
  void submit(String title) {
    if (controller.text.isEmpty) {
      print('Empty controller');
    } else {
      print("not empty");
      if (title == petrolPString) {
        petrolPrice = double.parse(controller.text);
      } else if (title == dieselPString) {
        dieselPrice = double.parse(controller.text);
      } else if (title == stockString) {
        stock = double.parse(controller.text);
      }

      setData();
    }
    Navigator.of(context).pop(controller.text);

    controller.clear();
  }

  double calculate(String type) {
    startRead = double.parse(controllerSt.text);
    finalRead = double.parse(controllerEnd.text);
    double diff = finalRead - startRead;
    double result;
    if (type == petrolPString) {
      result = diff * petrolPrice;
    } else {
      result = diff * dieselPrice;
    }
    return result;
  }

  Future<void> setData() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setDouble("petrolPrice", petrolPrice);
    pref.setDouble("dieselPrice", dieselPrice);
    pref.setDouble("stock", stock);
  }

  void addList({required List<Cards> data}) async {
    var box = await Hive.openBox('box');
    box.add(data);
    print(box);
    print(box.values);
    print("data entered");
  }

  Future<List<Cards>> getList() async {
    var box = await Hive.openBox('box');

    List<Cards> data1 = box.get("box")!;
    data = data1;
    return data;
  }

//TODO: get data from storage!!
  void getListTest() async {
    var box = await Hive.openBox('box');
    data = box.values as List<Cards>;
    // List<Cards> data12 = box.get(data);
    print(box.values);
  }

  void getData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    petrolPrice = pref.getDouble("petrolPrice")!;
    dieselPrice = pref.getDouble("dieselPrice")!;
    stock = pref.getDouble("stock")!;

    //  jsonData = pref.getString('dataString')!;
    print(petrolPrice);
    print(dieselPrice);
    setState(() {
      petrolPrice = petrolPrice;
      dieselPrice = dieselPrice;
      stock = stock;
    });
  }

  DataClass dataObj() {
    DataClass data = DataClass(startRead, finalRead, selectedDate, showR);
    return data;
  }

  String getDate() {
    return date;
  }
}

String dDate = _LandingScreenState().date;
void checkDate() {
  print(dDate);
}

List<Cards> data = [Cards(header: dDate, body: "body")];

//List<String> lists = data.map((card) => jsonEncode(card.toJason())).toList();
