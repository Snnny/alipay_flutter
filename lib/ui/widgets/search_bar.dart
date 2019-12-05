import 'package:alipay_fluttur/common/style/resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_marquee/flutter_marquee.dart';

class SearchBar extends StatefulWidget {
  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    double rpx = MediaQuery.of(context).size.width / 750;

    return SafeArea(
        top: true,
        child: Container(
          height: 80 * rpx,
          width: double.infinity,
          color: Colours.app_main,
          padding:
              EdgeInsets.symmetric(vertical: 10 * rpx, horizontal: 30 * rpx),
          child: Container(
            child: Row(
              children: <Widget>[
                Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 10 *rpx, horizontal: 20 *rpx),
                      decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5 * rpx),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Icon(Icons.search, color: Colours.text_gray, size: 40 * rpx,),
                              Container(
                                height: 60*rpx,
                                child: FlutterMarquee(
                                    texts: ["生活费", "1212", "蚂蚁森林", "领取奖励金"].toList(),
                                    onChange: (i) {
                                      print('current-->$i');
                                    },
                                    duration: 6
                                ),
                              ),
                            ],
                          ),
                          Icon(Icons.timer, color: Colours.text_gray, size: 40 * rpx,)
                        ],
                      ),
                )),
                Padding(
                  padding: EdgeInsets.only(left: 30 * rpx, right: 20 * rpx),
                  child: Icon(
                    PAYICons.friends,
                    color: Colors.white,
                  ),
                ),
                Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 50 * rpx,
                )
              ],
            ),
          ),
        ));
  }
}
