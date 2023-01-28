import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as img;
import 'dart:ui' as ui;

class ColorDetection {
  final GlobalKey? currentKey;
  final StreamController<Color>? stateController;
  final GlobalKey? paintKey;

  img.Image? photo;
  // const ColorDetection({Key key, this.title}) super(key: key);

  ColorDetection({
    Key? key,
    this.currentKey,
    this.stateController,
    this.paintKey,
  });

  Future<dynamic> searchPixel(Offset globalPosition) async {
    if (photo == null) {
      await loadSnapshotBytes();
    }
    return _calculatePixel(globalPosition);
  }

  _calculatePixel(Offset globalPosition) {
    RenderBox box = currentKey!.currentContext!.findRenderObject() as RenderBox;
    Offset localPosition = box.globalToLocal(globalPosition);

    double px = localPosition.dx; 
    double py = localPosition.dy;

    int pixel32 = photo!.getPixelSafe(px.toInt(), py.toInt()) as int;
    int hex = abgrToArgb(pixel32);

    stateController!.add(Color(hex));
    return Color(hex);
  }

  Future<void> loadSnapshotBytes() async {
    RenderRepaintBoundary boxPaint =
        paintKey!.currentContext!.findRenderObject() as RenderRepaintBoundary;
    ui.Image capture = await boxPaint.toImage();
    ByteData imageBytes = await (capture.toByteData(
        format: ui.ImageByteFormat.png) as FutureOr<ByteData>);
    setImageBytes(imageBytes);
    capture.dispose();
  }

  void setImageBytes(ByteData imageBytes) {
    Uint8List values = imageBytes.buffer.asUint8List();
    photo = null;
    photo = img.decodeImage(values);
  }
}

// image lib uses uses KML color format, convert #AABBGGRR to regular #AARRGGBB
int abgrToArgb(int argbColor) {
  int r = (argbColor >> 16) & 0xFF;
  int b = argbColor & 0xFF;
  return (argbColor & 0xFF00FF00) | (b << 16) | r;
}

class ProviderImageBG extends StatefulWidget {
  final ImageProvider imageProvider;

  const ProviderImageBG({Key? key, required this.imageProvider}) : super(key: key);
  @override
  _ProviderImageBGState createState() => _ProviderImageBGState();
}

class _ProviderImageBGState extends State<ProviderImageBG> {
  GlobalKey imageKey = GlobalKey();
  GlobalKey paintKey = GlobalKey();

  GlobalKey? currentKey;

  final StreamController<Color> stateController = StreamController<Color>();
  Color color1 = const Color(0xFFFFFFFF);
  Color color2 = const Color(0xFFFFFFFF);
  @override
  void initState() {
    currentKey = paintKey;
    Timer.periodic(const Duration(seconds: 1), (callback) async {
      if (imageKey.currentState!.context.size!.height == 0.0) {
      } else {
        var cd1 = await ColorDetection(
          currentKey: currentKey,
          paintKey: paintKey,
          stateController: stateController,
        ).searchPixel(const Offset(18.2, 348.0));
        var cd12 = await ColorDetection(
          currentKey: currentKey,
          paintKey: paintKey,
          stateController: stateController,
        ).searchPixel(const Offset(230.9, 549.8));
        color1 = cd1;
        color2 = cd12;

        setState(() {});

        callback.cancel();
        stateController.close();
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: const Text("Image"),
        centerTitle: true,
        backgroundColor: color1,
      ),
      body: Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: const Alignment(
                    0.8, 0.8), // 10% of the width, so there are ten blinds.
                colors: [color1, color2], // whitish to gray
                tileMode:
                    TileMode.mirror, // repeats the gradient over the canvas
              ),
            ),
          ),
          RepaintBoundary(
            key: paintKey,
            child: Center(
              child: Image(
                image: widget.imageProvider,
                key: imageKey,
                fit: BoxFit.fitWidth,
                //scale: .8,
              ),
            ),
          ),
        ],
      ),
    );
  }
}