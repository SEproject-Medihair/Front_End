import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/services.dart';
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
  String _responseText = '';

  Future uploadImage() async {
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            'https://hyuna.ngrok.io/predict')); // Replace with your server endpoint
    request.files.add(await http.MultipartFile.fromPath('file', _image!.path));

    try {
      var response = await request.send();
      final responseString = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        setState(() {
          final responseData = json.decode(responseString);
          final int one = responseData["predicted_class"];
          final int two = responseData["predicted_class2"];

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Analysisloding(
                email: email,
                one: one,
                two: two,
              ),
            ),
          );
        });
      } else {
        setState(() {
          _responseText = 'Error: ${response.reasonPhrase!}';
        });
      }
    } catch (e) {
      setState(() {
        _responseText = 'Error: $e';
      });
    }
  }

  // 이미지를 보여주는 위젯
  Widget showImage() {
    return Container(
        color: const Color(0xffd0cece),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.width,
        child: Center(
            child: _image == null
                ? const Text('모발 사진을 선택해주세요')
                : Image.file(File(_image!.path))));
  }

  @override
  Widget build(BuildContext context) {
    // 화면 세로 고정
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color(0xFFF9F2E7),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: height * 0.2),
            showImage(),
            const SizedBox(
              height: 50.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                // 카메라 촬영 버튼
                FloatingActionButton(
                  backgroundColor: const Color(0xFF51370E),
                  heroTag: 'pick Image',
                  tooltip: 'pick Image',
                  onPressed: () {
                    getImage(ImageSource.camera);
                  },
                  child: const Icon(Icons.add_a_photo),
                ),

                // 갤러리에서 이미지를 가져오는 버튼
                FloatingActionButton(
                  backgroundColor: const Color(0xFF51370E),
                  heroTag: 'pick Album',
                  tooltip: 'pick Album',
                  onPressed: () {
                    getImage(ImageSource.gallery);
                  },
                  child: const Icon(Icons.wallpaper),
                ),
                FloatingActionButton(
                  backgroundColor: const Color(0xFF51370E),
                  heroTag: 'nextpage',
                  tooltip: '분석',
                  onPressed: uploadImage, // 이미지 업로드 및 분석 실행
                  child: const Icon(Icons.arrow_forward_rounded),
                ),
              ],
            ),
            Text(_responseText), // 서버 응답 출력
          ],
        ),
      ),
    );
  }

  // 비동기 처리를 통해 카메라와 갤러리에서 이미지를 가져온다.
  Future getImage(ImageSource imageSource) async {
    final image = await picker.pickImage(source: imageSource);

    setState(() {
      _image = File(image!.path); // 가져온 이미지를 _image에 저장
    });
  }
}
