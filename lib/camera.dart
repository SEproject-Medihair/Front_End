import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'analysisloding.dart';

class Camera extends StatefulWidget {
  final String email;
  const Camera({super.key, required this.email});

  @override
  State<Camera> createState() => _CameraState(email: email);
}

class _CameraState extends State<Camera> {
  final String email;
  File? _image;
  _CameraState({required this.email});
  final picker = ImagePicker();

  // 비동기 처리를 통해 카메라와 갤러리에서 이미지를 가져온다.
  Future getImage(ImageSource imageSource) async {
    final image = await picker.pickImage(source: imageSource);

    setState(() {
      _image = File(image!.path); // 가져온 이미지를 _image에 저장
    });
  }

  // 이미지를 보여주는 위젯
  Widget showImage() {
    return Container(
        color: const Color(0xffd0cece),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.width,
        child: Center(
            child: _image == null
                ? const Text('No image selected.')
                : Image.file(File(_image!.path))));
  }

  @override
  Widget build(BuildContext context) {
    // 화면 세로 고정
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    return Scaffold(
        backgroundColor: const Color(0xfff4f3f9),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 25.0),
              showImage(),
              const SizedBox(
                height: 50.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  // 카메라 촬영 버튼
                  FloatingActionButton(
                    heroTag: 'pick Image',
                    tooltip: 'pick Image',
                    onPressed: () {
                      getImage(ImageSource.camera);
                    },
                    child: const Icon(Icons.add_a_photo),
                  ),

                  // 갤러리에서 이미지를 가져오는 버튼
                  FloatingActionButton(
                    heroTag: 'pick Album',
                    tooltip: 'pick Album',
                    onPressed: () {
                      getImage(ImageSource.gallery);
                    },
                    child: const Icon(Icons.wallpaper),
                  ),
                  FloatingActionButton(
                    heroTag: 'nextpage',
                    tooltip: '분석',
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Analysisloding(
                            email: email,
                          ),
                        ),
                      );
                    },
                    child: const Icon(Icons.arrow_forward_rounded),
                  ),
                ],
              )
            ],
          ),
        ));
  }
}