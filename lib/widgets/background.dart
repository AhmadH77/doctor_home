import 'package:flutter/material.dart';
import 'package:rapid_medical_info_system/constants/constants.dart';

class Background extends StatelessWidget {
  final Widget child;
  Widget? title;
  String? source = '';
  bool? withTitle;

  Background({
    Key? key,
    required this.child,
    this.source,
    this.title,
    this.withTitle = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      height: size.height,
      decoration: BoxDecoration(
          gradient: source == 'M'
              ? LinearGradient(
                  colors: [
                    Constants.dark_blue,
                    Constants.mid_blue,
                    Constants.blue,
                  ],
                )
              : null,
          color: source == 'P'
              ? Constants.teal
              : (source == 'A' ? Colors.black12 : null)),
      child: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[

            Positioned(
                right: 0,
                top: 40,
                child: Image.asset(
                  source == 'M'
                      ? 'assets/images/left2.png'
                      : (source == 'A'
                          ? 'assets/images/adminicon.png'
                          : 'assets/images/left.png'),
                )),
            Positioned(
                left: 0,
                bottom: 40,
                child: Image.asset(
                  source == 'A'
                      ? 'assets/images/adminicon2.png'
                      : 'assets/images/right.png',
                  color: source == 'M' ? Colors.lightBlueAccent : null,
                )),
            Positioned(
                top: 0,
                left: 40,
                child: Image.asset(
                  source == 'A'
                      ? 'assets/images/adminicon3.png'
                      : 'assets/images/top.png',
                  color: source == 'M' ? Constants.blue : null,
                )),
            withTitle ?? false
                ? Padding(
                padding: const EdgeInsets.all(30.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: title,
                ))
                : Container(),
            child
          ],
        ),
      ),
    );
  }
}
