import 'package:covid_traker/Models/WorldStateModel.dart';
import 'package:covid_traker/Servies/worldstate.dart';
import 'package:covid_traker/countries_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin{
late final AnimationController _controller =AnimationController(
  duration: const Duration(seconds: 3),
    vsync: this)..repeat();
@override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }
  final colorList =<Color>[
    const Color(0xff4285F4),
    const Color(0xff1aa260),
    const Color(0xffde5246)
  ];
  @override
  Widget build(BuildContext context) {
    StateServies stateServies = StateServies();

    return  Scaffold(
      body: SafeArea(
        child: Padding(
          padding:const EdgeInsets.all(15.0),
          child:SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * .01,),
               FutureBuilder(
                   future: stateServies.fatchData(),
                   builder:(context ,AsyncSnapshot<WorldStateModel> snapshot){
                     if(!snapshot.hasData){
                       return Expanded(
                           flex: 1,
                           child:SpinKitFadingCircle(
                             color: Colors.white,
                             size: 20,
                             controller: _controller,
                           ) );
                     }
                     else{
                       return Column(
                         children: [
                           PieChart(
                             dataMap: {
                               "Total ": double.parse(snapshot.data!.cases.toString()),
                               "Recovered ":double.parse(snapshot.data!.recovered.toString()),
                               "Deaths " :double.parse(snapshot.data!.deaths.toString())
                             },
                             chartValuesOptions:const ChartValuesOptions(
                               showChartValuesInPercentage: true
                             ),
                             chartRadius: MediaQuery.of(context).size.width/3.2,
                             legendOptions: const LegendOptions(
                                 legendPosition: LegendPosition.left
                             ),
                             chartType: ChartType.ring,
                             colorList: colorList,
                           ),
                           Padding(
                             padding:  EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.08),
                             child: Card(
                               child: Column(
                                 children: [
                                   ReuseableRow(title: 'Total', value: snapshot.data!.cases.toString()),
                                   ReuseableRow(title: 'Death', value: snapshot.data!.deaths.toString()),
                                   ReuseableRow(title: 'Recovered', value: snapshot.data!.recovered.toString()),
                                   ReuseableRow(title: 'Active ', value: snapshot.data!.active.toString()),
                                   ReuseableRow(title: 'Critical ', value: snapshot.data!.critical.toString()),
                                   ReuseableRow(title: 'Today Death ', value: snapshot.data!.todayDeaths.toString()),
                                   ReuseableRow(title: 'Today Recoverd ', value: snapshot.data!.todayRecovered.toString()),
                                 ],
                               ),
                             ),
                           ),
                           GestureDetector(
                                onTap: (){
                               Navigator.push(context, MaterialPageRoute(builder: (context) =>const CountriesList()));
                           },
                             child: Container(
                               height: 50,
                               decoration: BoxDecoration(
                                   borderRadius: BorderRadius.circular(10),
                                   color:const  Color(0xff1aa260)
                               ),
                               child:const  Center(child: Text('Track countries'),),
                             ),
                           )
                         ],
                       );
                     }
                   } ),
            
              ],
            ),
          ),
        ),
      ),
    );
  }
}
class ReuseableRow extends StatelessWidget {
  String title , value;
     ReuseableRow({super.key , required this.title , required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10 , right: 10 , top: 10 , bottom: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value)
            ],
          ),
        ),
        const SizedBox(height: 5,),
        const Divider()
      ],
    );
  }
}

