import 'dart:convert';

import 'package:covid_traker/Models/WorldStateModel.dart';
import 'package:covid_traker/Servies/Utilites/appurl.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http ;
class StateServies{
  Future<WorldStateModel> fatchData () async {
    final response = await http.get(Uri.parse(AppUrl.worldbaseUrl));
    if(response.statusCode ==200){
    var data = jsonDecode(response.body);
    return WorldStateModel.fromJson(data);
    }else{
      throw Exception('Error');
    }
  }
  Future<List<dynamic>> fatchCountries () async {

    var data;
    final response =await http.get(Uri.parse(AppUrl.countrybaseUrl));
    if(response.statusCode == 200){
     data = jsonDecode(response.body);

    return data;
    }else{
    throw Exception('Error');
    }
  }
}