import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'dart:math' as math;

class WaterMark extends StatefulWidget {
  WaterMark(
      {super.key, this.repeat = ImageRepeat.repeat, required this.painter});

  final WaterMarkPainter painter;
  final ImageRepeat repeat;

  @override
  State<WaterMark> createState() => _WaterMarkState();
}

class _WaterMarkState extends State<WaterMark> {
  late Future<MemoryImage> _memoryImageFuture;

  @override
  void initState() {
    _memoryImageFuture = _getWaterMarkImage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: FutureBuilder(
        future: _memoryImageFuture,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            // 如果单元水印还没有绘制好先返回一个空的Container
            return Container();
          } else {
            // 如果单元水印已经绘制好，则渲染水印
            return DecoratedBox(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: snapshot.data, // 背景图，即我们绘制的单元水印图片
                  repeat: widget.repeat, // 指定重复方式
                  alignment: Alignment.topLeft,
                ),
              ),
            );
          }
        },
      ),
    );
  }

  @override
  void didUpdateWidget(WaterMark oldWidget) {
    if (widget.painter.runtimeType != oldWidget.painter.runtimeType ||
        widget.painter.shouldRepaint(oldWidget.painter)) {
      _memoryImageFuture.then((value) => value.evict());
      _memoryImageFuture = _getWaterMarkImage();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _memoryImageFuture.then((value) => value.evict());
    super.dispose();
  }

  Future<MemoryImage> _getWaterMarkImage() async {
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);
    // 绘制单元水印并获取其大小
    final size = widget.painter.paintUnit(
        canvas, MediaQueryData.fromWindow(ui.window).devicePixelRatio);
    print('size: $size');
    final picture = recorder.endRecording();
    //将单元水印导为图片并缓存起来
    final img = await picture.toImage(size.width.ceil(), size.height.ceil());
    final byteData = await img.toByteData(format: ui.ImageByteFormat.png);
    final pngBytes = byteData!.buffer.asUint8List();
    return MemoryImage(pngBytes);
  }
}

abstract class WaterMarkPainter {
  Size paintUnit(Canvas canvas, double devicePixelRatio);

  bool shouldRepaint(covariant WaterMarkPainter oldPainter) => true;
}

class TextWaterMarkPainter extends WaterMarkPainter {
  TextWaterMarkPainter(
      {Key? key,
      double? rotate,
      EdgeInsets? padding,
      TextStyle? textStyle,
      required this.text,
      this.textDirection = TextDirection.ltr})
      : assert(rotate == null || rotate >= -90 && rotate <= 90),
        rotate = rotate ?? 0,
        padding = padding ?? const EdgeInsets.all(5.0),
        textStyle = textStyle ??
            TextStyle(color: Color.fromARGB(20, 0, 0, 0), fontSize: 14);

  double rotate; //文本旋转的度数，是角度不是弧度
  TextStyle textStyle; //文本样式
  EdgeInsets padding; //文本padding
  String text; //文本
  TextDirection textDirection;

  /* @override
  Size paintUnit(Canvas canvas, double devicePixelRatio) {
    //根据屏幕 devicePixelRatio 对文本样式中长度相关的一些值乘以devicePixelRatio
    final _textStyle = _handleTextStyle(textStyle, devicePixelRatio);
    final _padding = padding * devicePixelRatio;

    final builder = ui.ParagraphBuilder(_textStyle.getParagraphStyle(
        textDirection: textDirection,
        textAlign: TextAlign.start,
        textScaleFactor: devicePixelRatio));
    builder
      ..pushStyle(_textStyle.getTextStyle()) // textStyle 为 ui.TextStyle
      ..addText(text);

    ui.Paragraph paragraph = builder.build()
      ..layout(ui.ParagraphConstraints(width: double.infinity));

    //文本占用的真实宽度
    final textWidth = paragraph.longestLine.ceilToDouble();
    //文本占用的真实高度
    final textHeight = paragraph.height;
    // 将弧度转化为度数
    final radians = math.pi * rotate / 180;

    //通过三角函数计算旋转后的位置和size
    final orgSin = math.sin(radians);
    final sin = orgSin.abs();
    final cos = math.cos(radians).abs();

    final width = textWidth * cos;
    final height = textWidth * sin;
    final adjustWidth = textHeight * sin;
    final adjustHeight = textHeight * cos;

    if (orgSin >= 0) {
      canvas.translate(adjustWidth + _padding.left, _padding.top);
    } else {
      canvas.translate(_padding.left, height + _padding.top);
    }
    canvas.rotate(radians);

    // 绘制文本
    canvas.drawParagraph(paragraph, Offset.zero);
    return Size(
      width + adjustWidth + _padding.horizontal,
      height + adjustHeight + _padding.vertical,
    );
  }*/

