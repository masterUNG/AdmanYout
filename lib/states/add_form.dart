// ignore_for_file: public_member_api_docs, sort_constructors_first, prefer_const_constructors, avoid_print
import 'package:admanyout/models/post_model.dart';
import 'package:admanyout/models/user_model.dart';
import 'package:admanyout/states/main_home.dart';
import 'package:admanyout/utility/my_constant.dart';
import 'package:admanyout/widgets/show_button.dart';
import 'package:admanyout/widgets/show_form.dart';
import 'package:admanyout/widgets/show_icon_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  var urlPath = <String>[];

  int indexTextFromField = 0;
  String article = '', nameButton = 'กดปุ่ม';
  String? uidPost, name;

  @override
  void initState() {
    super.initState();
    photoModels = widget.photoModels;
    widgetLinks.add(createTextFromFiew(indexTextFromField));

    for (var item in photoModels) {
      urlPath.add(item.urlPhoto);
    }

    findUserLogin();
  }

  Future<void> findUserLogin() async {
    var user = FirebaseAuth.instance.currentUser;
    uidPost = user!.uid;

    await FirebaseFirestore.instance
        .collection('user')
        .doc(uidPost)
        .get()
        .then((value) {
      UserModel userModel = UserModel.fromMap(value.data()!);
      name = userModel.name;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        actions: [
          ShowIconButton(
              iconData: Icons.check,
              pressFunc: () async {
                // print(
                //     'uidPost ==> $uidPost, artical ==> $article, nameButton = => $nameButton');
                // print('links ===>> $links');
                // print('urlPath ==> $urlPath');

                DateTime dateTime = DateTime.now();
                Timestamp timePost = Timestamp.fromDate(dateTime);

                PostModel postModel = PostModel(
                    uidPost: uidPost!,
                    urlPaths: urlPath,
                    article: article,
                    link: links,
                    nameButton: nameButton,
                    name: name!,
                    timePost: timePost);

                print('postModel ==>> ${postModel.toMap()}');

                await FirebaseFirestore.instance
                    .collection('post')
                    .doc()
                    .set(postModel.toMap())
                    .then((value) {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MainHome(),
                      ),
                      (route) => false);
                });
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
                    label: 'Link URL +',
                    pressFunc: () {
                      indexTextFromField++;
                      setState(() {
                        widgetLinks.add(createTextFromFiew(indexTextFromField));
                      });
                    }),
                ShowForm(
                  label: 'ชื่อปุ่ม',
                  iconData: Icons.bookmark,
                  changeFunc: (String string) {
                    nameButton = string.trim();
                  },
                ),
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
        decoration: InputDecoration(
          enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
        ),
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
            onChanged: (value) {
              article = value.trim();
            },
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
