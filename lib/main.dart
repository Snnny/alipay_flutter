import 'dart:io';

import 'package:alipay_fluttur/ui/page/index.dart';
import 'package:flutter/material.dart';
import 'package:alipay_fluttur/common/style/resources.dart';
import 'package:flutter/services.dart';

void main() async {
  if (Platform.isAndroid) {
    // 以下两行 设置android状态栏为透明的沉浸。写在组件渲染之后，是为了在渲染后进行set赋值，覆盖状态栏，写在渲染之前MaterialApp组件会覆盖掉这个值。
    SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '支付宝',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colours.primarySwatch,
      ),
      home: IndexPage(),
    );
  }
}

