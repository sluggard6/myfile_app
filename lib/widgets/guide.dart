import 'package:flutter/material.dart';
import 'package:myfile_app/widgets/index.dart';

class Guide extends StatefulWidget {
  const Guide({super.key});

  @override
  State<Guide> createState() => GuideState();
}

class GuideState extends State<Guide> {
  // 是否显示引导页面
  bool show = false;
  dynamic get _guildItems => _buildGuideItem();

  @override
  Widget build(BuildContext context) {
    if (show) {
      return Scaffold(body: PageView(children: _guildItems));
    } else {
      return _mainPage();
    }
  }

  MainPageWidget _mainPage() {
    return const MainPageWidget();
  }

  List<GuideItem> _buildGuideItem() {
    //sleep(Duration(seconds: 5));
    return [
      GuideItem(body: const Text("1")),
      GuideItem(body: const Text("2")),
      GuideItem(buttonPressed: _toIndex),
    ];
  }

  void _toIndex() {
    show = false;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) {
          return _mainPage();
        },
      ),
    );
  }

  //_guidePages() {}
}

class GuideItem extends StatelessWidget {
  final VoidCallback? buttonPressed;
  final Widget? body;

  const GuideItem({super.key, this.buttonPressed, this.body});

  @override
  Widget build(BuildContext context) {
    var children = <Widget>[Center(child: body ?? const Text('default'))];
    if (buttonPressed != null) {
      children.add(
        Positioned(
          bottom: 200,
          child: ElevatedButton(
            onPressed: buttonPressed,
            child: const Text('go'),
          ),
        ),
      );
    }
    return ConstrainedBox(
      constraints: const BoxConstraints.expand(),
      child: Stack(alignment: Alignment.center, children: children),
    );
  }
}
