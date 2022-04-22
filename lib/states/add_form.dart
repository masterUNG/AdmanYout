// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:admanyout/states/main_home.dart';
import 'package:admanyout/widgets/show_icon_button.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
    );
  }
}
