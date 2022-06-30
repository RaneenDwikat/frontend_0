// ignore_for_file: prefer_typing_uninitialized_variables, camel_case_types

import 'dart:developer';

import 'package:flutter_app/screens/client/FadeAnimation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/screens/client/date_time.dart';
import 'package:flutter_app/screens/client/homeuser.dart';
import 'package:flutter_app/screens/client/workerprofile.dart';
import 'package:flutter_app/services/index.dart';
import 'package:flutter_app/screens/client/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

// ignore: must_be_immutable
class workersPage extends StatefulWidget {
  var name, address, category, service;
  // ignore: use_key_in_widget_constructors
  workersPage(this.name, this.address, this.category, this.service);

  @override
  // ignore: library_private_types_in_public_api
  _workersPageState createState() =>
      // ignore: no_logic_in_create_state
      _workersPageState(name, address, category, service);
}

// ignore: duplicate_ignore
class _workersPageState extends State<workersPage> {
  var name, address, category, service0;
  _workersPageState(this.name, this.address, this.category, this.service0);
  var selectedworker = -1;
  var selected;
  getworkers service = getworkers();
  List<dynamic> i = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize:
              const Size.fromHeight(153.0), // here the desired height
          child: AppBar(
            backgroundColor: const Color(0xffF8C80E),
            flexibleSpace: const Image(
              image: AssetImage('assets/logo3.png'),
              fit: BoxFit.none,
            ),
            /* title: Image.asset('assets/logo3.png',
                width: 150, height: 150, fit: BoxFit.fill

                // height: 200,
                ),*/
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              FloatingActionButton(
                heroTag: "btn2",
                onPressed: () async {
                  print(name);
                  print(address);
                  print(category);
                  if (selected != null) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DateAndTime(name, address,
                                category, service0, selected, i)));
                  } else {
                    Fluttertoast.showToast(
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 24.0,
                      msg: "قم باختيار العامل اولا",
                    );
                  }
                },
                child: Icon(Icons.navigate_before),
                backgroundColor: Color(0xffE63220),
              ),
            ],
          ),
        ),
        backgroundColor: Colors.white,
        body: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverToBoxAdapter(
                    child: FadeAnimation(
                  1,
                  Padding(
                    padding:
                        EdgeInsets.only(top: 50.0, right: 20.0, left: 20.0),
                    child: Text(
                      'اختر مزود الخدمة',
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                        fontSize: 35,
                        color: Colors.grey.shade900,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ))
              ];
            },
            body: Padding(
              padding: EdgeInsets.all(20.0),
              child: FutureBuilder<List>(
                  future: service.getworker(category, address.split(" ")[0]),
                  builder: (context, snapshot) {
                    //  print(snapshot.data);
                    if (snapshot.hasData) {
                      //print(snapshot.data);
                      var d = snapshot.data?.length;

                      if (d == 0) {
                        return const Center(
                            child: Text(
                          'لا يوجد معلومات',
                          textDirection: TextDirection.rtl,
                        ));
                      } else {
                        return GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 1,
                              childAspectRatio: 3.0,
                              crossAxisSpacing: 10.0,
                              mainAxisSpacing: 10.0,
                            ),
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              return FadeAnimation(
                                  (1.0 + index) / 4,
                                  GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          i = snapshot.data![index]['time'];
                                          selected =
                                              snapshot.data![index]['_id'];
                                          print(snapshot.data![index]['time']);
                                          if (selectedworker == index)
                                            selectedworker = -1;
                                          else
                                            selectedworker = index;
                                        });
                                      },
                                      child: AnimatedContainer(
                                        duration: Duration(milliseconds: 300),
                                        padding: EdgeInsets.all(10.0),
                                        decoration: BoxDecoration(
                                          color: selectedworker == index
                                              ? Colors.blue.shade50
                                              : Colors.grey.shade100,
                                          border: Border.all(
                                            color: selectedworker == index
                                                ? Color(0xffF8C80E)
                                                : Color(0xffF8C80E)
                                                    .withOpacity(0),
                                            width: 2.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                        ),
                                        child: Column(
                                          children: [
                                            Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Column(children: [
                                                    IconButton(
                                                        onPressed: () {
                                                          var n = snapshot
                                                                  .data![index]
                                                              ['name'];
                                                          var phone = snapshot
                                                                  .data![index]
                                                              ['phonenumber'];
                                                          var about = snapshot
                                                                  .data![index]
                                                              ['about'];
                                                          var region = snapshot
                                                                  .data![index]
                                                              ['region'];
                                                          var rate = snapshot
                                                                  .data![index]
                                                              ['rating'];
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (context) =>
                                                                      workerProfilePage(
                                                                          n,
                                                                          phone,
                                                                          about,
                                                                          region,
                                                                          rate)));
                                                        },
                                                        icon: Icon(
                                                            Icons.arrow_back))
                                                    // Text(
                                                    //   snapshot.data![index]
                                                    //       ['phonenumber'],
                                                    //   textDirection:
                                                    //       TextDirection.rtl,
                                                    //   style: const TextStyle(
                                                    //     fontSize: 18,
                                                    //     fontWeight:
                                                    //         FontWeight.w600,
                                                    //   ),
                                                    // ),
                                                  ]),
                                                  const SizedBox(
                                                    width: 100,
                                                  ),
                                                  Column(
                                                    children: [
                                                      Text(
                                                        snapshot.data![index]
                                                            ['name'],
                                                        textDirection:
                                                            TextDirection.rtl,
                                                        style: const TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                      Row(
                                                        children: [
                                                          if (snapshot.data![
                                                                      index]
                                                                  ["rating"] !=
                                                              null)
                                                            for (int i = 0;
                                                                i <
                                                                    snapshot.data![
                                                                            index]
                                                                        [
                                                                        "rating"];
                                                                i++)
                                                              const Icon(
                                                                Icons.star,
                                                                color: Colors
                                                                    .orange,
                                                                size: 15,
                                                              ),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                  Column(
                                                    children: [
                                                      Image.asset(
                                                        "assets/logo3.png",
                                                        width: 80,
                                                        height: 80,
                                                        matchTextDirection:
                                                            true,
                                                      ),
                                                    ],
                                                  )
                                                ]),
                                          ],
                                        ),
                                        // ignore: prefer_const_literals_to_create_immutables
                                      )));
                            });
                      }
                    } else {
                      return const Center(
                        child: Text(
                          'لا يوجد معلومات',
                          textDirection: TextDirection.rtl,
                        ),
                      );
                    }
                  }),
            )));
  }
}
