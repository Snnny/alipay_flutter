import 'dart:math';
import 'dart:ui';

import 'package:after_layout/after_layout.dart';
import 'package:alipay_fluttur/ui/widgets/load_image.dart';
import 'package:flutter/material.dart';
import 'package:alipay_fluttur/common/style/resources.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class WealthPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return WealthPageState();
  }
}

class WealthPageState extends State<WealthPage> with AutomaticKeepAliveClientMixin {
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
    print(_scrollY==0);
    if(_scrollY > 0 && _scrollY < _offsetY) {
      if(_scrollY > 60) {
        controller.position.animateTo(_offsetY, duration: Duration(milliseconds: 100),curve: Curves.ease);
      } else {
        controller.position.animateTo(0, duration: Duration(milliseconds: 100),curve: Curves.ease);
      }
    }
  }

  /// 展示财富细节
  _handleInfo() {
    double _scrollY = controller.position.pixels;
    print('_handleInfo$_scrollY');
    if(_scrollY == 0) {
      controller.position.animateTo(_offsetY, duration: Duration(milliseconds: 100),curve: Curves.ease);
    } else {
      controller.position.animateTo(_offsetY, duration: Duration(milliseconds: 100),curve: Curves.ease);
    }
  }
  ///
  @override
  Widget build(BuildContext context) {
    double rpx = MediaQuery.of(context).size.width / 750;

    return Scaffold(
      body: Listener(
        onPointerUp: _handleUp,
        child: CustomScrollView(
          physics: ClampingScrollPhysics(),
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
                  handleInfo: _handleInfo,
                ),
                collapseMode: CollapseMode.none,
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 20*rpx),
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 30*rpx,),
                    _buildNav(rpx),
                    SizedBox(height: 30*rpx,),
                    _buildAd(rpx),
                    SizedBox(height: 30*rpx,),
                    _buildTitle(rpx, '财富直通车', '更多'),
                    SizedBox(height: 30*rpx,),
                    _buildBanner(rpx),
                    SizedBox(height: 30*rpx,),
                    _buildTitle(rpx, '稳健理财', '更多'),
                    SizedBox(height: 30*rpx,),
                    _buildCard(rpx),
                    SizedBox(height: 30*rpx,),
                    _buildTitle(rpx, '精选投资', ''),
                    _buildCard(rpx),
                    _buildFooter(rpx),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 顶部导航
  Widget _buildNav(double rpx) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20*rpx),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            children: <Widget>[
              Icon(PAYICons.yu_e_bao, color: Colours.app_main, size: 50*rpx,),
              SizedBox(height: 5*rpx,),
              Text('余额宝', style: TextStyle(fontSize: 26*rpx),)
            ],
          ),
          Column(
            children: <Widget>[
              Icon(PAYICons.yu_e_bao, color: Colours.app_main, size: 50*rpx,),
              SizedBox(height: 5*rpx,),
              Text('理财', style: TextStyle(fontSize: 26*rpx),)
            ],
          ),
          Column(
            children: <Widget>[
              Icon(PAYICons.yu_e_bao, color: Colours.app_main, size: 50*rpx,),
              SizedBox(height: 5*rpx,),
              Text('基金', style: TextStyle(fontSize: 26*rpx),)
            ],
          ),
          Column(
            children: <Widget>[
              Icon(PAYICons.yu_e_bao, color: Colours.app_main, size: 50*rpx,),
              SizedBox(height: 5*rpx,),
              Text('黄金', style: TextStyle(fontSize: 26*rpx),)
            ],
          ),
          Column(
            children: <Widget>[
              Icon(PAYICons.yu_e_bao, color: Colours.app_main, size: 50*rpx,),
              SizedBox(height: 5*rpx,),
              Text('股票', style: TextStyle(fontSize: 26*rpx),)
            ],
          ),
          Column(
            children: <Widget>[
              Icon(PAYICons.yu_e_bao, color: Colours.app_main, size: 50*rpx,),
              SizedBox(height: 5*rpx,),
              Text('更多', style: TextStyle(fontSize: 26*rpx),)
            ],
          ),
        ],
      ),
    );
  }

  /// 活动图
  Widget _buildAd(double rpx) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20*rpx),
      width: double.infinity,
      height: 100*rpx,
      decoration: BoxDecoration(
        color: Colours.app_main_light,
        borderRadius: BorderRadius.circular(5*rpx)
      ),
      child: LoadImage('ad-2', format: 'jpg', fit: BoxFit.fitWidth,),
    );
  }

  /// 轮播图
  Widget _buildBanner(double rpx) {
    return Container(
      height: 330 * rpx,
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return Container(
            width: 600*rpx,
            height: 300*rpx,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30*rpx),
              color: Colors.blueAccent,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey[400],
                  offset: Offset(5.0, 5.0),
                  blurRadius: 10.0,
                  spreadRadius: 2.0
                ),

              ]
            ),
            margin: EdgeInsets.only(bottom: 30*rpx),
