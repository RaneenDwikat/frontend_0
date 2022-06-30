// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_app/services/index.dart';
import 'package:flutter_app/screens/client/rating.dart';

class DetailsPage extends StatefulWidget {
  var val, id, name, phonenumber, time;
  DetailsPage(this.val, this.id, this.name, this.phonenumber, this.time);
  @override
  _DetailsPageState createState() =>
      _DetailsPageState(val, id, name, phonenumber, time);
}

class _DetailsPageState extends State<DetailsPage> {
  var val, id;
  String name = "", phonenumber = "";
  getspacificorder service = getspacificorder();
  var _rating;
  String time;
  _DetailsPageState(this.val, this.id, this.name, this.phonenumber, this.time);

  @override
  void initState() {
    _rating = 0;

    super.initState();
  }

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
          ),
        ),
        body: _mountainDellPage());
  }

  _mountainDellPage() {
    return Column(children: [
      const SizedBox(
        height: 20.0,
      ),
      Container(
        margin: const EdgeInsets.only(right: 15.0, bottom: 15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(val.data['service'],
                style: const TextStyle(
                    fontSize: 30.0,
                    color: Color(0xff00485F),
                    fontWeight: FontWeight.bold)),
            const SizedBox(
              width: 10.0,
            ),
            const Icon(
              Icons.home_repair_service_outlined,
              color: Colors.black,
              size: 24.0,
            ),
          ],
        ),
      ),
      Container(
        margin: const EdgeInsets.only(right: 15.0, bottom: 15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(time,
                style: const TextStyle(
                    fontSize: 20.0,
                    color: Color(0xff00485F),
                    fontWeight: FontWeight.bold)),
            const SizedBox(
              width: 10.0,
            ),
            const Icon(
              Icons.schedule,
              color: Color(0xff00485F),
              size: 24.0,
            ),
          ],
        ),
      ),
      Container(
        margin: const EdgeInsets.only(right: 15.0, bottom: 15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              name.toString(),
              style: const TextStyle(
                  fontSize: 18.0,
                  color: Color(0xff00485F),
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              width: 10.0,
            ),
            const Icon(
              Icons.person,
              color: Color(0xff00485F),
              size: 24.0,
            ),
          ],
        ),
      ),
      Container(
        margin: const EdgeInsets.only(right: 15.0, bottom: 15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              phonenumber.toString(),
              style: const TextStyle(
                  fontSize: 18.0,
                  color: Color(0xff00485F),
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              width: 10.0,
            ),
            const Icon(
              Icons.call,
              color: Color(0xff00485F),
              size: 24.0,
            ),
          ],
        ),
      ),
      Container(
        margin: const EdgeInsets.only(right: 15.0, bottom: 15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              val.data['address'][1],
              // val.data['address'][0]
              //     .replaceAll(RegExp('[^A-Za-z0-9 , ]'), '')
              //     .substring(
              //         0,
              //         val.data['address'][0]
              //             .replaceAll(RegExp('[^A-Za-z0-9 , ]'), '')
              //             .indexOf(',')),
              style: const TextStyle(
                  fontSize: 18.0,
                  color: Color(0xff00485F),
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              width: 10.0,
            ),
            const Icon(
              Icons.location_pin,
              color: Color(0xff00485F),
              size: 24.0,
            ),
          ],
        ),
      ),
      Container(
        margin: const EdgeInsets.only(top: 15.0, bottom: 5.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              width: 60.0,
            ),
            Wrap(
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                const SizedBox(
                  width: 4.0,
                ),
              ],
            )
          ],
        ),
      ),
      const Divider(),
      Container(
        margin: EdgeInsets.only(top: 15.0, bottom: 5.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              width: 200.0,
            ),
            Wrap(
              // ignore: prefer_const_literals_to_create_immutables
              children: [],
            )
          ],
        ),
      ),
      Container(
        margin: const EdgeInsets.only(right: 120.0, bottom: 15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            const Icon(
              Icons.star_rate_sharp,
              color: Colors.orange,
              size: 40.0,
            ),
            const SizedBox(
              width: 10.0,
            ),
            const Text(
              'قيم الخدمة',
              textDirection: TextDirection.rtl,
              style: TextStyle(
                  fontSize: 20.0,
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      const Divider(),
      Rating(id, (rating) {
        setState(() {
          _rating = rating;
        });
      }, 5),
      SizedBox(
          height: 60,
          child: (_rating != null && _rating != 0)
              ? Text("", style: const TextStyle(fontSize: 18))
              : const SizedBox.shrink())
    ]);
  }
}
