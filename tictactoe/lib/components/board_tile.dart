import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class BoardTile extends StatefulWidget {
  const BoardTile({super.key});

  @override
  State<BoardTile> createState() => _BoardTileState();
}

class _BoardTileState extends State<BoardTile> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
      ),
      onPressed: () {
        setState(() {});
      },
      child: const Icon(
        Icons.clear_outlined,
        color: Colors.white,
        size: 100,
      ),
    );
  }
}
