// ignore_for_file: file_names
import 'package:image_sample/data/model/ImageModel.dart';

class ImageReciverState {
  bool isLoading = true;
  List<ImageModel> items;
  int currentPage;

  ImageReciverState({this.isLoading = true, required this.items,this.currentPage = 1});
}
