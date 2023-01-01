import 'package:flutter/material.dart';

class AppBarAdmin extends StatelessWidget {
  const AppBarAdmin({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        const SizedBox(
          height: 50,
          width: 200,
          child: TextField(
              autofocus: true,
              maxLines: 1,
              style: TextStyle(
                fontSize: 16,
              ),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(top: 10),
                filled: true,
                prefixIcon: Icon(
                  Icons.search,
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
                fillColor: Colors.white,
                hintText: 'Search',
                hintStyle: TextStyle(fontSize: 16.0),
              )),
        ),
        const SizedBox(width: 10),
        IconButton(
            icon: const Icon(
              Icons.notifications_active,
              size: 20,
            ),
            onPressed: () {}),
        const SizedBox(width: 15),
        Row(children: const [
          CircleAvatar(
            radius: 17,
            backgroundImage: AssetImage("assets/images/profile/avatar.jpg"),
          ),
          Icon(Icons.arrow_drop_down_outlined, color: Colors.black)
        ]),
      ],
    );
  }
}
