import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../common/AppLocalizations.dart';
import '../common/Global.dart';
import '../states/ThemeModel.dart';

class ThemeChangeRoute extends StatelessWidget{
  const ThemeChangeRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.theme),
      ),
      body: ListView( //显示主题色块
        children: Global.themes.map<Widget>((element) {
          return GestureDetector(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
              child: Container(
                color: element,
                height: 50,
              ),
            ),
            onTap: () {
              //主题更新后，MaterialApp会重新build
              Provider.of<ThemeModel>(context, listen: false).theme = element;
            },
          );
        }).toList(),
      ),
    );
  }
}