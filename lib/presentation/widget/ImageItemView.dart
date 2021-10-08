// ignore_for_file: file_names
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:image_sample/data/model/ImageModel.dart';
import 'package:image_sample/presentation/page/ImagePage.dart';

class ImageItemView extends StatelessWidget {
  final ImageModel item;

  const ImageItemView(
      {Key? key, required this.item,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        margin:const EdgeInsets.only(bottom: 10),
        child: Stack(
          children: [
            SizedBox(
              width: double.infinity,
              height: 400,
              child: ClipRRect(
                child: Image.network(
                  item.imageAddress,
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    }
                    return const LinearProgressIndicator(
                      backgroundColor: Color(0x817A7F90),
                      color: Colors.blueGrey,
                    );
                  },
                ),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            Positioned(
              bottom: 10,
              left: 10,
              right: 10,
              child: Container(
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.black54,
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          flex: 9,
                          child: Text(
                            item.author,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                        const Expanded(
                          flex: 3,
                          child: Icon(Icons.arrow_forward, color: Colors.white),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => ImagePage(item: item),
        ));
      },
    );
  }
}
