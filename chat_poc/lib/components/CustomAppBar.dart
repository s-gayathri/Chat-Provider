import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  final String subtitle;

  CustomAppBar({this.title, this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 7.5,
      color: const Color(0xff0f4d83),
      child: Padding(
        padding: const EdgeInsets.only(
          top: 50,
          bottom: 20,
          left: 10,
          right: 10,
        ),
        child: Row(
          children: [
            BackButton(
              color: Colors.white,
            ),
            Container(
              height: MediaQuery.of(context).size.width / 7,
              width: MediaQuery.of(context).size.width / 7,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(
                      'https://res.cloudinary.com/hostelling-internation/image/upload/t_hostel_carousel/f_auto,q_auto/v1565973406/kwunkr44mtjdrqrzz3s7.jpg'),
                ),
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 40,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.25,
            ),
            Icon(
              Icons.search,
              color: Colors.white,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.05,
            ),
            Icon(
              Icons.menu,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
