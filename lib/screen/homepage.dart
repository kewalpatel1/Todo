import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:table_calendar/table_calendar.dart';

import 'login.dart';


extension ColorExtension on String {
  tocolor() {
    var hexColor = this.replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    if (hexColor.length == 8) {
      return Color(int.parse("0x$hexColor"));
    }
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    theme: _light ? _lightTheme : _darkTheme,
  debugShowCheckedModeBanner: false,
  home:HomePage(),
    );
  }
}

ThemeData _lightTheme = ThemeData(
    brightness: Brightness.light
);

ThemeData _darkTheme = ThemeData(
    brightness: Brightness.dark,

);
bool _light = true;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {
  String filterType = "today";
  var monthNames = [
    "JAN",
    "FEB",
    "MAR",
    "APR",
    "MAY",
    "JUN",
    "JUL",
    "AUG",
    "SEPT",
    "OCT",
    "NOV",
    "DEC"
  ];
  DateTime today = new DateTime.now();
  DateTime _fdateTime = new DateTime(1990);
  DateTime _ldateTime = new DateTime(2030);
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();
  String taskPop = "close";
  String input = "";
  CalendarFormat format = CalendarFormat.month;
  TextEditingController todo = new TextEditingController();

  void addData() {
    DocumentReference documentReference =
    FirebaseFirestore.instance.collection("MyTodos").doc(input);
    Map<String, String> todos = {
      "todo": input,
      // "Date" : focusedDay.toString(),
    };
    documentReference.set(todos).whenComplete(() {
      print("$input printed");
    });
  }

  void insert() {
    DocumentReference documentReference =
    FirebaseFirestore.instance.collection("MyTodos").doc(input);
    // Padding(
    //   padding: const EdgeInsets.all(8.0),
    //   child: Container(
    //     height: MediaQuery.of(context).size.height/20,
    //     width: MediaQuery.of(context).size.width/2,
    //     decoration: BoxDecoration(
    //         borderRadius: BorderRadius.circular(30),
    //         color: Colors.white,
    //         border: Border.all(color: Colors.grey)
    //     ),
    //     child: Center(
    //         child: Text(event,
    //           style: TextStyle(color: Colors.blue,
    //               fontWeight: FontWeight.bold,fontSize: 16),)
    //     ),
    //   ),
    // )
  }
@override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                AppBar(
                  automaticallyImplyLeading: false,
                  title: Text(
                    "My Work",
                    style: GoogleFonts.roboto(
                      textStyle: TextStyle(
                        fontSize: 25.0,
                      ),
                    ),
                  ),
                  leading: IconButton(
                    onPressed: () {
                        setState(() {
                           _light = false;
                        });
                    },
                    iconSize: 20,
                    icon: Icon(
                      Icons.light_mode,
                    ),
                  ),

                  actions: [
                    IconButton(onPressed: () {
                      Navigator.push(
                          context, MaterialPageRoute(
                          builder: (context) => Login())
                      );
                    },
                      iconSize: 29,
                      icon: Icon(
                        Icons.short_text_outlined,
                      ),
                    ),
                  ],
                  backgroundColor: Color(0xfff96060),
                  centerTitle: true,
                ),
                SizedBox.shrink(),
                Container(
                  height: 70,
                  color: Color(0xfff96060),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: () {
                                changeFilter("today");
                              },
                              child: Text("Today", style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18
                              ),),
                            ),
                            SizedBox(height: 10,),
                            Container(
                              height: 4,
                              width: 120,
                              color: (filterType == "today")
                                  ? Colors.white
                                  : Colors.transparent,
                            ),

                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: () {
                                changeFilter("monthly");
                              },
                              child: Text("Monthly", style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18
                              ),),
                            ),
                            SizedBox(height: 10,),
                            Container(
                              height: 4,
                              width: 120,
                              color: (filterType == "monthly")
                                  ? Colors.white
                                  : Colors.transparent,
                            )
                          ],
                        ),
                      ]
                  ),
                ),
                (filterType == "monthly") ?
                Column(
                  children: [
                    TableCalendar(
                      focusedDay: today,
                      firstDay: _fdateTime,
                      lastDay: _ldateTime,
                      startingDayOfWeek: StartingDayOfWeek.sunday,
                      calendarFormat: format,
                      onFormatChanged: (CalendarFormat _format) {
                        setState(() {
                          format = _format;
                        });
                      },
                      onDaySelected: (DateTime selectDay, DateTime focusDay) {
                        setState(() {
                          selectedDay = selectDay;
                          focusedDay = focusDay;
                        });
                      },
                      selectedDayPredicate: (DateTime date) {
                        return isSameDay(selectedDay, date);
                      },
                      calendarStyle: CalendarStyle(
                        isTodayHighlighted: true,
                        selectedTextStyle: TextStyle(color: Colors.white),
                      ),
                      calendarBuilders: CalendarBuilders(
                        selectedBuilder: (context, date, events) =>
                            Container(
                                margin: const EdgeInsets.all(4.0),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Color(0xfff96060),
                                  shape: BoxShape.circle,
                                ),
                                child: Text(
                                  date.day.toString(),
                                  style: TextStyle(color: Colors.white),
                                )),
                        holidayBuilder: (context, date, events) =>
                            Container(
                                // margin: const EdgeInsets.all(4.0),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: Colors.orange,
                                    borderRadius: BorderRadius.circular(10.0)),
                                child: Text(
                                  date.day.toString(),
                                  style: TextStyle(color: Colors.white),
                                )),
                      ),


                    ),

                  ],
                ) : Container(),
                Column(
                  children: [
                    Container(
                      height: 70,
                      padding: EdgeInsets.only(top: 40),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 200),
                            child: Text("Today ${monthNames[today.month -
                                1]}, ${today.day}/${today.year}",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.grey
                              ),),
                          )
                        ],
                      ),
                    ),
                    (_light)?
                    Container(
                      height:500,
                      child: ListView.builder(
                          itemCount: list.length,
                          itemBuilder:(context,index){
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 5),

                              child:
                              Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                elevation:4,
                                shadowColor:Colors.black.withOpacity(0.5),
                                color: Colors.white,
                                // offset: Offset(0,9),
                                // blurRadius: 20,
                                // spreadRadius: 1

                                child: ListTile(
                                  title: Text(list[index].title,
                                    style:GoogleFonts.inter(
                                      color: Colors.black,
                                      fontSize: 18,
                                    ),),
                                  subtitle:Text(list[index].time,
                                    style: GoogleFonts.inter(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18,
                                    ),),
                                  leading: Container(
                                    height: 20,
                                    width: 20,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white,
                                        border:Border.all(color: Color(0xFF9890e8),width: 4)
                                    ),
                                  ),

                                ),
                              )
                            );
                          }
                      ),
                    ): Container(
                      height:500,
                      child: ListView.builder(
                          itemCount: list.length,
                          itemBuilder:(context,index){
                            return Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 5),
                                child:
                                Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  elevation:4,
                                  shadowColor:Colors.black.withOpacity(0.5),
                                  color:Colors.grey[800],
                                  child: ListTile(
                                    title: Text(list[index].title,
                                      style:GoogleFonts.inter(
                                        color: Colors.white,
                                        fontSize: 18,
                                      ),),
                                    subtitle:Text(list[index].time,
                                      style: GoogleFonts.inter(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18,
                                      ),),
                                    leading: Container(
                                      height: 20,
                                      width: 20,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.white,
                                          border:Border.all(color: Color(0xFF9890e8),width: 4)
                                      ),
                                    ),

                                  ),
                                ),
                            );
                          }
                      ),
                    )
                  ],
                ),

              ],
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet<void>(
            context: context,
            builder: (BuildContext context) {
              return GestureDetector(
                onTap: () {
                  FocusScope.of(context).requestFocus(new FocusNode());
                },
                child: Container(
                  height: 600,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        '#FFAAA6'.tocolor(),
                        '#FF009688'.tocolor(),
                      ],
                      begin: FractionalOffset.topCenter,
                      end: FractionalOffset.bottomCenter,
                    ),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical:40),
                        child: TextField(
                          onChanged: (String value) {
                            input = value;
                          },
                          decoration: InputDecoration(
                            icon: Icon(Icons.task_alt_sharp),
                            filled: false,
                            hintText: "Enter your task",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 70),
                        child: Container(
                          height: 50,
                          child: Material(
                            borderRadius: BorderRadius.circular(10.0),
                            color:'#99B898'.tocolor(),
                            elevation: 7.0,
                            child: GestureDetector(
                              onTap: () {
                                addData();
                                Navigator.pop(context);
                              },
                              child: Center(
                                child: Text(
                                  "Lets's go",
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
        elevation: 8,
        child: Icon(
          Icons.add,
          size: 30,
        ),
        backgroundColor: Color(0xfff96060),
      ),
    );
  }

  changeFilter(String filter) {
    filterType = filter;
    setState(() {

    });
  }
}
class Model{
  final String time, title;
  Model({ required this.title, required this.time});
}

List<Model> list = [
  Model(
      title: "Gym",
      time: "7.15 AM"
  ),
  Model(
      title: "Drink water in every 20 mins",
      time: "6.00 AM"
  ),
  Model(
      title: "Meeting with jainish",
      time: "9.45 AM"
  ),
];






