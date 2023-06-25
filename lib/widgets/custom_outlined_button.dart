import 'dart:async';

import 'package:flutter/material.dart';
import 'package:spotify_clone/constants/colors/colors.dart';

class CustomOutlinedButton extends StatefulWidget {
  final VoidCallback onPressed;
  final bool isDisabled;
  final bool withIcon;
  final IconData? icon;
  final String text;

  const CustomOutlinedButton({Key? key, required this.onPressed, this.isDisabled = false, this.withIcon = false, this.icon, required this.text})
      : super(key: key);

  @override
  State<CustomOutlinedButton> createState() => _CustomOutlinedButtonState();
}

class _CustomOutlinedButtonState extends State<CustomOutlinedButton> with TickerProviderStateMixin {
  late AnimationController _controller;
  double _scale = 1;
  bool _onTapEffect = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      lowerBound: 0.98,
      upperBound: 1.0,
      value: 1,
      duration: const Duration(milliseconds: 10),
    );
    _controller.addListener(() {
      setState(() {
        _scale = _controller.value;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        _controller.reverse();
        widget.onPressed();
        print("On pressed");
      },
      onTapDown: (details) {
        _controller.reverse();
        print("ndn");
        setState(() {
          _onTapEffect = true;
        });
      },
      onTapUp: (details) {
        Timer(const Duration(milliseconds: 100), () {
          _controller.fling();
        });
        setState(() {
          _onTapEffect = false;
        });
      },
      onTapCancel: () {
        _controller.fling();
        setState(() {
          _onTapEffect = false;
        });
      },
      child: Transform.scale(
        scale: _scale,
        child: Container(
          alignment: Alignment.center,
          height: MediaQuery.of(context).size.height * 0.065,
          width: MediaQuery.of(context).size.width * 0.8,
          decoration: BoxDecoration(
            color: _onTapEffect ? Colors.grey[850] : Colors.transparent,
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: Colors.grey.shade800, width: 0.5),
          ),
          child: widget.withIcon
              ? Text(
                  widget.text,
                  style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 17, color: Colors.white),
                )
              : Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.6,
                      alignment: Alignment.center,
                      child: Text(
                        textAlign: TextAlign.center,
                        widget.text,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 17,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Positioned(
                      child: Container(
                        // color: Colors.orange,
                        padding: const EdgeInsets.only(left: 15),
                        alignment: Alignment.centerLeft,
                        child: Icon(
                          widget.icon,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
