import 'package:cached_network_image/cached_network_image.dart';
import 'dart:convert';
import 'package:fitnessapp/screens/exercise_start_screen.dart';
import 'package:http/http.dart' as http;
import 'package:fitnessapp/screens/exercisehub_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final String apiUrl =
      'https://raw.githubusercontent.com/codeifitech/fitness-app/master/exercises.json';

  ExerciseHub exerciseHub;

  @override
  void initState() {
    getExercises();
    super.initState();
  }

  void getExercises() async {
    var response = await http.get(apiUrl);
    var body = response.body;
    var decodedJson = jsonDecode(body);

    exerciseHub = ExerciseHub.fromJson(decodedJson);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fitness App'),
      ),
      body: Container(
          child: exerciseHub != null
              ? ListView(
                  children: exerciseHub.exercises.map((e) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ExerciseStartScreen(
                                      exercises: e,
                                    )));
                      },
                      child: Hero(
                        tag: e.id,
                        child: Container(
                            margin: EdgeInsets.all(15),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20)),
                            child: Stack(children: <Widget>[
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                // child: FadeInImage(
                                //  placeholder:
                                //      AssetImage('assets/placeholder.jpg'),
                                //  image: NetworkImage(e.thumbnail),
                                //  width: MediaQuery.of(context).size.width,
                                //  height: 250,
                                //  fit: BoxFit.cover,
                                //)
                                child: CachedNetworkImage(
                                  imageUrl: e.thumbnail,
                                  placeholder: (context, url) => Image(
                                    image: AssetImage("assets/placeholder.jpg"),
                                    fit: BoxFit.cover,
                                    height: 250,
                                    width: MediaQuery.of(context).size.width,
                                  ),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                  fit: BoxFit.cover,
                                  height: 250,
                                  width: MediaQuery.of(context).size.width,
                                ),
                              ),
                              ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 250,
                                    decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                            colors: [
                                          Color(0xFF000000),
                                          Color(0x00000000),
                                        ],
                                            begin: Alignment.bottomCenter,
                                            end: Alignment.center)),
                                  )),
                              Container(
                                height: 250,
                                margin: EdgeInsets.only(left: 10, bottom: 25),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 20),
                                alignment: Alignment.bottomLeft,
                                child: Text(
                                  e.title,
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            ])),
                      ),
                    );
                  }).toList(),
                )
              : LinearProgressIndicator()),
    );
  }
}
