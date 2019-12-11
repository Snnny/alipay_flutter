import 'package:alipay_fluttur/common/style/resources.dart';
import 'package:alipay_fluttur/ui/page/address_book.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_marquee/flutter_marquee.dart';
import 'package:alipay_fluttur/ui/page/search.dart';

class SearchBar extends StatefulWidget {
  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {

  FocusNode _focusNode = FocusNode();
  TextEditingController textEditingController = TextEditingController();



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
                    child: GestureDetector(
                      onTap: (){
                        FocusScope.of(context).requestFocus(FocusNode());
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=> SearchPage(
                          controller: textEditingController,
                          focusNode: _focusNode,
                          hintText: '奖励金',
                        )));
                      },
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
                                  child: Text('奖励金'),
//                                  child: FlutterMarquee(
//                                      texts: ["生活费", "1212", "蚂蚁森林", "领取奖励金"].toList(),
//                                      onChange: (i) {
//                                        print('current-->$i');
//                                      },
//                                      duration: 6
//                                  ),
                                ),
                              ],
                            ),
                            Icon(Icons.timer, color: Colours.text_gray, size: 40 * rpx,)
                          ],
                        ),
                      ),
                    )
                ),
                Padding(
                  padding: EdgeInsets.only(left: 30 * rpx, right: 20 * rpx),
                  child: IconButton(
                    icon: Icon(
                      PAYICons.friends,
                      color: Colors.white,
                    ),
                    onPressed: (){
                      Navigator.of(context).push(CupertinoPageRoute(builder: (context)=> AddressBookPage()));
                    },
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
