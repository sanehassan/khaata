import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

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

  late TextEditingController controller;
  late TextEditingController controllerStartPetrol;
  late TextEditingController controllerEndPetrol;
  late TextEditingController controllerStartDiesel;
  late TextEditingController controllerEndDiesel;
  late double petrolSale = 0.0;
  late double dieselSale = 0.0;
  late double petrolStock = 0;
  late double dieselStock = 0;
  late double newPetrolReading = 0;
  late double newDieselReading = 0;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
    controllerStartPetrol = TextEditingController();
    controllerEndPetrol = TextEditingController();
    controllerStartDiesel = TextEditingController();
    controllerEndDiesel = TextEditingController();

    // getListTest();
    //setHistory(Cards(header: date, body: 'body'));
    getData();
    controllerStartPetrol.text = newPetrolReading.toString();
    controllerStartDiesel.text = newDieselReading.toString();
    hiss = [];
    getHistory();
    print(newPetrolReading);

    // getList();
  }

  @override
  void dispose() {
    controller.dispose();
    // controllerEndPetrol.dispose();
    //controllerStartPetrol.dispose();
    //  controllerStartDiesel.dispose();
    //  controllerEndDiesel.dispose();
    super.dispose();
  }

  double finalReadPetrol = 0.0;
  double startReadPetrol = 0.0;
  double finalReadDiesel = 0.0;
  double dieselPrice = 0;

  double startReadDiesel = 0.0;
  String petrolStockString = "PetrolStock";
  String dieselStockString = "DieselSock";
  String dieselPString = "Diesel Price";
  String petrolPString = "Petrol Price";
  double petrolPrice = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Pump",
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
              title: Text("Petrol Stock = $petrolStock ltr"),
              leading: Icon(
                Icons.store,
              ),
              onTap: () {
                openDialog(petrolStockString);
              },
            ),
            Divider(
              height: 0,
              color: Colors.black,
            ),
            ListTile(
              title: Text("Diesel Stock = $dieselStock ltr"),
              leading: Icon(
                Icons.store,
              ),
              onTap: () {
                openDialog(dieselStockString);
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
      body: SingleChildScrollView(
        child: Container(
            padding: EdgeInsets.only(top: 35, left: 20, right: 20),
            child: Column(
              children: [
                TextField(
                  autofocus: true,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(
                        RegExp(r'^(\d+)?\.?\d{0,7}'))
                  ],
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  controller: controllerStartPetrol,
                  decoration: InputDecoration(
                    fillColor: Colors.black,
                    // errorText: field1Validate(),
                    // label: Text("Enter"),
                    border: OutlineInputBorder(

                        //borderSide: BorderSide(color: Colors.yellow)
                        ),
                    hintText: 'Enter Start Reading Petrol',
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  autofocus: true,
                  keyboardType: TextInputType.number,
                  controller: controllerEndPetrol,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(
                        RegExp(r'^(\d+)?\.?\d{0,7}'))
                  ],
                  decoration: InputDecoration(
                    // errorText: field2Validate(),
                    border: OutlineInputBorder(),
                    hintText: 'Enter End Reading Petrol',
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  autofocus: true,
                  keyboardType: TextInputType.number,
                  controller: controllerStartDiesel,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(
                        RegExp(r'^(\d+)?\.?\d{0,7}'))
                  ],
                  decoration: InputDecoration(
                    // errorText: field3Validate(),
                    border: OutlineInputBorder(),
                    hintText: 'Enter Start Reading Diesel',
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  autofocus: true,
                  keyboardType: TextInputType.number,
                  controller: controllerEndDiesel,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(
                        RegExp(r'^(\d+)?\.?\d{0,7}'))
                  ],
                  decoration: InputDecoration(
                    // errorText: field4Validate(),
                    border: OutlineInputBorder(),
                    hintText: 'Enter End Reading Diesel',
                  ),
                ),
                SizedBox(
                  height: 50,
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
                Align(
                  alignment: Alignment.centerRight,
                  child: Text('Petrol Price = $petrolPrice'),
                ),
                SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text('Diesel Price = $dieselPrice'),
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    child: Text("CALCULATE"),
                    style: ElevatedButton.styleFrom(primary: Colors.teal),
                    onPressed: () {
                      setState(() {
                        calculate();
                        setData();
                        print(startReadPetrol);
                        print(newPetrolReading);

                        print("Rs : $petrolSale");
                        // data.add(Cards(
                        //     header: date, body: "body", isExpanded: false));

                        setHistory(Cards(
                          header: "$date",
                          initialPetrolReading: "$startReadPetrol",
                          endingPetrolReading: '$finalReadPetrol',
                          currentPetrolPrice: petrolPrice.toString(),
                          petrolSale: '$petrolSale',
                          initialDieselReading: '$startReadDiesel',
                          endingDieselReading: '$finalReadDiesel',
                          currentDieselPrice: dieselPrice.toString(),
                          dieselSale: '$dieselSale',
                          petrolStock: '$petrolStock',
                          dieselStock: '$dieselStock',
                        ));
                        //addList(data: data);
                      });
                      showDialog(
                          context: context,
                          builder: (context) {
                            return Dialog(
                              elevation: 16,
                              child: Container(
                                padding: EdgeInsets.all(16),
                                height: 370.0,
                                width: 360.0,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Initial Petrol Reading"),
                                        Text(startReadPetrol.toString()),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Final Petrol Reading"),
                                        Text(finalReadPetrol.toString())
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Petrol Sale"),
                                        Text('$petrolSale Rs')
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Remaining Petrol Stock "),
                                        Text('$petrolStock ltr')
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Initial Diesel Reading"),
                                        Text(startReadDiesel.toString())
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Final Diesel Reading"),
                                        Text(finalReadDiesel.toString())
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Diesel Sale"),
                                        Text('$dieselSale Rs')
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Remaining Diesel Stock "),
                                        Text('$dieselStock ltr')
                                      ],
                                    ),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    Text(
                                      'Data Saved Successfully',
                                      style: TextStyle(fontSize: 20),
                                    )
                                  ],
                                ),
                              ),
                            );
                          });
                      // print(data);
                      // String jsonData = jsonEncode(data);
                      // print(jsonData);
                      controllerStartPetrol.text = finalReadPetrol.toString();
                      controllerEndPetrol.clear();
                      controllerStartDiesel.text = finalReadDiesel.toString();
                      controllerEndDiesel.clear();

                      // List<String> lists = data
                      //     .map((card) => jsonEncode(card.toJason()))
                      //     .toList();
                      // print(lists);
                    }),
              ],
            )),
      ),
    );
  }

  // String? emptyFieldValidate() {
  //   final startReadValidatorP = controllerStartPetrol.value.text;
  //   final endReadValidatorP = controllerEndPetrol.value.text;
  //   final startReadValidatorD = controllerStartDiesel.value.text;
  //   final endReadValidatorD = controllerEndDiesel.value.text;
  //   if (startReadValidatorP.isEmpty ||
  //       endReadValidatorP.isEmpty ||
  //       endReadValidatorD.isEmpty ||
  //       startReadValidatorD.isEmpty) {
  //     return 'Fields must not be empty';
  //   } else
  //     return null;
  // }
  //
  // String? field1Validate() {
  //   final startReadValidatorP = controllerStartPetrol.value.text;
  //   if (startReadValidatorP.isEmpty) {
  //     return 'Fields must not be empty';
  //   } else
  //     return null;
  // }
  //
  // String? field3Validate() {
  //   final startReadValidatorD = controllerStartDiesel.value.text;
  //   if (startReadValidatorD.isEmpty) {
  //     return 'Fields must not be empty';
  //   } else
  //     return null;
  // }
  //
  // String? field2Validate() {
  //   final startReadValidatorP = controllerStartPetrol.value.text;
  //   final endReadValidatorP = controllerEndPetrol.value.text;
  //   if (double.parse(endReadValidatorP) < double.parse(startReadValidatorP)) {
  //     return "Final reading must be greater";
  //   } else
  //     return null;
  // }
  //
  // String? field4Validate() {
  //   final startReadValidatorD = controllerStartDiesel.value.text;
  //   final endReadValidatorD = controllerEndDiesel.value.text;
  //   if (double.parse(endReadValidatorD) < double.parse(startReadValidatorD)) {
  //     return "Final reading must be greater";
  //   } else
  //     return null;
  // }
  //
  // String? finalReadValidate() {
  //   final startReadValidatorP = controllerStartPetrol.value.text;
  //   final endReadValidatorP = controllerEndPetrol.value.text;
  //   final startReadValidatorD = controllerStartDiesel.value.text;
  //   final endReadValidatorD = controllerEndDiesel.value.text;
  //   if (double.parse(endReadValidatorP) < double.parse(startReadValidatorP) ||
  //       double.parse(endReadValidatorD) < double.parse(startReadValidatorD)) {
  //     return "Final reading must be greater";
  //   } else
  //     return null;
  // }

  Future openDialog(String title) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(title),
          content: TextField(
              autofocus: true,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,7}'))
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
      } else if (title == petrolStockString) {
        petrolStock = double.parse(controller.text);
      } else if (title == dieselStockString) {
        dieselStock = double.parse(controller.text);
      }

      setData();
    }
    Navigator.of(context).pop(controller.text);

    controller.clear();
  }

  void calculate() {
    startReadPetrol = double.parse(controllerStartPetrol.text);
    finalReadPetrol = double.parse(controllerEndPetrol.text);
    startReadDiesel = double.parse(controllerStartDiesel.text);
    finalReadDiesel = double.parse(controllerEndDiesel.text);
    double differenceInPetrolReadings = finalReadPetrol - startReadPetrol;
    double differenceInDieselReadings = finalReadDiesel - startReadDiesel;
    setState(() {
      petrolStock = petrolStock - differenceInPetrolReadings;
      dieselStock = dieselStock - differenceInDieselReadings;
      newPetrolReading = finalReadPetrol;
      newDieselReading = finalReadDiesel;
      print(newPetrolReading);
      setData();
    });

    petrolSale = differenceInPetrolReadings * petrolPrice;
    dieselSale = differenceInDieselReadings * dieselPrice;
  }

  Future<void> setData() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setDouble("petrolPrice", petrolPrice);
    pref.setDouble("dieselPrice", dieselPrice);
    pref.setDouble("petrolStock", petrolStock);
    pref.setDouble("dieselStock", dieselStock);
    pref.setDouble("newInitialPetrolReading", newPetrolReading);
    pref.setDouble("newInitialDieselReading", newDieselReading);

    //List<Cards> history = data;
  }

  void getData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    petrolPrice = pref.getDouble("petrolPrice")!;
    dieselPrice = pref.getDouble("dieselPrice")!;
    petrolStock = pref.getDouble("petrolStock")!;
    dieselStock = pref.getDouble("dieselStock")!;
    newDieselReading = pref.getDouble("newInitialDieselReading")!;
    newPetrolReading = pref.getDouble("newInitialPetrolReading")!;
    print(newPetrolReading);

    //  jsonData = pref.getString('dataString')!;
    print(petrolPrice);
    print(dieselPrice);
    setState(() {
      petrolPrice = petrolPrice;
      dieselPrice = dieselPrice;
      petrolStock = petrolStock;
      dieselStock = dieselStock;
      controllerStartPetrol.text = newPetrolReading.toString();
      controllerStartDiesel.text = newDieselReading.toString();
    });
  }

  String getDate() {
    return date;
  }
}

