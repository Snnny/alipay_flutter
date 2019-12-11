import 'dart:math';

import 'package:alipay_fluttur/common/style/resources.dart';
import 'package:alipay_fluttur/ui/widgets/search_bar.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  SearchPage({
    Key key,
    @required this.controller,
    @required this.focusNode,
    this.hintText,
  });
  final TextEditingController controller;
  final FocusNode focusNode;
  final String hintText;

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
//  FocusNode focusNode = FocusNode();
//  TextEditingController controller = TextEditingController();

  bool showLeading = false;

  @override
  Widget build(BuildContext context) {
    double rpx = MediaQuery.of(context).size.width / 750;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(

        child: Column(
          children: <Widget>[
            SafeArea(
              top: true,
              child: Container(
                height: 80 *rpx,
                padding: EdgeInsets.symmetric(vertical: 10 *rpx, horizontal: 20 *rpx),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5 * rpx),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Container(
                        height: 60 * rpx,
                        child: SearchInput(
                          controller: widget.controller,
                          focusNode: widget.focusNode,
                          autofocus: false,
                          hintText: '测试2',
                          showLeading: false,
                          isShowSuffixIcon: true,
                        ),
                      )
                    ),
                    SizedBox(width: 20*rpx,),
                    InkWell(
                      onTap: (){
                        Navigator.of(context).pop();
                      },
                      child: Text('取消', style: TextStyle(color: Colours.app_main_light, fontSize: 30*rpx),),
                    )
                  ],
                ),
              )
            ),
            SizedBox(height: 40,),
            Card(
              elevation: 0.0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5 * rpx))), //设置圆角
              color: Colors.grey[200],
              child: Padding(
                padding: const EdgeInsets.only(top: 0),
                child: Row(
                  children: <Widget>[
                    showLeading ? Padding(
                      padding: EdgeInsets.only(left: 10*rpx, top: 5 * rpx, right: 10 *rpx),
                      child: Icon(Icons.search, color: Colours.text_gray, size: 40 *rpx,),
                    ): SizedBox(width:20*rpx),
                    Expanded(
                      flex: 1,
                      child: Container(
                        height: 60 * rpx,
                        child: TextField(
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(top: 10*rpx),
                            hintText: '搜索',
                            border: InputBorder.none,
                          ),
                        ),
                      )
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 10 * rpx),
                      child: widget.controller.text.length > 0 ? Transform.rotate(
                        angle: pi*0.25,
                        child: Icon(Icons.add_circle, color:Colours.text_gray, size: 35 *rpx,),
                      ) : Icon(Icons.videocam, color:Colours.text_gray, size: 40 *rpx,),
                    ),
                  ],
                ),
              ),
            ),
            SearchInput(
              controller: widget.controller,
              focusNode: widget.focusNode,
              autofocus: false,
              hintText: '测试',
              showLeading: true,
              isShowSuffixIcon: true,
            ),
            SearchInput(
              controller: widget.controller,
              focusNode: widget.focusNode,
              autofocus: false,
              hintText: '测试2',
              showLeading: false,
              isShowSuffixIcon: true,
            ),
            SearchInput(
              controller: widget.controller,
              focusNode: widget.focusNode,
              autofocus: false,
              hintText: '测试3',
              showLeading: true,
              isShowSuffixIcon: false,
            ),
          ],
        ),
      ),
    );
  }
}

class SearchInput extends StatefulWidget {

  SearchInput({
    Key key,
    @required this.controller,
    @required this.focusNode,
    this.hintText = '',
    this.showLeading = false,
    this.isShowSuffixIcon = false,
    this.onTap,
    this.autofocus,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final String hintText;
  final bool showLeading;
  final bool isShowSuffixIcon;
  final bool autofocus;
  final VoidCallback onTap;


  @override
  _SearchInputState createState() => _SearchInputState();
}

class _SearchInputState extends State<SearchInput> {
  @override
  Widget build(BuildContext context) {
    double rpx = MediaQuery.of(context).size.width / 750;
    return Card(
      elevation: 0.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5 * rpx))), //设置圆角
      color: Colors.grey[200],
      child: Padding(
        padding: const EdgeInsets.only(top: 0),
        child: Row(
          children: <Widget>[
            widget.showLeading ? Padding(
              padding: EdgeInsets.only(left: 10*rpx, top: 5 * rpx, right: 10 *rpx),
              child: Icon(Icons.search, color: Colours.text_gray, size: 40 *rpx,),
            ): SizedBox(width:20*rpx),
            Expanded(
                flex: 1,
                child: Container(
                  height: 60 * rpx,
                  child: TextField(
                    onTap: widget.onTap,
                    autofocus: widget.autofocus,
                    controller: widget.controller,
                    focusNode: widget.focusNode,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(top: 10*rpx),
                      hintText: widget.hintText,
                      border: InputBorder.none,
                    ),
                  ),
                )
            ),
            Padding(
              padding: EdgeInsets.only(right: 10 * rpx),
              child: widget.controller.text.length > 0
                  ? Transform.rotate(
                    angle: pi*0.25,
                    child: Icon(Icons.add_circle, color:Colours.text_gray, size: 35 *rpx,),
                  ) : widget.isShowSuffixIcon ? Icon(Icons.videocam, color:Colours.text_gray, size: 40 *rpx,) : Container()
            ),
          ],
        ),
      ),
    );
  }
}

