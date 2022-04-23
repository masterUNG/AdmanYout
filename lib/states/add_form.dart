// ignore_for_file: public_member_api_docs, sort_constructors_first, prefer_const_constructors
import 'package:admanyout/states/main_home.dart';
import 'package:admanyout/utility/my_constant.dart';
import 'package:admanyout/widgets/show_button.dart';
import 'package:admanyout/widgets/show_form.dart';
import 'package:admanyout/widgets/show_icon_button.dart';
import 'package:admanyout/widgets/show_text.dart';
import 'package:flutter/material.dart';

import 'package:admanyout/models/photo_model.dart';

class AddForm extends StatefulWidget {
  final List<PhotoModel> photoModels;
  const AddForm({
    Key? key,
    required this.photoModels,
  }) : super(key: key);

  @override
  State<AddForm> createState() => _AddFormState();
}

class _AddFormState extends State<AddForm> {
  var photoModels = <PhotoModel>[];
  var widgetLinks = <Widget>[];
  var links = <String>[];

  int indexTextFromField = 0;

  @override
  void initState() {
    super.initState();
    photoModels = widget.photoModels;
    widgetLinks.add(createTextFromFiew(indexTextFromField));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        actions: [
          ShowIconButton(
              iconData: Icons.check,
              pressFunc: () {
                print('links ===>> $links');
              })
        ],
        leading: ShowIconButton(
            iconData: Icons.arrow_back,
            pressFunc: () => Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const MainHome(),
                ),
                (route) => false)),
        foregroundColor: Colors.white,
        backgroundColor: Colors.black,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) => GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusScopeNode()),
          behavior: HitTestBehavior.opaque,
          child: SingleChildScrollView(
            child: Column(
              children: [
                addDescriptionImage(constraints),
                Column(
                  children: widgetLinks,
                ),
                ShowButton(
                    label: 'เพิ่มลิ้ง',
                    pressFunc: () {
                      indexTextFromField++;
                      setState(() {
                        widgetLinks.add(createTextFromFiew(indexTextFromField));
                      });
                    }),
                   
                     ShowForm(label: 'ชื่อปุ่ม', iconData: Icons.bookmark, changeFunc: (String string){}),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget createTextFromFiew(int index) {
    links.add('');
    return SizedBox(
      width: 250,
      child: TextFormField(
        onChanged: (value) {
          links[index] = value.trim();
        },
        decoration: InputDecoration(),
      ),
    );
  }

  Row addDescriptionImage(BoxConstraints constraints) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SizedBox(
          width: constraints.maxWidth * 0.3,
          child: Image.network(photoModels[0].urlPhoto),
        ),
        SizedBox(
          width: constraints.maxWidth * 0.5,
          child: TextFormField(
            maxLines: 10,
            keyboardType: TextInputType.multiline,
            style: MyConstant().h3WhiteStyle(),
            decoration: InputDecoration(
              hintText: 'เขียนคำบรรยาย ...',
              hintStyle: MyConstant().h3WhiteStyle(),
              border: InputBorder.none,
            ),
          ),
        )
      ],
    );
  }
}
