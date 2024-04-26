import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../common/AppLocalizations.dart';
import '../states/LocaleModel.dart';

class LanguageRoute extends StatelessWidget {

  const LanguageRoute({super.key});

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context).primaryColor;
    var localeModel = Provider.of<LocaleModel>(context);
    var localizations = AppLocalizations.of(context);


    return Scaffold(
      appBar: AppBar(
        title: Text(localizations!.language),
      ),
      body: ListView(
        children: <Widget>[
          _buildLanguageItem("中文简体", "zh_CN",localeModel,color),
          _buildLanguageItem("English", "en_US",localeModel,color),
          _buildLanguageItem(localizations!.auto, null,localeModel,color),
        ],
      ),
    );
  }

  Widget _buildLanguageItem(String lan, value,LocaleModel localeModel,Color color) {
    return ListTile(
      title: Text( lan, // 对APP当前语言进行高亮显示
        style: TextStyle(color: localeModel.locale == value ? color : null),
      ),
      trailing: localeModel.locale == value ? Icon(Icons.done, color: color) : null,
      onTap: () {
        // 此行代码会通知MaterialApp重新build
        localeModel.locale = value;
      },
    );
  }
}