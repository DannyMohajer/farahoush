import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hexcolor/hexcolor.dart';

class CustomButtonWidget extends StatelessWidget {
  const CustomButtonWidget({
    super.key,
    required this.onTap,
    required this.title,
    this.isEnable = true,
    this.buttonColor,
    this.isLoading = false,
    this.padding = 0.0,
  });
  final Function onTap;
  final bool isEnable;
  final Color? buttonColor;
  final String title;
  final bool isLoading;
  final double padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap:
              isEnable
                  ? () {
                    if (isLoading) return;
                    onTap();
                  }
                  : null,
          borderRadius: BorderRadius.circular(7),
          child: Ink(
            width: double.infinity,
            height: 50,
            decoration: BoxDecoration(
              color:
                  !isEnable
                      ? const Color(0xff808080)
                      : buttonColor ?? Colors.blueAccent,
              gradient:
                  isEnable
                      ? LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [HexColor('#3186F3'), HexColor('#1169D7')],
                      )
                      : LinearGradient(
                        colors: [HexColor('#8A8E92'), HexColor('#8A8E92')],
                      ),
              borderRadius: BorderRadius.circular(14),
            ),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 250),
              child:
                  !isLoading
                      ? Text(
                        title,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      )
                      : const Center(
                        child: SpinKitThreeBounce(
                          size: 16,
                          color: Colors.white,
                        ),
                      ),
            ),
          ),
        ),
      ),
    );
  }
}
