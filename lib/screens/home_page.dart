import 'dart:async';

import 'package:flutter/material.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State createState() => _HomePageState();
}

class _HomePageState extends State {

  int  s=0,m=0,h=0;
  String digSec="00", digMin="00",digHr="00";
  Timer? timer;
  bool started = false;

  List Laps=[];

  // stop Function

  void stop()
  {
    timer!.cancel();
    setState(() {
      started=false;
    });
  }

  // reset Function

  void reset()
  {
    timer!.cancel();
    setState(() {
      s=0;m=0;h=0;
      digSec="00"; digMin="00";digHr="00";
      Laps.clear();
      started=false;
    });
  }

  // adding Laps Function

  void addlap()
  {
    String lap = "$digHr:$digMin:$digSec";
    setState(() {
      Laps.add(lap);
    });
  }

  //  start Function

  void start()
  {
    started=true;
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      int localsec=s+1;
      int localmin = m;
      int localhours = h;
      if(localsec >59)
      {
        if(localmin >59)
        {
          localhours++;
          localmin=0;
        }
        else
        {
          localmin++;
          localsec=0;
        }
      }

      setState(() {
        s=localsec;
        m=localmin;
        h=localhours;

        digSec = (s>=10)?"$s":"0$s";
        digMin = (m>=10)?"$m":"0$m";
        digHr = (h>=10)?"$h":"0$h";

      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const  Color(0xFF242526),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child:Container(
                  decoration: const BoxDecoration(
                    color: Color(0xFF4b515d),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: '$digHr:',
                            style: const TextStyle(
                              color: Color(0xFFbb86fc),
                              fontSize: 55.0,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          TextSpan(
                            text: '$digMin:',
                            style: const TextStyle(
                              color:Color(0xFF03dac6),
                              fontSize: 55.0,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          TextSpan(
                            text: '$digSec',
                            style:const  TextStyle(
                              color:Color(0xFFcf6679),
                              fontSize: 55.0,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

              ),
              const SizedBox(height: 25,),

              // lap display tile

              Expanded(
                child: ListView.builder(
                    itemCount: Laps.length,
                    itemBuilder: (context,index)
                    {
                       return Card(
                         color: const Color(0xff3a3b3c),
                         shape: RoundedRectangleBorder(
                           borderRadius: BorderRadius.circular(12.0),
                         ),
                         child: Padding(
                           padding: const EdgeInsets.all(8.0),
                           child: ListTile(
                             title: Text("${Laps[index]}",style: const TextStyle(fontSize: 18.0, color: Colors.white70,fontWeight: FontWeight.w800),),
                             leading: CircleAvatar(radius: 30,
                               backgroundColor: Colors.white12,
                               child: Text("Lap ${index+1}",style: const TextStyle(fontSize: 13.0, color: Colors.white70,fontWeight: FontWeight.w800,letterSpacing: 0.2),),
                             ),
                           ),
                         ),
                       );
                    }
                ),
              ),

              const SizedBox(height: 20.0,),


              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(

                    // start and stop

                      child: RawMaterialButton(
                        onPressed: () {
                          (!started) ? start() : stop();
                        },
                        shape: const StadiumBorder(side: BorderSide(color: Colors.white,),),
                        child: Text(
                          (!started) ? "Start" : "Stop",
                          style: TextStyle(color: (!started) ? Colors.white : Colors.red, fontWeight: FontWeight.w800,),),)
                  ),

                  const SizedBox(width: 8.0,),

                  // add lap

                  IconButton(
                    onPressed: (){
                      addlap();
                    },
                    icon: const Icon(Icons.flag, color: Colors.white,),
                  ),
                  const SizedBox(width: 8.0,),

                  // restart

                  Expanded(
                      child: RawMaterialButton(
                        onPressed: (){
                          reset();
                        },
                        fillColor: const Color(0xff3a3b3c),
                        shape: const StadiumBorder(),
                        child: const Text('Restart', style: TextStyle(fontWeight: FontWeight.w800, color: Colors.white),),))
                ],

              ),

            ],
          ),
        ),
      ),
    );
  }
}