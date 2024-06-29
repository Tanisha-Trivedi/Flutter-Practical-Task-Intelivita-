import 'package:flutter/material.dart';

class CommonHeader extends StatelessWidget {
  final String header;
  const CommonHeader({super.key, required this.header});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Padding(
          padding: EdgeInsetsDirectional.only(top: 8.0),
          child: Divider(
            thickness: 2,
          ),
        ),
        Text(header),
        const Divider(
          thickness: 2,
        ),
      ],
    );
  }
}
