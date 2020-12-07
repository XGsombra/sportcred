import 'dart:ui';

import 'package:flutter/material.dart';

class FoldableText extends StatefulWidget {
  final String text;
  final int maxLine;
  final TextStyle style;

  FoldableText({
    Key key,
    @required this.text,
    @required this.maxLine,
    @required this.style,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => FoldableTextState();

}

class FoldableTextState extends State<FoldableText> {
  bool fold = true;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, size) {
        var span = TextSpan(text: this.widget.text, style: this.widget.style);
        var paint = TextPainter(text: span, maxLines: this.widget.maxLine, textDirection: TextDirection.ltr);
        paint.layout(maxWidth: size.maxWidth);

        if (paint.didExceedMaxLines) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              fold ?
              Text(
                this.widget.text,
                style: this.widget.style,
                maxLines: this.widget.maxLine,
                overflow: TextOverflow.ellipsis,
              ) : Text(
                this.widget.text,
                style: this.widget.style,
              ),
              SizedBox(
                width: double.infinity,
                height: 20,
                child: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    setState(() {
                      fold = !fold;
                    });
                  },
                  child: Icon(fold ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_up),
                ),
              )
            ],
          );
        }
        return Container(
          padding: EdgeInsets.only(bottom: 10),
          child: Text(this.widget.text, style: this.widget.style)
        );
      },
    );
  }
}