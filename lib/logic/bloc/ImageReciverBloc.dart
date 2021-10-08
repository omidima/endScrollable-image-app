// ignore_for_file: file_names
import 'dart:async';
import 'package:image_sample/data/dataProvider/ImageDataProvider.dart';
import 'package:image_sample/data/model/ImageModel.dart';
import 'package:image_sample/logic/event/ImageReciverEvent.dart';
import 'package:image_sample/logic/state/ImageReciverState.dart';

class ImageReciverBloc{
  ImageReciverState initState = ImageReciverState(items: []);

  // state stream
  final _stateController = StreamController<ImageReciverState>();
  StreamSink<ImageReciverState> get _state => _stateController.sink;
  Stream<ImageReciverState> get state => _stateController.stream;

  // event stream
  final _eventController = StreamController<ImageReciverEvent>();
  StreamSink<ImageReciverEvent> get event => _eventController.sink;

  ImageReciverBloc() {
    _eventController.stream.listen((event) => _mapEventToState(event));

  }

  void dispose(){
    _stateController.close();
    _eventController.close();
  }

  _mapEventToState(ImageReciverEvent event) async{
    if (event is LoadList){
      await _loadList();
    }
    if (event is PushList){
      await _updateList();
    }
    _state.add(initState);
  }

  // running function
  // ---------------------------------------------
  _loadList() async {
    List<ImageModel> items = await ImageDataProvider().getImageList(initState.currentPage);
    initState = ImageReciverState(items: items,isLoading: false,currentPage: initState.currentPage+1);
  }
  _updateList() async{
    List<ImageModel> items = await ImageDataProvider().getImageList(initState.currentPage);
    initState.items.addAll(items);
    initState.currentPage += 1;
  }



}