import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app_tdd/core/widget/platform_widgets.dart';

class PlatformDialogWidget extends PlatformWidget {
  String title;
  String content;
  String defaultActionText;

  PlatformDialogWidget(
      {@required this.title,
      @required this.content,
      @required this.defaultActionText});

  Future<bool> show(BuildContext context) async {
    return Platform.isIOS
        ? await showCupertinoDialog<bool>(
            context: context, builder: (context) => this)
        : await showDialog<bool>(
            context: context,
            builder: (context) => this,
          );
  }

  @override
  Widget buildCupertinoWidget(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(this.title),
      content: Text(this.content),
      actions: _actions(context),
    );
  }

  @override
  Widget buildMaterialDesignWidget(BuildContext context) {
    return AlertDialog(
      title: Text(this.title),
      content: Text(this.content),
      actions: _actions(context),
    );
  }

  List<Widget> _actions(BuildContext context) {
    return [
      PlatformActionWidget(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: Text(this.defaultActionText),
      )
    ];
  }
}

class PlatformActionWidget extends PlatformWidget {
  Widget child;
  VoidCallback onPressed;

  PlatformActionWidget({@required this.child, @required this.onPressed});

  @override
  Widget buildCupertinoWidget(BuildContext context) {
    return CupertinoDialogAction(
      child: this.child,
      onPressed: this.onPressed,
    );
  }

  @override
  Widget buildMaterialDesignWidget(BuildContext context) {
    return FlatButton(
      child: this.child,
      onPressed: this.onPressed,
    );
  }
}
