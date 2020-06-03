import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_wallpaper_app/models/image_model.dart';
import 'package:flutter_wallpaper_app/single_photo.dart';
import 'package:http/http.dart' as http;

class PhotosHome extends StatefulWidget {
  @override
  _PhotosHomeState createState() => _PhotosHomeState();
}

class _PhotosHomeState extends State<PhotosHome> {
  List<Photo> photos = [];

  Future<List<Photo>> _getData() async {
    final response = await http.get(
        'https://api.pexels.com/v1/search/?page=1&per_page=24&query=nature',
        headers: {
          "Authorization":
              "563492ad6f91700001000001bc3309718f724de0aa6ae3871ab37403"
        });

    if (response.statusCode == 200) {
      var parsed = jsonDecode(response.body);

      photos =
          (parsed['photos'] as List).map((img) => Photo.fromJson(img)).toList();
    }
    print(photos);
    return photos;
  }

  @override
  void initState() {
    _getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[100],
      appBar: AppBar(
        title: Text("Wallpapers"),
      ),
      body: FutureBuilder(
        future: _getData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return StaggeredGridView.countBuilder(
              crossAxisCount: 4,
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) => InkWell(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return SinglePhoto(photo: snapshot.data[index]);
                  }),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.green,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        '${snapshot.data[index].src.tiny}',
                      ),
                    ),
                  ),
                ),
              ),
              staggeredTileBuilder: (int index) =>
                  StaggeredTile.count(2, index.isEven ? 2 : 1),
              mainAxisSpacing: 4.0,
              crossAxisSpacing: 4.0,
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
