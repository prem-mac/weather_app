import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:weather_app/additional_info_item.dart';
import 'package:weather_app/hourly_forcast_item.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/secrets.dart';
class weatherscreen extends StatefulWidget {
  const weatherscreen({super.key});

  @override
  State<weatherscreen> createState() => _weatherscreenState();
}

class _weatherscreenState extends State<weatherscreen> {
  double temp=270;

  @override
  void initState(){
    super.initState();
    getcurrentweather();
  }
     Future getcurrentweather() async{
      try{
   String cityname ='noida';
    final res=  await http.get(
        Uri.parse('https://api.openweathermap.org/data/2.5/forecast?q=$cityname&APPID=$openweatherapikey',
),
      );
      final data = jsonDecode(res.body);
      if(data['cod']!='200'){
        throw 'an unexpected error occured';
      }
      setState(() {
        temp= (data['list'][0]['main']['temp']);
        
      });
     
      
      }
      catch(e){
        throw e.toString();
      }
     }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text('Weather App',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed:(){},
              icon: const Icon(Icons.refresh),
              )
        ],
      ),
      body: temp== 0 
      ?Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          //main card
          SizedBox(
            width: double.infinity,
            child: Card(
              elevation: 100,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16)),
              child:ClipRRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: 10,
                    sigmaY: 10,
                  ),
                  child:  Padding(
                    padding:  EdgeInsets.all(16.0),
                    child: Column(
                      children: [Text('$temp K',
                      style:const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        ),
                        ),
                        const SizedBox(height: 16),
                      const Icon(
                          Icons.cloud,
                          size: 64,
                        ),
                       const   SizedBox(height: 16),
                       const Text(
                          'Rain',
                          style: TextStyle(
                            fontSize: 20,
                            ),
                            ),
                      ],
                      ),
                  ),
                ),
              ) ,
            ),
          ),
          const SizedBox(height: 20),
           const Text('Weather Forecast',
            style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,  
            ),
             ),
             const SizedBox(height: 10),
            const SingleChildScrollView(
              scrollDirection: Axis.horizontal,
               child: Row(
                children: [
                   HourlyForCastItem(
                    time: '00:00',
                    icon: Icons.cloud,
                    temperature: '301.22',
                   ),HourlyForCastItem(
                    time: '03:00',
                    icon: Icons.sunny,
                    temperature: '302.',
                   ),HourlyForCastItem(
                    time: '06:00',
                    icon: Icons.sunny,
                    temperature: '305.22',
                   ),HourlyForCastItem(
                    time: '09:00',
                    icon: Icons.cloud,
                    temperature: '289.25',
                   ),HourlyForCastItem(
                    time: '12:00',
                    icon: Icons.cloud,
                    temperature: '301.22',
                   ),
                ],       
               ),
             ),
          // weather forcost cards
          
          const SizedBox(height: 20),
          // additional information
          const Text('Additional Information',
            style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,  
            ),
             ),
             const SizedBox(height: 8),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
             children: [
              aditionaliinfoitem(
                icon: Icons.water_drop,
                label: 'Humidity',
                value: '91',
              ),
              aditionaliinfoitem(
                icon: Icons.air,
                label: 'Wind Speed',
                value: '7.5',
              ),
              aditionaliinfoitem(
                icon: Icons.beach_access,
                label: 'Pressure' ,
                value: '1000',
              ),
              
             ], 
             ),
        ],
        ),
      ),
    );
  }
}

