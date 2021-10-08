// ignore_for_file: file_names
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:image_sample/data/model/ImageModel.dart';
import 'package:image_sample/logic/bloc/ImageReciverBloc.dart';
import 'package:image_sample/logic/event/ImageReciverEvent.dart';
import 'package:image_sample/logic/state/ImageReciverState.dart';
import 'package:image_sample/presentation/widget/ImageItemView.dart';

import '../../config.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _bloc = ImageReciverBloc();
  late ScrollController _scrollController;

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent == _scrollController.offset){
        _bloc.event.add(PushList());
      }
    });
    _bloc.event.add(LoadList());
    super.initState();
  }

  Widget _fixedItem() {
    return SliverList(
      delegate: SliverChildListDelegate(
        [
          const SizedBox(height: 50,),
          Text(
            "Wellcome To App",
            style: TextStyle(
              color: Config.primary,
              fontSize: 24,
              fontWeight: FontWeight.bold
            )
          ),
          const SizedBox(height: 10,),
          const Text(
            "click on image for download or set on image Background"
          ),
          const SizedBox(height: 50,),
        ]
      ),
    );
  }

  Widget _imageList(List<ImageModel> items) {
    return SliverList(
      delegate: SliverChildListDelegate(
        List.generate(
            items.length,
              (index) {
            return ImageItemView(
              item: items[index],
            );
          }
        )
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin:const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
          padding: const EdgeInsets.all(10),
          child: StreamBuilder(
            builder: (context,AsyncSnapshot<ImageReciverState> snapshot) {

              return snapshot.requireData.isLoading ?
              const CircularProgressIndicator() :
              CustomScrollView(
                controller: _scrollController,
                slivers: [
                  _fixedItem(),
                  _imageList(snapshot.requireData.items)
                ],
              );
            },
            stream: _bloc.state,
            initialData: ImageReciverState(items: []),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10)
          ),
        ),
      ),
    );
  }
}
