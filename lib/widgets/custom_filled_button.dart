import 'dart:async';

import 'package:flutter/material.dart';
import 'package:spotify_clone/authentication/register/register_view.dart';
import 'package:spotify_clone/constants/colors/colors.dart';

class CustomFilledButton extends StatefulWidget {
  final VoidCallback onPressed;
  final bool isDisabled;
  final bool withIcon;
  final IconData? icon;
  final String text;

  const CustomFilledButton({Key? key, required this.onPressed, this.isDisabled=false, this.withIcon = false, this.icon, required this.text})
      : super(key: key);

  @override
  State<CustomFilledButton> createState() => _CustomFilledButtonState();
}

class _CustomFilledButtonState extends State<CustomFilledButton> with TickerProviderStateMixin {
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
      },
      onTapDown: (details) {
        _controller.reverse();
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
            color: _onTapEffect ? AppColors.darkGreen : AppColors.lightGreen,
            borderRadius: BorderRadius.circular(30),

          ),
          child: widget.withIcon
              ? Text(
            widget.text,
            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 17, color: Colors.black),
          )
              : Stack(
            children: [
              Container(
                alignment: Alignment.center,
                child: Text(
                  widget.text,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 17,
                    color: Colors.black,
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
                    color: Colors.black,
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
