import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_health_assistant/src/styles/colors.dart';

// ignore: must_be_immutable
class ContainerOfContent extends StatefulWidget {
  ContainerOfContent({
    Key? key,
    required this.image,
    required this.content,
    required this.onPressed,
  }) : super(key: key);

  final TextEditingController content;
  File? image;
  final VoidCallback onPressed;
  @override
  State<ContainerOfContent> createState() => _ContainerOfContentState();
}

class _ContainerOfContentState extends State<ContainerOfContent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      decoration: BoxDecoration(
          border: Border.all(), borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: TextFormField(
                // keyboardType: TextInputType.multiline,
                minLines: 1,
                maxLines: null,
                controller: widget.content,
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Write something here...',
                    hintStyle: TextStyle(
                        color: MyColors.greyText,
                        fontSize: 15,
                        fontWeight: FontWeight.w400)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 16),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: SizedBox(
                    child: widget.image != null
                        ? Image.file(widget.image!,
                            height: 150, fit: BoxFit.fill)
                        : null),
              ),
            ),
            Align(
                alignment: Alignment.bottomRight,
                child: IconButton(
                    iconSize: 30,
                    onPressed: widget.onPressed,
                    icon: const Icon(Icons.camera_alt)))
          ],
        ),
      ),
    );
  }
}
