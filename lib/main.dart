import 'package:firstly/homecontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(Object context) {
    return GetMaterialApp(
      title: 'btg remover app',
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purpleAccent,
        title: Text('slazzer ai app'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                  onPressed: () {
                    controller.getImage();
                  },
                  child: Text('picked file')),
              GetBuilder<HomeController>(
                  init: HomeController(),
                  builder: (controller) {
                    return Center(
                      child: controller.imageBefore == null
                          ? Text('Please Pick Image')
                          : Image.file(controller.imageBefore!),
                    );
                  }),
              ElevatedButton(
                  onPressed: () {
                    controller.uploadImage(controller.imageBefore!);
                  },
                  child: Text('upload file')),
              GetBuilder<HomeController>(builder: (controller) {
                return Center(
                  child: controller.imageBefore == null
                      ? Text('Please upload Image')
                      : Image.memory(controller.imageAfter!),
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}
