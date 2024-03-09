import 'package:covid_traker/homescreem.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  String name;
  String image;
  int cases;
  int active;
  int deaths;
  int recovered;
  int critical;
  int population;
   DetailScreen({super.key,
    required this.cases,
    required this.critical,
    required this.recovered,
    required this.deaths,
    required this.name,
    required this.image,
    required this.population,
    required this.active
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
      centerTitle: true, ),
body: Card(
  child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Stack(
        children: [
          Padding(
            padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.078),
            child: Card(
              child: Column(
                children: [
                  ReuseableRow(title: 'Total Cases', value: widget.cases.toString()),
                  ReuseableRow(title: 'Active', value: widget.active.toString()),
                  ReuseableRow(title: 'Death', value: widget.deaths.toString()),
                  ReuseableRow(title: 'Recovered', value: widget.recovered.toString()),
                  ReuseableRow(title: 'Critical', value: widget.critical.toString()),
                  ReuseableRow(title: 'Population', value: widget.population.toString()),

                ],
              ),
            ),
          ),
          Center(
            child: CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(widget.image),
            ),
          )
        ],
      ),
      //

    ],
  ),
),

    );
  }
}
