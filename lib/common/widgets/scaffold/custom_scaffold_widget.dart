import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class CustomScaffoldWidget extends StatelessWidget {
  final Widget child;
  final String title;
  final bool backButton;
  const CustomScaffoldWidget({
    super.key,
    required this.child,
    required this.title,
    this.backButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      backgroundColor: Colors.grey[100],
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          title,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
            fontWeight: FontWeight.w700,
            fontSize: 16,
            color: HexColor('#595959'),
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.grey[100],
        surfaceTintColor: Colors.grey[100],
        leading:
            backButton
                ? IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(
                    Icons.arrow_back_ios_sharp,
                    size: 20,
                    color: Colors.black38,
                  ),
                )
                : null,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.sizeOf(context).height,
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: child,
      ),
    );
  }
}
