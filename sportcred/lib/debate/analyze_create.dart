import 'dart:collection';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:sportcred/network/packet.dart';
import 'package:sportcred/sc_widget/bottom_tool_area.dart';
import 'package:sportcred/sc_widget/picture_grid_card.dart';
import 'package:sportcred/util/util.dart';

class AnalyzeCreate extends StatefulWidget {
  final int topicId;
  final String topic;

  AnalyzeCreate({
    Key key,
    @required this.topicId,
    @required this.topic,
  }) : super(key: key);


  @override
  AnalyzeCreateState createState() => AnalyzeCreateState();
}

class AnalyzeCreateState extends State<AnalyzeCreate> {
  FocusNode focusNode = FocusNode();
  TextEditingController controller = TextEditingController();
  LinkedHashMap<Widget, File> images = LinkedHashMap();
  List<Widget> selectedImage = [];

  bool hasSelected() => selectedImage.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Post", style: TextStyle(fontFamily: 'AmazonEmber')),
        centerTitle: true,
        actions: [
          IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => controller.clear()
          ),
          IconButton(
            icon: Icon(Icons.send),
            onPressed: () async {
              Packet packet = Packet(
                  fields: {
                    'content': controller.text,
                    'topicId': widget.topicId
                  },
                  files: {
                    'pictures': images.values.map((f) => f.path).toList()
                  },
                  endPoint: '/debate-and-analyze/post'
              );
              var progressDialog = ProgressDialog(context);
              focusNode.unfocus();
              await progressDialog.show();
              await packet.post();
              await progressDialog.hide();

              Navigator.of(context).pop(true);
            },
          )
        ],
      ),
      body: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () => focusNode.unfocus(),
          child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12),
              color: Colors.grey.withOpacity(0.1),
              child: ListView(
                  children: [
                    TextField(
                      autofocus: true,
                      keyboardType: TextInputType.multiline,
                      controller: controller,
                      focusNode: focusNode,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontFamily: 'AmazonEmber'
                      ),
                      decoration: InputDecoration(
                        hintText: "Topic: " + widget.topic,
                        fillColor: Colors.grey,
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        border: InputBorder.none,
                      ),
                      maxLines: 12,
                    ),
                    Divider(),
                    BottomToolArea(
                        children: [
                          FlatButton.icon(
                            label: amazonize('Image'),
                            onPressed: () async {
                              ImagePicker picker = ImagePicker();
                              var pickedImage = await picker.getImage(source: ImageSource.gallery);
                              setState(() {
                                images[
                                PictureGridCard(
                                  key: UniqueKey(),
                                  image: File(pickedImage.path),
                                  remove: (Widget widget) {
                                    setState(() {
                                      images.remove(widget);
                                      selectedImage.remove(widget);
                                    });
                                  },
                                  update: (Widget widget, bool inc) {
                                    setState(() {
                                      inc ? selectedImage.add(widget) : selectedImage.remove(widget);
                                    });
                                  },
                                )] = File(pickedImage.path);
                              });
                            },
                            icon: Icon(Icons.library_add),
                          ),
                          FlatButton.icon(
                            color: hasSelected() ? Colors.black.withOpacity(0.5) : null,
                            label: Text(
                                'Clear',
                                style: TextStyle(
                                    fontFamily: 'AmazonEmber',
                                    color: hasSelected() ? Colors.white : null
                                )
                            ),
                            onPressed: () {
                              setState(() {
                                if (hasSelected()) {
                                  selectedImage.forEach((element) {
                                    images.remove(element);
                                  });
                                  selectedImage.clear();
                                } else {
                                  images.clear();
                                }
                              });
                            },
                            icon: Icon(Icons.clear, color: hasSelected() ? Colors.white : null),
                          ),
                        ]
                    ),
                    Divider(),
                    GridView.count(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        crossAxisCount: 3,
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 5,
                        childAspectRatio: 1,
                        children: images.keys.toList()
                    )
                  ]
              )
          )
      ),
      floatingActionButton: null,
    );
  }
}