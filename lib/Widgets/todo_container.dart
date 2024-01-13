import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:project/Pages/home_page.dart';

class TodoContainer extends StatelessWidget {
  // final String id;
  final String title;
  final Function onPress;
  // final String desc;
  const TodoContainer({
    Key? key,
    // required this.id,
    // required this.desc,
    required this.onPress,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: double.infinity,
        height: 160,
        decoration: BoxDecoration(
          color: Colors.blueGrey[200],
          borderRadius: const BorderRadius.all(
            Radius.circular(8),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
              IconButton(
                  onPressed: () => onPress(),
                  icon:const Icon(
                    Icons.delete,
                    color: Colors.white,
                    size: 32,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
