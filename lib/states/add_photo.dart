import 'package:admanyout/utility/my_constant.dart';
import 'package:admanyout/widgets/show_image.dart';
import 'package:admanyout/widgets/show_text.dart';
import 'package:flutter/material.dart';

class AddPhoto extends StatelessWidget {
  const AddPhoto({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('โพสต์ใหม่'),
        foregroundColor: Colors.white,
        backgroundColor: Colors.black,
      ),
      body: LayoutBuilder(builder: (context, constraints) {
        return Column(
          children: [
            SizedBox(
              width: constraints.maxWidth,
              height: constraints.maxWidth * 0.75,
              child: const ShowImage(
                path: 'images/image.png',
              ),
            ),
            TextButton(
                onPressed: () {},
                child: ShowText(
                  label: 'Gallery',
                  textStyle: MyConstant().h3WhiteStyle(),
                ))
          ],
        );
      }),
    );
  }
}
