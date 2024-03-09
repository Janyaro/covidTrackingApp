import 'package:covid_traker/Servies/worldstate.dart';
import 'package:covid_traker/detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CountriesList extends StatefulWidget {
  const CountriesList({super.key});

  @override
  State<CountriesList> createState() => _CountriesListState();
}

class _CountriesListState extends State<CountriesList> {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    StateServies stateServies = StateServies();

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor:Theme.of(context).scaffoldBackgroundColor ,
      ),
      body: SafeArea(
        child: Column(
          children: [
         Padding(
           padding: const EdgeInsets.all(8.0),
           child: TextFormField(
             controller: searchController,
           onChanged: (value){
               setState(() {

               });
           },
           decoration: InputDecoration(
             contentPadding:const EdgeInsets.symmetric(horizontal: 20),
             hintText: 'Search Country',
             border: OutlineInputBorder(
               borderRadius: BorderRadius.circular(50),
             )
           ),
           ),
         ),
            Expanded(
                child: FutureBuilder(
              future: stateServies.fatchCountries(),
                  builder: (context , AsyncSnapshot<List<dynamic>> snapshot){
                if(!snapshot.hasData){
                  return Shimmer.fromColors(
                      child: ListView.builder(itemBuilder: (context , index){
                        return  Column(
                          children: [
                            ListTile(
                              leading: Container(height: 50 , width: 50, color: Colors.white, ),
                              title: Container(height: 10 , width: 89, color: Colors.white, ),
                              subtitle: Container(height: 10 , width: 89, color: Colors.white, ),
                            )
                          ],
                        );
                      }),
                      baseColor: Colors.grey.shade700,
                      highlightColor:Colors.grey.shade100);
                }else{
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                    itemBuilder:(context , index){
                    String name = snapshot.data![index]['country'];
                    if(searchController.text.isEmpty){
                      return Column(
                        children: [
                          InkWell(
                            onTap:(){
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => DetailScreen(
                                    name : snapshot.data![index]['country'],
                                    image: snapshot.data![index]['countryInfo']['flag'],
                                    cases :snapshot.data![index]['cases'],
                                    active:snapshot.data![index]['active'],
                                    deaths:snapshot.data![index]['deaths'],
                                    recovered:snapshot.data![index]['recovered'],
                                    critical:snapshot.data![index]['critical'],

                                    population:snapshot.data![index]['population'],

                                  )));
                            },
                            child: ListTile(
                              leading: Image(
                                height : 50 ,
                                width: 50,
                                image: NetworkImage(snapshot.data![index]['countryInfo']['flag']),
                              ),
                              title: Text(snapshot.data![index]['country']),
                              subtitle: Text(snapshot.data![index]['cases'].toString()),
                            ),
                          )
                        ],
                      );      
                    }else if(name.toLowerCase().contains(searchController.text.toLowerCase())){
                      return Column(
                        children: [
                          InkWell(
                            onTap:(){
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => DetailScreen(
                                    name : snapshot.data![index]['country'],
                                    image: snapshot.data![index]['countryInfo']['flag'],
                                    cases :snapshot.data![index]['cases'],
                                    active:snapshot.data![index]['active'],
                                    deaths:snapshot.data![index]['deaths'],
                                    recovered:snapshot.data![index]['recovered'],
                                    critical:snapshot.data![index]['critical'],

                                    population:snapshot.data![index]['population'],

                                  )));
                            },
                            child: ListTile(
                              leading: Image(
                                height : 50 ,
                                width: 50,
                                image: NetworkImage(snapshot.data![index]['countryInfo']['flag']),
                              ),
                              title: Text(snapshot.data![index]['country']),
                              subtitle: Text(snapshot.data![index]['cases'].toString()),
                            ),
                          )
                        ],
                      );
                    }else{
                      return Container();
                    }
                
                });
                }
                  },
            ))
          ],
        ),
      ),
    );
  }
}
