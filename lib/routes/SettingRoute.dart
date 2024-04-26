import 'package:flutter/material.dart';

class SettingRoute extends StatelessWidget{
  const SettingRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("设置"),
      ),
      body:
      Center(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  //切换语言
                  Navigator.of(context).pushNamed("language_page",arguments: "切换语言");
                },
                child: Container(
                  margin: const EdgeInsets.only(top: 1),
                  color: Colors.grey[200],
                  padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
                  width: double.infinity,
                  child: const Row(
                    children: <Widget>[
                      Icon(
                        Icons.lan,
                        size: 18,
                      ),
                      Text(
                        "切换语言",
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.grey,
                            size: 12,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  //切换主题
                  Navigator.of(context).pushNamed("theme_page",arguments: "切换主题");
                },
                child: Container(
                  margin: const EdgeInsets.only(top: 1),
                  color: Colors.grey[200],
                  padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
                  width: double.infinity,
                  child: const Row(
                    children: <Widget>[
                      Icon(
                        Icons.theaters,
                        size: 18,
                      ),
                      Text(
                        "切换主题",
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.grey,
                            size: 12,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          )
      )


    );
  }
}