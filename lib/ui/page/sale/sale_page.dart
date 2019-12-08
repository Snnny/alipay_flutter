import 'dart:math';
import 'dart:ui';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:alipay_fluttur/common/style/resources.dart';

/// 二楼示例页面
class SalePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SalePageState();
  }
}

class SalePageState extends State<SalePage> {
  ScrollController controller;

  double _offsetY = 130;
  double expandedHeight = 300;
  bool secret = false;

  @override
  void initState() {
    super.initState();
    controller = ScrollController(initialScrollOffset: _offsetY);
    controller.addListener(() {
      setState(() {
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  updateExpandedHeight(height) {
    print('updateExpandedHeight:$height');
    setState(() {
      expandedHeight = height;
    });
  }

  changeSecret() {
    setState(() {
      secret = !secret;
    });
  }

  /// 手指抬起事件
  _handleUp(pos) {
    double _scrollY = controller.position.pixels;
    if(_scrollY > 0 && _scrollY < _offsetY) {
      if(_scrollY > 60) {
        controller.position.animateTo(_offsetY, duration: Duration(milliseconds: 100),curve: Curves.ease);
      } else {
        controller.position.animateTo(0, duration: Duration(milliseconds: 100),curve: Curves.ease);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double rpx = MediaQuery.of(context).size.width / 750;

    return Scaffold(
      body: Listener(
        onPointerUp: _handleUp,
        child: CustomScrollView(
          controller: controller,
          slivers: <Widget>[
            SliverAppBar(
              pinned: true,
              expandedHeight: expandedHeight,
              title: Text('财富'),
              leading: Icon(
                PAYICons.ke_fu,
                color: Colors.white,
              ),
              actions: <Widget>[
                IconButton(
                    icon: Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    onPressed: null)
              ],
              flexibleSpace: FlexibleSpaceBar(
                background: TopHeaderCallback(
                  controller: controller,
                  updateHeight: updateExpandedHeight,
                  secret: secret,
                  changeSecret: changeSecret,
                ),
                collapseMode: CollapseMode.none,
              ),
            ),
            SliverGrid(
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200.0,
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
                childAspectRatio: 3.0, //子控件宽高比
              ),
              delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                  return Card(
                    child: Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.all(10),
                      child: Text('data $index'),
                    ),
                  );
                },
                childCount: 20,
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                //返回组件集合
                List.generate(20, (int index) {
                  //返回 组件
                  return GestureDetector(
                    onTap: () {
                      print("点击$index");
                    },
                    child: Card(
                      child: Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.all(10),
                        child: Text('data $index'),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TopHeader extends StatefulWidget {
  TopHeader({Key key, this.controller, this.secret, this.changeSecret});

  final ScrollController controller;
  final bool secret;
  final VoidCallback changeSecret;

  @override
  _TopHeaderState createState() => _TopHeaderState();
}

class _TopHeaderState extends State<TopHeader> {
  @override
  Widget build(BuildContext context) {
    double marginTop =
        MediaQueryData.fromWindow(window).padding.top + kToolbarHeight;
    double rpx = MediaQuery.of(context).size.width / 750;

    TextStyle titleStyle = TextStyle(color: Colors.white, fontSize: 26 * rpx);
    TextStyle contentStyle = TextStyle(color: Colours.app_main_light, fontSize: 24 * rpx);
    BorderSide borderSide = BorderSide(width: .2, color: Colors.grey[800]);
    double _offset = max(widget.controller.position.pixels, 0);
    double _angle = min(_offset / 130, 1);
    print('滑动${_offset}, 角度$_angle');

    return Container(
      margin: EdgeInsets.only(top: marginTop),
      child: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                height: 40,
                padding: EdgeInsets.only(left: 20 * rpx, right: 20 * rpx),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          '总资产',
                          style: TextStyle(color: Colours.app_main_light),
                        ),
                        SizedBox(width: 20*rpx,),
                        GestureDetector(
                          onTap: widget.changeSecret,
                          child: AnimatedCrossFade(
                              firstChild: Icon(Icons.remove_red_eye, color: Colors.white,),
                              secondChild: Icon(Icons.lock_outline, color: Colors.white,),
                              crossFadeState: widget.secret ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                              duration: Duration(milliseconds: 200)
                          ),
                        )
                      ],
                    ),
                    Text(
                      '昨日收益',
                      style: TextStyle(color: Colours.app_main_light),
                    ),
                  ],
                ),
              ),
              Container(
                height: 50,
                padding: EdgeInsets.only(
                    right: 20 * rpx, left: 20 * rpx, bottom: 20 * rpx),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      widget.secret ? '****': '123,456.78',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 50 * rpx,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      widget.secret ? '****': '+4.7',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 50 * rpx,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Container(
                child: Row(
                  children: <Widget>[
                    Expanded(
                        flex: 1,
                        child: Container(
                          height: 70 * rpx,
                          padding: EdgeInsets.only(left: 20*rpx, right: 10*rpx),
                          decoration: BoxDecoration(
                              border: Border(
                            bottom: borderSide,
                            top: borderSide,
                            right: borderSide,
                          )),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              _buildRow(rpx: rpx, titleStyle: titleStyle, title: '余额宝', content: widget.secret ? '****':  '123,456,789', contentStyle: contentStyle ),
                              Text(
                                widget.secret ? '****': '+4.7',
                                style: titleStyle,
                              ),
                            ],
                          ),
                        )),
                    Expanded(
                        flex: 1,
                        child: Container(
                          height: 70 * rpx,
                          padding: EdgeInsets.only(left: 10*rpx, right: 20*rpx),
                          decoration: BoxDecoration(
                              border:
                                  Border(bottom: borderSide, top: borderSide)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              _buildRow(rpx: rpx, titleStyle: titleStyle, title: '理财', content: widget.secret ? '****': '123,456', contentStyle: contentStyle ),
                              Text(
                                '客观别急',
                                style: titleStyle,
                              ),
                            ],
                          ),
                        )),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                    left: 20 * rpx, top: 25 * rpx, bottom: 25 * rpx),
                alignment: Alignment.centerLeft,
                child: Text(
                  '我的额度',
                  style: TextStyle(color: Colours.app_main_light),
                ),
              ),
              Container(
                child: Row(
                  children: <Widget>[
                    Expanded(
                        flex: 1,
                        child: Container(
                          height: 70 * rpx,
                          padding: EdgeInsets.only(left: 20*rpx, right: 10*rpx),
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: borderSide,
                                  top: borderSide,
                                  right: borderSide)),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child:  Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                _buildRow(rpx: rpx, titleStyle: titleStyle, title: '花呗', content: widget.secret ? '****': '123,456', contentStyle: contentStyle ),
                              ],
                            ),
                          ),
                        )),
                    Expanded(
                        flex: 1,
                        child: Container(
                          height: 70 * rpx,
                          padding: EdgeInsets.only(left: 10*rpx, right: 20*rpx),
                          decoration: BoxDecoration(
                              border:
                                  Border(bottom: borderSide, top: borderSide)),
                          child:  Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              _buildRow(rpx: rpx, titleStyle: titleStyle, title: '备用金', content: widget.secret ? '****': '500', contentStyle: contentStyle ),
                            ],
                          ),
                        )),
                  ],
                ),
              ),
              SizedBox(height: 20*rpx,)
            ],
          ),
          Positioned(
            bottom: _offset + 20*rpx ,
            left: 0,
            right: 0,
            child: Container(
              height: 20 *rpx,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Transform.rotate(
                  angle: pi * _angle,
                  child: Icon(
                    Icons.keyboard_arrow_up,
                    color: Colours.app_main_light,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRow({double rpx, TextStyle titleStyle, TextStyle contentStyle, String title, String content}) {
    return Row(
      children: <Widget>[
        Text(
          title,
          style: titleStyle,
        ),
        SizedBox(width: 10*rpx,),
        Text(
          content,
          style: contentStyle,
        ),
      ],
    );
  }
}

class TopHeaderCallback extends StatefulWidget {
  TopHeaderCallback({Key key, this.updateHeight, this.controller, this.secret, this.changeSecret});

  final Function(double) updateHeight;
  final ScrollController controller;
  final bool secret;
  final VoidCallback changeSecret;

  @override
  _TopHeaderCallbackState createState() => _TopHeaderCallbackState();
}

class _TopHeaderCallbackState extends State<TopHeaderCallback>
    with AfterLayoutMixin {
  @override
  Widget build(BuildContext context) {
    return TopHeader(
      controller: widget.controller,
      secret: widget.secret,
      changeSecret: widget.changeSecret,
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    // TODO: implement afterFirstLayout
    RenderBox box = context.findRenderObject();
    double height =
        box.getMaxIntrinsicHeight(MediaQuery.of(context).size.width);
    print('after----$height');

    /// 不知道为啥多出44
    widget.updateHeight(height - 44);
  }
}
