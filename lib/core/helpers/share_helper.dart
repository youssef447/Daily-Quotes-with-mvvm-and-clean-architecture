import 'dart:math';
import 'dart:ui' as ui;
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';

///Helper Class resbonsible for sharing images for printing docs or sharing widgets as images (Qr)

abstract class ShareHelper {
  ///used for sharing widgets as Images
  static Future<void> captureAndShare({
    required RenderRepaintBoundary boundary,
  }) async {
    ui.Image image = await boundary.toImage(pixelRatio: 5);
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List pngBytes = byteData!.buffer.asUint8List();

    String mime = 'image/png';
    final XFile xfile =
        XFile.fromData(pngBytes, mimeType: mime, name: '${Random().nextInt(100)}.png');

    await Share.shareXFiles(
      [xfile],
    );
  }
}
