import 'package:ekuabo/utils/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BaseAlertDialog extends StatelessWidget {
  //When creating please recheck 'context' if there is an error!
  final _color = Style.homeBackgroundColor(1);

  String _title;
  String _content;
  String _yes;
  String _no;
  Function _yesOnPressed;
  Function _noOnPressed;

  BaseAlertDialog(
      {String title,
        String content,
        Function yesOnPressed,
        Function noOnPressed,
        String yes = "Yes",
        String no = "No"}) {
    this._title = title;
    this._content = content;
    this._yesOnPressed = yesOnPressed;
    this._noOnPressed = noOnPressed;
    this._yes = yes;
    this._no = no;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: new Text(
        this._title,
        style: Style.titleTextBoldStyle.merge(
          TextStyle(
            color: Style.textColor(1),
            fontSize: 14.0,
          ),
        ),
      ),
      content: new Text(this._content,
        style: Style.commonBoldTextStyle.merge(
          TextStyle(
            color: Style.textColor(1),
            fontSize: 14.0,
          ),
        ),),
      backgroundColor: this._color,
      shape:
      RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15)),
      actions: <Widget>[
        new FlatButton(
          child: new Text(this._yes,
            style: Style.titleTextStyle.merge(
              TextStyle(
                color: Style.textColor(1),
                fontSize: 14.0,
              ),
            ),),
          //textColor: Style.textColor(1),
          onPressed: () {
            this._yesOnPressed();
          },
        ),
        new FlatButton(
          child: Text(this._no,
            style: Style.titleTextStyle.merge(
              TextStyle(
                color: Colors.redAccent,
                fontSize: 14.0,
              ),
            ),),

          //textColor: Style.redColor(1),
          onPressed: () {
            this._noOnPressed();
          },
        ),
      ],
    );
  }
}