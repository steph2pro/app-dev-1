import 'dart:async';

import 'package:flutter/material.dart';

enum FeedbackType { success, error, warning, info }

class FeedbackOverlay {
  static final FeedbackOverlay _singleton = FeedbackOverlay._internal();

  factory FeedbackOverlay() {
    return _singleton;
  }

  FeedbackOverlay._internal();

  OverlayEntry? _overlayEntry;
  Timer? _timer;

  void show(
    BuildContext context,
    String message, {
    FeedbackType type = FeedbackType.info,
    int duration = 5,
  }) {
    print('mess:' + message);
    _overlayEntry?.remove();
    _timer?.cancel();

    _overlayEntry = _createOverlayEntry(context, message, type);
    Overlay.of(context)?.insert(_overlayEntry!);

    _timer = Timer(Duration(seconds: duration), () {
      dismiss();
    });
  }

  OverlayEntry _createOverlayEntry(
      BuildContext context, String message, FeedbackType type) {
    return OverlayEntry(
      builder: (context) => Positioned(
        top: MediaQuery.of(context).padding.top + 10,
        left: MediaQuery.of(context).size.width * 0.1,
        width: MediaQuery.of(context).size.width * 0.8,
        child: Material(
          color: Colors.transparent,
          child: _buildFeedbackContainer(context, message, type),
        ),
      ),
    );
  }

  Widget _buildFeedbackContainer(
      BuildContext context, String message, FeedbackType type) {
    Color backgroundColor;
    switch (type) {
      case FeedbackType.success:
        backgroundColor = Colors.green;
        break;
      case FeedbackType.error:
        backgroundColor = Colors.red;
        break;
      case FeedbackType.warning:
        backgroundColor = Colors.orange;
        break;
      case FeedbackType.info:
      default:
        backgroundColor = Colors.blue;
        break;
    }

    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              message,
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.close,
              color: Colors.white,
            ),
            onPressed: () {
              dismiss();
            },
          ),
        ],
      ),
    );
  }

  void dismiss() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    _timer?.cancel();
  }
}
