import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'package:prova_app/SmoothStarRating.dart';

import 'file:///C:/Users/franc/Documents/GitHub/MuSwift/misc/ColorLoader5.dart';

Future<String> loadMuseumAsset() async {
  return await rootBundle.loadString('assets/loadjson/infomusei.json');
}

Future wait(int seconds) {
  return new Future.delayed(Duration(seconds: seconds), () => {});
}

Future loadMuseum(String nome) async {
  await wait(5);
  String jsonString = await loadMuseumAsset();
  final jsonResponse = json.decode(jsonString);
  return new museo.fromJson(jsonResponse, nome);
}

class museo{
  String nome;
  String prezzo;
  String luogo;
  String orario;
  String numero;
  String sito;
  String storia;
  String immagine;

  museo({this.prezzo, this.luogo, this.orario, this.numero, this.sito, this.storia, this.immagine});

  factory museo.fromJson(Map<String, dynamic> parsedJson, String nome){
    return museo(
        prezzo: parsedJson[nome]['prezzo'],
        luogo: parsedJson[nome]['luogo'],
        orario: parsedJson[nome]['orario'],
        numero: parsedJson[nome]['numero'],
        sito: parsedJson[nome]['sito'],
        storia: parsedJson[nome]['storia'],
        immagine: parsedJson[nome]['immagine'],
    );
  }
}

museo Museo = new museo();

Container infoRow(IconData icon, String label){
  return Container(
    margin: EdgeInsets.only(top: 15),
    child: Row(
      children: [
        Icon(
          icon,
          size: 30,
        ),
        Container(
          margin: EdgeInsets.only(left: 10),
          child: Text(
            label,
            style: TextStyle(
                fontSize: 20
            ),
          ),
        )
      ],
    ),
  );
}
Container noteRow(IconData icon, String label){
  return Container(
    child: Row(
      children: [
        Icon(
          icon,
          size: 20,
        ),
        Container(
          margin: EdgeInsets.only(left: 5),
          child: Text(
            label,
            style: TextStyle(
                fontSize: 20
            ),
          ),
        )
      ],
    ),
  );
}

class InsideTabBar extends StatefulWidget {
  @override
  _InsideTabBarState createState() => _InsideTabBarState();
}

class _InsideTabBarState  extends State<InsideTabBar> with TickerProviderStateMixin{

  TabController _insideTabController;

  void initState() {
    super.initState();

    _insideTabController = new TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _insideTabController.dispose();
  }

  Widget opereTab = Container(
    child: Text("Pagina delle opere"),
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          controller: _insideTabController,
          indicatorColor: Colors.blue,
          labelColor: Colors.blue,
          unselectedLabelColor: Colors.black,
          tabs: <Widget>[
            Tab(
              child: Text(
                "INFORMAZIONI",
                style: TextStyle(
                    fontSize: 20
                ),
              ),
            ),
            Tab(
              child: Text(
                "OPERE",
                style: TextStyle(
                    fontSize: 20
                ),
              ),
            ),
          ],
        ),
        Container(
          //SISTEMARE ALTEZZA
          height: MediaQuery. of(context). size. height - 454,
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: TabBarView(
            controller: _insideTabController,
            children: [
              Container(
                child: ListView(
                  children: [
                    infoRow(Icons.confirmation_num, "Prezzo biglietto " + Museo.prezzo + "€"),
                    infoRow(Icons.map, Museo.luogo),
                    GestureDetector(
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => schedulePage()),
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.only(top: 15),
                          child: Row(
                            children: [
                              Icon(
                                Icons.schedule,
                                size: 30,
                              ),
                              Expanded(
                                  child: Container(
                                    margin: EdgeInsets.only(left: 10),
                                    child: Text(
                                      Museo.orario,
                                      style: TextStyle(
                                          fontSize: 20
                                      ),
                                    ),
                                  )
                              ),
                              Icon(
                                Icons.navigate_next_sharp,
                                size: 30,
                              )
                            ],
                          ),
                        )
                    ),
                    infoRow(Icons.call, Museo.numero),
                    infoRow(Icons.web, Museo.sito),
                    SizedBox(height: 10,),
                    Divider(color: Colors.black),
                    SizedBox(height: 10,),
                    Text(Museo.storia,
                        maxLines: 3,
                        style: TextStyle(
                            fontSize: 20
                        )
                    ),
                    SizedBox(height: 5,),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                              onTap: (){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => storyPage()),
                                );
                              },
                              child: Text(
                                "...leggi di più",
                                style: TextStyle(
                                    fontSize: 20
                                ) ,
                              )
                          )
                        ]
                    ),
                    SizedBox(height: 10,),
                    Divider(color: Colors.black),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                            flex: 5,
                            child: Center(
                                child: ElevatedButton(
                                    onPressed: () {
                                      // Respond to button press
                                    },
                                    child: Container(
                                      width: 150,
                                      child: Text(
                                          "MAPPA",
                                          textAlign: TextAlign.center
                                      ),
                                    )
                                )
                            )
                        ),
                        Expanded(
                            flex: 5,
                            child: Center(
                                child: ElevatedButton(
                                    onPressed: () {
                                    },
                                    child: Container(
                                      width: 150,
                                      child: Text(
                                        "PRENOTA",
                                        textAlign: TextAlign.center,
                                      ),
                                    )
                                )
                            )
                        )
                      ],
                    ),
                    SizedBox(height: 10,),
                    Text(
                      "Note aggiuntive: ",
                      style: TextStyle(
                          fontSize: 20
                      ),
                    ),
                    SizedBox(height: 10,),
                    noteRow(Icons.check, "Adibito per disabili"),
                    noteRow(Icons.check, "Visita interattiva"),
                    noteRow(Icons.check, "Percheggio a pagamento"),
                    noteRow(Icons.check, "Presenza guida"),
                  ],
                ),
              ), // INFORMAZIONI
              Container(
                child: GridView.count(
                  padding: const EdgeInsets.only(top: 10),
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  crossAxisCount: 2,
                  children: [
                    GestureDetector(
                      onTap: (){

                      },
                      child: Container( // primo elemento della prima lista di opere
                          margin: EdgeInsets.only(right: 10.0), // il bordo tra un'opera e l'altra
                          width: 145,
                          decoration: BoxDecoration(
                            color: Colors.purple[600],
                            borderRadius: new BorderRadius.all( // per i bordi arrotondati
                              new Radius.circular(5.0)
                            ),
                            image: new DecorationImage( // per metterci l'immagine dentro
                              image: new ExactAssetImage(Museo.immagine),
                              fit: BoxFit.cover, // per adattarla al container
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                offset: Offset(0.0, 1.0), //(x,y)
                                blurRadius: 6.0,
                              )
                            ],
                        ),
                        child: Align( // per allineare la scritta in una posizione specifica
                          alignment: Alignment(-0.40, 0.90),
                          child: Text("Deposizione", style: TextStyle(fontSize: 18, color: Colors.white),)
                        ),
                      ),
                    ),
                  ],
                ),
              ), // OPERE
            ],
          ),
        )
      ],
    );
  }
}

