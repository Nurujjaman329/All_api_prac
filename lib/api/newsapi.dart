

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'newsapimodel.dart';



class Newsapipractise extends StatefulWidget {
  const Newsapipractise({super.key});

  @override
  State<Newsapipractise> createState() => _NewsapipractiseState();
}

class _NewsapipractiseState extends State<Newsapipractise> {

 // Api data collect
  Future<Newsapi> getapi() async {
    final response = await http.get(Uri.parse("https://newsapi.org/v2/everything?q=tesla&from=2023-09-03&sortBy=publishedAt&apiKey=7d295814715d4a13a323d58a16e5a863"));

    var data = jsonDecode(response.body.toString());

    if(response.statusCode == 200){
      return Newsapi.fromJson(data);
    }
    else return Newsapi.fromJson(data);

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("NewsApi_Practise"),
      ),

      body: FutureBuilder<Newsapi>(
        future: getapi(),
        builder: (context,snapshot){
          if(snapshot.hasData){
            return ListView.builder(
                itemCount: snapshot.data?.articles?.length,
                itemBuilder:(context, index){
                  return Column(
                    children: [
                      ListTile(
                        title: Text(snapshot.data!.articles![index].author.toString()),
                      leading: CircleAvatar(
                        child: Image.network(snapshot.data!.articles![index].urlToImage.toString()),
                      ) ,

                      ),
                    ],
                  );
                });
          }
          else {
            return const Text("Loaded");
          }
        },

      )
    );
  }
}
