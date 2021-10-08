// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_sample/config.dart';
import 'package:image_sample/data/model/ImageModel.dart';

class ImagePage extends StatefulWidget {
  final ImageModel item;
  const ImagePage({
    Key? key,
    required this.item
  }) : super(key: key);

  @override
  State<ImagePage> createState() => _ImagePageState();
}

class _ImagePageState extends State<ImagePage> {

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              widget.item.url,
              fit: BoxFit.cover,
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
            Positioned(
                top:0,
                left: 0,
                right: 0,
                child: Visibility(
                  child:const LinearProgressIndicator(),
                  visible: _isLoading,
                )
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height,
                padding: const EdgeInsets.all(20),
                decoration:const BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.black,Colors.transparent],
                      begin: Alignment.bottomCenter,
                      end: Alignment.center
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      widget.item.author,
                      style:const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color:Colors.white,
                      ),
                    ),
                    const SizedBox(height: 10,),
                    const Text(
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua Egestas purus viverra accumsan in nisl nisi",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 100,)
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 10,
              left: 10,
              right: 10,
              child: Container(
                height: 80,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Config.primary
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: MaterialButton(
                        onPressed: (){
                          _setBackground();
                        },
                        height: 80,
                        child:const Text("Set Background"),
                      ),
                    ),
                    Expanded(
                      child: MaterialButton(
                        onPressed: (){
                          _openAddress();
                        },
                        height: 80,
                        child:const Text("Open in Web"),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _setBackground() async{
    setState(() {
      _isLoading = true;
    });
    var result = await const MethodChannel("o.h.hadidy").invokeMethod("setBackground",widget.item.url);

    setState(() {
      _isLoading = false;
    });
    if (result == 200) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("success to Change Wallpaper"),
      ));
    }
  }

  void _openAddress() async{
    await const MethodChannel("o.h.hadidy").invokeMethod("openAddress",widget.item.url);
  }
}
