import 'dart:io';

import 'package:flutter/material.dart';
import 'package:myfile_app/components/global.dart';
import 'package:myfile_app/widgets/index.dart';
import 'package:provider/provider.dart';

class Guide extends StatefulWidget {
  const Guide({Key? key}) : super(key: key);

  @override
  _GuideState createState() => _GuideState();
}

class _GuideState extends State<Guide> {
  // 是否显示引导页面
  bool _show = false;
  get _guildItems => _buildGuideItem();

  set show(bool show) => _show = show;
  get shwo => _show;

  @override
  Widget build(BuildContext context) {
    if (_show) {
      return Scaffold(
        body: PageView(
          children: _guildItems,
        ),
      );
    } else {
      return _mainPage();
    }
  }

  _mainPage() {
    return ChangeNotifierProvider(
      create: (BuildContext context) => UserModel(),
      child: const MainPageWidget(),
    );
  }

  _buildGuideItem() {
    //sleep(Duration(seconds: 5));
    return [
      GuideItem(
        body: const Text("1"),
      ),
      GuideItem(body: const Text("2")),
      GuideItem(
        buttonPressed: _toIndex,
      )
    ];
  }

  _toIndex() {
    _show = false;
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return _mainPage();
    }));
  }

  //_guidePages() {}
}

class GuideItem extends StatelessWidget {
  VoidCallback? buttonPressed;
  Widget? body;

  GuideItem({Key? key, this.buttonPressed, this.body}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var children = <Widget>[
      Center(
        child: body ?? const Text('default'),
      )
    ];
    if (buttonPressed != null) {
      children.add(Positioned(
        bottom: 200,
        child: ElevatedButton(
          child: const Text('go'),
          onPressed: buttonPressed,
        ),
      ));
    }
    return ConstrainedBox(
        constraints: const BoxConstraints.expand(),
        child: Stack(
          alignment: Alignment.center,
          children: children,
        ));
  }
}
