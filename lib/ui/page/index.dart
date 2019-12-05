
import 'package:flutter/material.dart';

import 'package:alipay_fluttur/ui/page/friends/firends_page.dart';
import 'package:alipay_fluttur/ui/page/home/home_page.dart';
import 'package:alipay_fluttur/ui/page/my/my_page.dart';
import 'package:alipay_fluttur/ui/page/sale/sale_page.dart';
import 'package:alipay_fluttur/ui/page/wealth/wealth_page.dart';
import 'package:alipay_fluttur/common/style/resources.dart';

class IndexPage extends StatefulWidget {
  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  PageController pageController = PageController(initialPage: 0);
  int currentIndex = 0;
  Color grayColor = Colours.text_gray;
  Color activeColor = Colours.app_main_light;

  @override
  Widget build(BuildContext context) {

    double rpx = MediaQuery.of(context).size.width / 750;

    return Scaffold(
      body: PageView(
        controller: pageController,
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[
          HomePage(),
          WealthPage(),
          SalePage(),
          FriendsPage(),
          MyPage(),
        ],
      ),
      bottomNavigationBar: Theme(
          data: ThemeData(
              brightness: Brightness.light,
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent),
          child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: currentIndex,
              onTap: (index) {
                pageController.jumpToPage(index);
                setState(() {
                  currentIndex = index;
                });
              },
              items: [
                BottomNavigationBarItem(
                  icon: _buildBarItemIcon(PAYICons.home, 0, rpx, false),
                  title: _buildBarItemTitle('首页', 0),
                ),
                BottomNavigationBarItem(
                    icon: _buildBarItemIcon(PAYICons.wealth, 1, rpx, false),
                    title: _buildBarItemTitle('财富', 1)),
                BottomNavigationBarItem(
                    icon: _buildBarItemIcon(PAYICons.sale, 2, rpx, true),
                    title: _buildBarItemTitle('口碑', 2)),
                BottomNavigationBarItem(
                    icon: _buildBarItemIcon(PAYICons.friends, 3, rpx, false),
                    title: _buildBarItemTitle('朋友', 3)),
                BottomNavigationBarItem(
                    icon: _buildBarItemIcon(PAYICons.my, 4, rpx, true),
                    title: _buildBarItemTitle('我的', 4)),
              ])),
    );
  }

  Widget _buildBarItemTitle(String text, int index) {
    return Text(
      text,
      style: TextStyle(
          color: currentIndex == index ? activeColor : grayColor),
    );
  }

  Widget _buildBarItemIcon(IconData data, int index, double rpx, bool isSm) {
    return Icon(
      data,
      size: isSm ? 40 *rpx  :50 * rpx,
      color: currentIndex == index ? activeColor : grayColor,
    );
  }
}
