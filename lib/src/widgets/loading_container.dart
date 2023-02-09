import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingContainer extends StatelessWidget {
  const LoadingContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: buildContainer(),
          subtitle: buildContainer(),
        ),
        Divider(
          height: 8,
        )
      ],
    );
  }

  Widget buildContainer() {
    return Container(
      height: 24,
      width: 150,
      margin: EdgeInsets.only(top: 5, bottom: 5),
      color: Colors.grey[300],
    );
  }
}
