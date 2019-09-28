import 'package:flutter/material.dart';
import 'package:pics/src/models/image_model.dart';

class ImageList extends StatelessWidget {
  final List<ImageModel> images;

  ImageList({this.images});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(16.0),
      itemCount: images.length,
      itemBuilder: (context, int index) => ImageItem(image: images[index]),
    );
  }
}

class ImageItem extends StatelessWidget {
  final ImageModel image;
  ImageItem({this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.teal.shade100),
      ),
      child: Column(
        children: <Widget>[
          Image.network(image.url),
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Text(
              image.title,
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.w300, fontSize: 18.0),
            ),
          ),
        ],
      ),
    );
  }
}
