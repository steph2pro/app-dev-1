import 'package:crush_app/gen/assets.gen.dart';
import 'package:crush_app/src/core/theme/dimens.dart';
import 'package:crush_app/src/shared/components/gap.dart';
import 'package:crush_app/src/shared/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class InputChatMessage extends StatefulWidget {
  final void Function(String) onSendMessage;
  const InputChatMessage({super.key, required this.onSendMessage});

  @override
  State<InputChatMessage> createState() => _InputChatMessageState();
}

class _InputChatMessageState extends State<InputChatMessage> {
  bool _inputTyped = false;
  TextEditingController _textController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    // Met automatiquement le focus sur le TextField
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    // Libérer le FocusNode pour éviter les fuites mémoire
    _focusNode.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      // color: context.colorScheme.onPrimary,
      child: _inputTyped
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: TextField(
                    controller: _textController,
                    focusNode: _focusNode,
                    maxLines: 4,
                    minLines: 1,
                    expands: false,
                    decoration: InputDecoration(
                      hintText: "Votre message ici",
                      hintStyle: TextStyle(
                          fontSize: 10, fontWeight: FontWeight.normal),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                          color: context.colorScheme.outline,
                        ),
                      ),
                      enabled: _inputTyped,
                      filled: true,
                      fillColor: context.colorScheme.outlineVariant,
                    ),
                    onChanged: (value) {
                      if (value == "") {
                        setState(() {
                          _inputTyped = false;
                        });
                      }
                    },
                    onTapOutside: (event) {
                      if (_textController.text == "")
                        setState(() {
                          _inputTyped = false;
                        });
                      print("tapped outside " + event.toString());
                    },
                  ),
                ),
                Gap.horizontal(width: 2),
                Container(
                  decoration: BoxDecoration(
                      color: context.colorScheme.primary,
                      borderRadius: BorderRadius.circular(Dimens.fullRadius)),
                  child: IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: () {
                      if (_textController.text.isNotEmpty) {
                        widget.onSendMessage(_textController.text);
                        _textController.clear();
                        setState(() {
                          _inputTyped = false;
                        });
                      }
                    },
                    color: context.colorScheme.onPrimary,
                  ),
                ),
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: context.colorScheme.onPrimary,
                    borderRadius: BorderRadius.circular(Dimens.doubleRadius),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _inputTyped = true;
                        _focusNode.requestFocus();
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 15, bottom: 15, left: 10, right: 10),
                      child: Text(
                        "Écrire un message",
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  ),
                ),
                SvgPicture.asset(
                  Assets.images.voiceicon,
                  width: 40,
                ),
                SvgPicture.asset(
                  Assets.images.pickpictureicon,
                  width: 40,
                ),
                SvgPicture.asset(
                  Assets.images.askdateicon,
                  width: 40,
                ),
                SvgPicture.asset(
                  Assets.images.icongift,
                  width: 40,
                ),
              ],
            ),
    );
  }
}