class museumPage extends StatelessWidget {
  //DA IMPLEMENTARE
  //var my_data = json.decode(await getJson());
  String title;
  double rate;

  //DetailScreen({Key key, @required this.todo}) : super(key: key);
  //Museo({Key key, @required this.title}) : super(key: key);
  museumPage(String title, String img, double rat){
    this.title = title;
    this.rate = rat;
    print(this.rate);
    Museo.immagine = img;
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Widget topPage = Container(
        padding: const EdgeInsets.all(10),
        width: double.infinity,
        height: 300,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Museo.immagine),
            fit: BoxFit.cover,
          ),
        ),
        child:
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: (){
                Navigator.pop(context);
              },
              child: Icon(
                  Icons.arrow_drop_down,
                  color: Colors.white,
                  size: 35
              ),
            ),
            Expanded(child: Container()),
            Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                          fontSize: 40,
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    Container(
                      child: SmoothStarRating(
                          allowHalfRating: false,
                          starCount: 5,
                          rating: rate,
                          size: 40.0,
                          color: Colors.white,
                          halfFilledIconData: Icons.star_half_outlined,
                          borderColor: Colors.white,
                          spacing:0.0
                      ),
                    )
                  ],
                )
            ),
          ],
        )
    );

    return FutureBuilder(
        future: loadMuseum(title),
        builder: (context, snapshot){
          if (snapshot.hasData) {
            Museo = snapshot.data;
            print(Museo.immagine);

            return SafeArea(
                child:
                Scaffold(
                  body: Column(
                    children: [
                      topPage,
                      InsideTabBar(),
                    ],
                  ),
                )
            );
          }
          else return new SafeArea(
              child:
              Scaffold(
                body: Column(
                  children: [
                    topPage,
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 100,),
                        Text("Caricamento",
                            style: TextStyle(
                                fontSize: 25
                            )
                        ),
                        SizedBox(height: 20,),
                        ColorLoader5(
                          dotOneColor: Colors.redAccent,
                          dotTwoColor: Colors.blueAccent,
                          dotThreeColor: Colors.green,
                          dotType: DotType.circle,
                          dotIcon: Icon(Icons.museum_outlined),
                          duration: Duration(seconds: 1),
                        )
                      ],
                    ),
                  ],
                ),
              )
          );
        }
    );
  }
}

class storyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('TORNIAMO INDIETRO'),
        ),
      ),
    );
  }
}

class schedulePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('TORNIAMO INDIETRO'),
        ),
      ),
    );
  }
}