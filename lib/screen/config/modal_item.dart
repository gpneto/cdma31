
import "package:flutter/cupertino.dart";

class ModalItem extends StatelessWidget {
  const ModalItem({
    Key key,
    this.iconAsset,
    this.iconData,
    @required this.label,
  }) : super(key: key);

  final String iconAsset;
  final String label;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(
            left: 8.0,
            right: 8.0,
          ),
          child: iconAsset != null
              ? Image.asset(
                  iconAsset,
                  scale: 3,
                )
              : Icon(iconData),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 20,
            fontFamily: "Edmondsans-Medium",
            color: Color.fromRGBO(0, 0, 0, 1.0),
          ),
          textScaleFactor: 1,
        ),
      ],
    );
  }
}
