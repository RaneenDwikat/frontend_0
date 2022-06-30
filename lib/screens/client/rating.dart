import 'package:flutter/material.dart';
import 'package:flutter_app/services/authservice.dart';

class Rating extends StatefulWidget {
  final int maximumRating;
  final Function(int) onRatingSelected;
  var id;
  Rating(this.id, this.onRatingSelected, [this.maximumRating = 5]);

  @override
  _Rating createState() => _Rating(id);
}

class _Rating extends State<Rating> {
  int _currentRating = 0;
  var id;
  _Rating(this.id);
  Widget _buildRatingStar(int index) {
    if (index < _currentRating) {
      return Icon(
        Icons.star,
        color: Colors.orange,
        size: 40.0,
      );
    } else {
      return Icon(
        Icons.star_border_outlined,
        size: 40.0,
      );
    }
  }

  Widget _buildBody() {
    final stars = List<Widget>.generate(this.widget.maximumRating, (index) {
      return GestureDetector(
        child: _buildRatingStar(index),
        onTap: () {
          setState(() {
            _currentRating = index + 1;
          });

          this.widget.onRatingSelected(_currentRating);
        },
      );
    });

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        MaterialButton(
          child: const Text("قيم",
              style: TextStyle(color: Colors.blue, fontSize: 18)),
          onPressed: () {
            print(id);
            AuthService().setratefororder(id, _currentRating);
            setState(() {
              _currentRating = 0;
            });
            this.widget.onRatingSelected(_currentRating);
          },
        ),
        Row(
          children: stars,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }
}