//            child: Image.network(
//              "http://via.placeholder.com/288x188",
//              fit: BoxFit.fill,
//            ),
          );
        },
        loop: false,
        itemCount: 5,
        viewportFraction: 0.8,
        scale: 0.9,
        pagination: SwiperCustomPagination(
            builder: (BuildContext context, SwiperPluginConfig config) {
              return Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    margin: EdgeInsets.only(bottom: 5),
                    child: _customPagination(config),
                  ));
            }),
      ),
    );
  }

  /// 自定义指示器
  Widget _customPagination(SwiperPluginConfig config) {
    List<int> list = List.generate(config.itemCount, (int index) {
      return index;
    });
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: list.map((item) {
        return Container(
          margin: EdgeInsets.only(right: 3),
          width: config.activeIndex == item ? 12 : 5,
          height: 4,
          color:
          config.activeIndex == item ? Colours.app_main : Colors.grey,
        );
      }).toList(),
    );
  }

  /// 标题
  Widget _buildTitle(double rpx, String title,[String subTitle]) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20*rpx),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontSize: 32*rpx, fontWeight: FontWeight.bold),
          ),
          subTitle.isEmpty ? Text('') : Text(subTitle, style: TextStyle(fontSize: 24*rpx, color: Colours.text_gray))
        ],
      ),
    );
  }

  /// 稳健理财
  Widget _buildCard(double rpx) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20*rpx),
      child: _card(
          child: Container(
            padding: EdgeInsets.all(20*rpx),
            height: 250*rpx,
            color: Colors.white,
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: EdgeInsets.only(left: 10*rpx),
                    decoration: BoxDecoration(
                      border: Border(
                        right: BorderSide(width: .5, color: Colours.bg_color)
                      )
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('买卖灵活', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30*rpx),),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('3.38%', style: TextStyle(color: Colours.red, fontSize: 40*rpx),),
                            Text('近一年收益率', style: TextStyle(color: Colours.text_gray, fontSize: 24*rpx), maxLines: 1, overflow: TextOverflow.ellipsis,),
                          ],
                        ),
                        Text('建信闲钱佳', style: TextStyle(fontSize: 24*rpx), maxLines: 1, overflow: TextOverflow.ellipsis,),
                      ],
                    ),
                  )
                ),
                Expanded(
                    flex: 1,
                    child: Container(
                      margin: EdgeInsets.only(left: 10*rpx),
                      decoration: BoxDecoration(
                          border: Border(
                              right: BorderSide(width: .5, color: Colours.bg_color)
                          )
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('买卖灵活', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30*rpx),),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text('3.38%', style: TextStyle(color: Colours.red, fontSize: 40*rpx),),
                              Text('七日年化', style: TextStyle(color: Colours.text_gray, fontSize: 24*rpx), maxLines: 1, overflow: TextOverflow.ellipsis,),
                            ],
                          ),
                          Text('长江养老半年享', style: TextStyle(fontSize: 24*rpx), maxLines: 1, overflow: TextOverflow.ellipsis,),
                        ],
                      ),
                    )
                ),
                Expanded(
                    flex: 1,
                    child: Container(
                      margin: EdgeInsets.only(left: 10*rpx),
                      decoration: BoxDecoration(
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('买卖灵活', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30*rpx),),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text('3.38%', style: TextStyle(color: Colours.red, fontSize: 40*rpx),),
                              Text('成立以来年化利率最高为', style: TextStyle(color: Colours.text_gray, fontSize: 24*rpx), maxLines: 1, overflow: TextOverflow.ellipsis,),
                            ],
                          ),
                          Text('国寿安鑫利360天哈哈哈哈', style: TextStyle(fontSize: 24*rpx), maxLines: 1, overflow: TextOverflow.ellipsis,),
                        ],
                      ),
                    )
                ),
              ],
            )
          )
      ),
    );
  }


  Widget _card({Widget child}) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: Colours.bg_color,
            blurRadius: 5,
          ),
        ],
      ),
      child: child,
    );
  }

  /// 底部
  Widget _buildFooter(double rpx) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20 *rpx),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: .3,
                width: 200*rpx,
                color: Colors.grey,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20*rpx),
                child: Text('蚂蚁财富',style: TextStyle(fontSize: 30*rpx, color: Colours.text_gray),),
              ),
              Container(
                height: .3,
                width: 200*rpx,
                color: Colors.grey,
              ),
            ],
          ),
          SizedBox(height: 10*rpx,),
          Text('过往业绩不预计产品未来表现，市场有风险，投资需谨慎 >', style: TextStyle(fontSize: 20*rpx, color: Colours.text_gray),)
        ],
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

class TopHeader extends StatefulWidget {
  TopHeader({Key key, this.controller, this.secret, this.changeSecret, this.handleInfo});

  final ScrollController controller;
  final bool secret;
  final VoidCallback changeSecret;
  final VoidCallback handleInfo;

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
//              color: Colors.redAccent,
              height: 20 *rpx,
              child: Transform.rotate(
                angle: pi * _angle,
                origin: Offset(0, 10),
                child: IconButton(
                  icon: Icon(Icons.keyboard_arrow_up,
                    color: Colours.app_main_light,),
                  onPressed: (){
                    print('click------');
                    widget.handleInfo();
                  },
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
  TopHeaderCallback({Key key, this.updateHeight, this.controller, this.secret, this.changeSecret, this.handleInfo});

  final Function(double) updateHeight;
  final ScrollController controller;
  final bool secret;
  final VoidCallback changeSecret;
  final VoidCallback handleInfo;

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
      handleInfo: widget.handleInfo,
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
