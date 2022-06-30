import 'package:flutter_app/screens/client/FadeAnimation.dart';
import 'package:flutter_app/screens/client/detailedPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/screens/client/homeuser.dart';
import 'package:flutter_app/services/index.dart';
import 'package:flutter_app/services/authservice.dart';

class BookingPage extends StatefulWidget {
  var name;
  BookingPage(this.name);
  @override
  _BookingPageState createState() => _BookingPageState(name);
}

class _BookingPageState extends State<BookingPage> {
  var name, selectedRoom;
  var _id;
  _BookingPageState(this.name);
  final List<int> _selectedRooms = [];
  getorders service = getorders();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize:
              const Size.fromHeight(153.0), // here the desired height
          child: AppBar(
            backgroundColor: Color(0xffF8C80E),
            flexibleSpace: const Image(
              image: AssetImage('assets/logo3.png'),
              fit: BoxFit.none,
            ),
          ),
        ),
        // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        // floatingActionButton: Padding(
        //   padding: const EdgeInsets.all(5.0),
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     children: <Widget>[
        //       FloatingActionButton(
        //         onPressed: () {},
        //         // ignore: sort_child_properties_last
        //         child: const Icon(Icons.navigate_before),
        //         backgroundColor: const Color(0xffE63220),
        //       ),
        //     ],
        //   ),
        // ),
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
                      'طلباتي',
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
            body: FutureBuilder<List>(
              future: service.getorder(name),
              builder: (context, snapshot) {
                // print(snapshot.data);
                if (snapshot.hasData) {
                  //print(snapshot.data![0]['name']);

                  var d = snapshot.data?.length;
                  return SafeArea(
                    bottom: false,
                    child: Column(
                      children: <Widget>[
                        //CategoryList(),
                        SizedBox(height: 20.0),
                        Expanded(
                          child: Stack(
                            children: <Widget>[
                              // Our background
                              Container(
                                margin: const EdgeInsets.only(top: 60),
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(40),
                                    topRight: Radius.circular(40),
                                  ),
                                ),
                              ),
                              GridView.builder(
                                padding: const EdgeInsets.all(10),

                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 1,
                                  childAspectRatio: 2.5,
                                  crossAxisSpacing: 10.0,
                                  mainAxisSpacing: 10.0,
                                ),
                                physics: const NeverScrollableScrollPhysics(),
                                // here we use our demo procuts list
                                itemCount: d,
                                itemBuilder: (
                                  BuildContext context,
                                  int index,
                                ) {
                                  // print(snapshot.data![index].image + "okk");
                                  return FadeAnimation(
                                      (1.0 + index) / 4,
                                      GestureDetector(
                                        onTap: () {
                                          selectedRoom =
                                              snapshot.data![index]['name'];
                                          //print(selectedcat);
                                          setState(() {
                                            if (_selectedRooms.contains(index))
                                              _selectedRooms.remove(index);
                                            else
                                              _selectedRooms.add(index);
                                          });
                                        },
                                        child: AnimatedContainer(
                                          duration: Duration(milliseconds: 300),
                                          padding: EdgeInsets.all(10.0),
                                          decoration: BoxDecoration(
                                            color: _selectedRooms == index
                                                ? Colors.blue.shade50
                                                : Colors.grey.shade100,
                                            border: Border.all(
                                              color: _selectedRooms == index
                                                  ? Color(0xffF8C80E)
                                                  : Color(0xffF8C80E)
                                                      .withOpacity(0),
                                              width: 2.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                          ),
                                          child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                const SizedBox(
                                                  height: 20,
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.all(5),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      // const Spacer(),
                                                      IconButton(
                                                        icon: const Icon(
                                                            Icons.arrow_back),
                                                        color: Colors.red[700],
                                                        highlightColor:
                                                            Colors.red,
                                                        onPressed: () {
                                                          var name, phonenumber;
                                                          AuthService()
                                                              .getorder(snapshot
                                                                      .data![
                                                                  index]["_id"])
                                                              .then((val) {
                                                            print(val);
                                                            AuthService()
                                                                .getworkernameandphonenumber(
                                                                    val.data[
                                                                        'worker'])
                                                                .then((result) {
                                                              print(result);
                                                              name = result
                                                                  .data['name'];
                                                              phonenumber = result
                                                                      .data[
                                                                  'phonenumber'];
                                                              String
                                                                  time; // = val
                                                              //     .data['time'];
                                                              if (val
                                                                  .data['time']
                                                                  .contains(
                                                                      'Tomorrow')) {
                                                                time = val.data[
                                                                        'time']
                                                                    .replaceAll(
                                                                        'Tomorrow',
                                                                        'غدا');
                                                                print(time);
                                                              } else {
                                                                time = val.data[
                                                                        'time']
                                                                    .replaceAll(
                                                                        'Today',
                                                                        "اليوم");
                                                              }
                                                              Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                  builder: (context) => DetailsPage(
                                                                      val,
                                                                      snapshot.data![
                                                                              index]
                                                                          [
                                                                          "_id"],
                                                                      name,
                                                                      phonenumber,
                                                                      time),
                                                                ),
                                                              );
                                                            });
                                                          });
                                                        },
                                                      ),
                                                      const SizedBox(
                                                        width: 160,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: [
                                                          Text(
                                                            snapshot.data![
                                                                    index]
                                                                ['service'],
                                                            style: const TextStyle(
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                          ),
                                                          const SizedBox(
                                                            width: 10.0,
                                                          ),
                                                          // ignore: prefer_interpolation_to_compose_strings
                                                          Image.asset(
                                                            // ignore: prefer_interpolation_to_compose_strings
                                                            "assets/cleaning.png",
                                                            width: 35,
                                                            height: 35,
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    ElevatedButton.icon(
                                                      icon: const Icon(
                                                          Icons.cancel),
                                                      label: const Text(
                                                        "الغاء طلبي",
                                                      ),
                                                      onPressed: () {
                                                        _id = snapshot
                                                                .data![index]
                                                            ['_id'];
                                                        showAlertDialog(
                                                            context);
                                                      },
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        primary: const Color(
                                                            0xffE63220),
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      32.0),
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 10,
                                                    ),
                                                    ElevatedButton(
                                                      // ignore: sort_child_properties_last
                                                      child: Text(
                                                          snapshot.data![index]
                                                              ['status']),
                                                      onPressed: () =>
                                                          print("it's pressed"),
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        primary:
                                                            Color(0xffF8C80E),
                                                        onPrimary: Colors.white,
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      32.0),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ]),
                                        ),
                                      ));
                                },
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return const Center(
                    child: Text(
                      'لايوجد معلومات',
                      textDirection: TextDirection.rtl,
                    ),
                  );
                }
              },
            )));
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      style: TextButton.styleFrom(
        primary: Colors.black,
      ),
      child: Text("لا"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
      style: TextButton.styleFrom(
        primary: Colors.black,
      ),
      child: Text("نعم"),
      onPressed: () {
        print(_id);
        AuthService().cancelrequest(_id);
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => SelectService(name: name)));
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      //title: Text("AlertDialog"),
      backgroundColor: Color.fromARGB(255, 248, 241, 145),

      shape:
          RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15)),
      content: Text("هل انت متأكد؟"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
