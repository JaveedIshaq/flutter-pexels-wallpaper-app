import 'package:flutter/material.dart';
import 'package:flutter_wallpaper_app/models/image_model.dart';

class SinglePhoto extends StatelessWidget {
  final Photo photo;

  const SinglePhoto({Key key, this.photo}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Colors.green,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                  '${photo.src.portrait}',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