  @override
  Size paintUnit(Canvas canvas, double devicePixelRatio) {
    final _textStyle = _handleTextStyle(devicePixelRatio);
    // final _textStyle = textStyle;
    final _padding = padding * devicePixelRatio;

    //构建文本画笔
    TextPainter painter = TextPainter(
      textDirection: TextDirection.ltr,
    );
    //添加文本和样式
    painter.text = TextSpan(text: text, style: _textStyle);
    //对文本进行布局
    painter.layout();

    //文本占用的真实宽度
    final textWidth = painter.width;
    final textHeight = painter.height;

    final radians = math.pi * rotate / 180;

    final orgSin = math.sin(radians);
    final sin = orgSin.abs();
    final cos = math.cos(radians).abs();

    final width = textWidth * cos;
    final height = textWidth * sin;

    final adjustWidth = textHeight * sin;
    final adjustHeight = textHeight * cos;

    if (orgSin >= 0) {
      canvas.translate(
        adjustWidth + _padding.left,
        _padding.top,
      );
    } else {
      canvas.translate(
        _padding.left,
        height + _padding.top,
      );
    }

    canvas.rotate(radians);
    painter.paint(canvas, Offset.zero);
    return Size(
      width + adjustWidth + _padding.horizontal,
      height + adjustHeight + _padding.vertical,
    );
  }

  @override
  bool shouldRepaint(covariant TextWaterMarkPainter oldPainter) {
    return oldPainter.rotate != rotate ||
        oldPainter.text != text ||
        oldPainter.padding != padding ||
        oldPainter.textDirection != textDirection ||
        oldPainter.textStyle != textStyle;
  }

  TextStyle _handleTextStyle(double devicePixelRatio) {
    var style = textStyle;
    double _scale(attr) => attr == null ? 1.0 : devicePixelRatio;
    return style.apply(
      decorationThicknessFactor: _scale(style.decorationThickness),
      letterSpacingFactor: _scale(style.letterSpacing),
      wordSpacingFactor: _scale(style.wordSpacing),
      heightFactor: _scale(style.height),
    );
  }
}

class StaggerTextWaterMarkPainter extends WaterMarkPainter {
  StaggerTextWaterMarkPainter(
      {Key? key,
      this.padding1,
      this.padding2 = const EdgeInsets.all(30),
      this.rotate,
      this.textStyle,
      this.staggerAxis = Axis.vertical,
      required this.text,
      String? text2})
      : text2 = text2 ?? text;

  String text; //文本
  String text2; //文本2
  TextStyle? textStyle; //文本样式
  double? rotate; //文本旋转的度数，是角度不是弧度
  EdgeInsets? padding1; //文本padding
  EdgeInsets padding2; //第二个文本的padding
  Axis staggerAxis;

  @override
  Size paintUnit(Canvas canvas, double devicePixelRatio) {
    final TextWaterMarkPainter painter = TextWaterMarkPainter(
        text: text,
        padding: padding1,
        rotate: rotate ?? 0,
        textStyle: textStyle);
    // 绘制第一个文本水印前保存画布状态，因为在绘制过程中可能会平移或旋转画布
    canvas.save();
    // 绘制第一个文本水印
    final size1 = painter.paintUnit(canvas, devicePixelRatio);
    // 绘制完毕后恢复画布状态。

    canvas.restore();
    // 确定交错方向
    bool vertical = staggerAxis == Axis.vertical;
    // 将 Canvas平移至第二个文本水印的起始绘制点
    canvas.translate(vertical ? 0 : size1.width, vertical ? size1.height : 0);
    painter
      ..padding = padding2
      ..text = text2;
    // 绘制第二个文本水印
    final size2 = painter.paintUnit(canvas, devicePixelRatio);
    return Size(
      vertical ? math.max(size1.width, size2.width) : size1.width + size2.width,
      vertical
          ? size1.height + size2.height
          : math.max(size1.height, size2.height),
    );
  }

  @override
  bool shouldRepaint(covariant StaggerTextWaterMarkPainter oldPainter) {
    return oldPainter.rotate != rotate ||
        oldPainter.text != text ||
        oldPainter.text2 != text2 ||
        oldPainter.staggerAxis != staggerAxis ||
        oldPainter.padding1 != padding1 ||
        oldPainter.padding2 != padding2 ||
        oldPainter.textStyle != textStyle;
  }
}

class WatermarkRoute extends StatelessWidget {
  const WatermarkRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return wStaggerTextWaterMark();
  }

  Widget wTextWaterMark() {
    return Stack(
      children: [
        page(),
        IgnorePointer(
          child: WaterMark(
            painter: TextWaterMarkPainter(
                text: "jeft@wang",
                textStyle: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w200,
                    color: Colors.black38),
                rotate: -20),
          ),
        )
      ],
    );
  }

  Widget wStaggerTextWaterMark() {
    return Stack(
      children: [
        page(),
        IgnorePointer(
          child: WaterMark(
            painter: StaggerTextWaterMarkPainter(
                text: "jeft@wang",
                text2: "非常牛逼",
                textStyle: TextStyle(color: Colors.black38),
                padding2: EdgeInsets.only(left: 10),
                rotate: -20),
          ),
        ),
      ],
    );
  }

  Widget page() {
    return Center(
      child: ElevatedButton(
        child: Text('按钮',
            style: TextStyle(
              fontSize: 10,
            )),
        onPressed: () => print('tab'),
      ),
    );
  }
}
