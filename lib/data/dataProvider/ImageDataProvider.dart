// ignore_for_file: file_names

import 'dart:convert';

import 'package:http/http.dart';
import 'package:image_sample/data/model/ImageModel.dart';

import '../../request.dart';

class ImageDataProvider {
  Future<List<ImageModel>> getImageList(int offset) async{
    Response response = await NetworkRequests().getImageList(10, offset);

    // response status 200 check
    if (response.statusCode == 200) {
      List tempList = json.decode(response.body);
      var result = List.generate(
        tempList.length,
        (index){
          return ImageModel.getFromJson(tempList[index]);
        }
      );
      return result;

    // response not found
    }else {
      return [];
    }

  }
}