String dDate = _LandingScreenState().date;
void checkDate() {
  print(dDate);
}

void setHistory(Cards card) async {
  SharedPreferences pref = await SharedPreferences.getInstance();

  // List<Cards> entries = data;
  hiss.add(card);
  final String entriesJson = jsonEncode(hiss.map((e) => e.toJson()).toList());
  pref.setString('history', entriesJson);

  // final String savedEntriesJson = pref.getString('history')!;
  // final List<dynamic> entriesDeserialized = jsonDecode(savedEntriesJson);
  // List<Cards> deserializedEntries =
  //     entriesDeserialized.map((map) => Cards.fromMap(map)).toList();
  // print(deserializedEntries);
}

//List<Cards> data = [Cards(header: dDate, body: 'body', isExpanded: false)];
late List<Cards> hiss;
//List<String> lists = data.map((card) => jsonEncode(card.toJason())).toList();
Future getHistory() async {
  SharedPreferences pref = await SharedPreferences.getInstance();

  final String savedEntriesJson = pref.getString('history')!;

  print(savedEntriesJson);
  final List<dynamic> entriesDeserialized = jsonDecode(savedEntriesJson);
  List<Cards> deserializedEntries =
      entriesDeserialized.map((map) => Cards.fromMap(map)).toList();

  hiss = deserializedEntries;

  print(deserializedEntries);
  return deserializedEntries;
}
