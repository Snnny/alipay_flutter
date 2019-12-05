import 'dart:ui';

import 'package:alipay_fluttur/ui/widgets/load_image.dart';
import 'package:alipay_fluttur/ui/widgets/search_bar.dart';
import 'package:alipay_fluttur/common/style/resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

const APPBAR_SCROLL_OFFSET = 50;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class NavItem {
  NavItem(
      {Key key,
      @required this.title,
      @required this.icon,
      this.iconColor: Colours.app_main});

  final String title;
  final IconData icon;
  final Color iconColor;
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  double appBarAlpha = 0;
  RefreshController _refreshController = RefreshController(initialRefresh: false);
  ScrollController scrollController = ScrollController();

  List<NavItem> navList = [
    NavItem(title: '转账', icon: PAYICons.zhuan_zhang),
    NavItem(
        title: '信用卡还款', icon: PAYICons.bank_card2, iconColor: Colours.yellow),
    NavItem(title: '充值中心', icon: PAYICons.iphone, iconColor: Colours.yellow),
    NavItem(title: '余额宝', icon: PAYICons.yu_e_bao, iconColor: Colours.red),
    NavItem(title: '花呗', icon: PAYICons.hua_bei),
    NavItem(title: '芝麻信用', icon: PAYICons.xin_yong, iconColor: Colours.green),
    NavItem(title: '城市服务', icon: PAYICons.city),
    NavItem(title: '体育服务', icon: PAYICons.sports),
    NavItem(title: '生活缴费', icon: PAYICons.jiao_fei),
    NavItem(title: '蚂蚁森林', icon: PAYICons.sen_lin, iconColor: Colours.green),
    NavItem(title: '我的快递', icon: PAYICons.post, iconColor: Colours.yellow),
    NavItem(title: '更多', icon: PAYICons.more, iconColor: Colours.green),
  ];

  List<Message> messageList = [
    Message(title: '余额宝收益到账啦', time: '3小时前', read: true),
    Message(title: '您的好友收取了您的能量', time: '4小时前', read: true),
    Message(title: '您的芝麻信用更新了', time: '7小时前', read: true),
  ];

  _onScroll(offset) {
    double alpha = offset / APPBAR_SCROLL_OFFSET;
    if (alpha < 0) {
      alpha = 0;
    } else if (alpha > 1) {
      alpha = 1;
    }
    setState(() {
      appBarAlpha = alpha;
    });
    print(appBarAlpha);
  }

  Future<void>  _onRefresh(){
    print('_onRefresh');
    _refreshController.refreshCompleted();
    return null;
  }

  Widget getItemContainer(NavItem item) {
    return Container(
      child: Column(
        children: <Widget>[
          Icon(
            item.icon,
            color: item.iconColor,
          ),
          SizedBox(
            height: 5,
          ),
          Text(item.title)
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double rpx = MediaQuery.of(context).size.width / 750;
    double navHeight = MediaQueryData.fromWindow(window).padding.top;
    return Scaffold(
      backgroundColor: Colours.bg_color,
      body: Container(
        color: Theme.of(context).accentColor,
        child: Stack(
          children: <Widget>[
            NotificationListener(
                onNotification: (scrollNotification) {
                  if (scrollNotification is ScrollUpdateNotification &&
                      scrollNotification.depth == 0) {
                    //滚动且是列表滚动的时候
                    _onScroll(scrollNotification.metrics.pixels);
                  }
                  return false;
                },
                child: _listView(rpx)),
            SearchBar(),
            _appBar(navHeight + 44.0, rpx)
          ],
        ),
      ),
    );
  }

  Widget _listView(double rpx) {
    return ListView(
      physics: ClampingScrollPhysics(),
      controller: scrollController,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 80 * rpx),
          height: 180 * rpx,
          color: Colours.app_main,
          child: _headerMenu(rpx),
        ),
        Container(
          color: Colors.white,
          padding:
              EdgeInsets.symmetric(vertical: 10 * rpx, horizontal: 15 * rpx),
          child: GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: navList.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4, childAspectRatio: 1.6),
              itemBuilder: (BuildContext context, int index) {
                return getItemContainer(navList[index]);
              }),
        ),
        _divide(),
        _homeMessage(rpx),
        _divide(),
        _buildSwiper(rpx),
        _divide(),
        Container(
          height: 500.0,
          color: Colors.white,
          padding:
          EdgeInsets.symmetric(horizontal: 25 * rpx, vertical: 30 * rpx),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _buildTitle(rpx, '惠支付'),
              _card(
                  child: Container(
                    height: 100,
                    color: Colors.white,
                    child: Text('我是card'),
                  )),
              _buildTitle(rpx, '生活服务'),
              _card(
                  child: Container(
                    height: 100,
                    color: Colors.white,
                    child: Text('我是card'),
                  )),
            ],
          ),
        )

      ],
    );
  }



//  Widget _reloadBody(double rpx){
//    return SmartRefresher(
//      controller: _refreshController,
//      header: WaterDropHeader(),
//      enablePullDown: true,
//      enablePullUp: false,
//      onRefresh: _onRefresh,
//      child: ListView(
//        shrinkWrap: true,
//        physics: NeverScrollableScrollPhysics(),
//        controller: scrollController,
//        children: <Widget>[
//
//        ],
//      ),
//    );
//  }

  Widget _appBar(double appBarHeight, double rpx) {
    return Opacity(
      opacity: appBarAlpha,
      child: Container(
        height: appBarHeight,
        width: double.infinity,
        color: Theme.of(context).accentColor,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.only(bottom: 20 * rpx, left: 15 * rpx),
                child: Row(
                  children: <Widget>[
                    Icon(
                      PAYICons.scan,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 40 * rpx,
                    ),
                    Icon(
                      PAYICons.fu_kuan,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 40 * rpx,
                    ),
                    Icon(PAYICons.shou_kuan,
                        color: Colors.white, size: 60 * rpx),
                    SizedBox(
                      width: 30 * rpx,
                    ),
                    Icon(Icons.search, color: Colors.white, size: 50 * rpx),
                    SizedBox(
                      width: 30 * rpx,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 10 * rpx, right: 10 * rpx),
              child: Icon(
                Icons.add,
                color: Colors.white,
                size: 60 * rpx,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _headerMenu(double rpx) {
    return Opacity(
      opacity: 1 - appBarAlpha,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          _headerMenutItem(
            rpx,
            '扫一扫',
            PAYICons.scan,
          ),
          _headerMenutItem(rpx, '付钱', PAYICons.fu_kuan),
          _headerMenutItem(rpx, '收钱', PAYICons.shou_kuan),
          _headerMenutItem(rpx, '卡包', PAYICons.cards),
        ],
      ),
    );
  }

  Widget _headerMenutItem(double rpx, String title, IconData icon,
      [double iconSize]) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          icon,
          color: Colors.white,
          size: iconSize ?? 60 * rpx,
        ),
        SizedBox(
          height: 10 * rpx,
        ),
        Text(
          title,
          style: TextStyle(color: Colors.white, fontSize: 30 * rpx),
        )
      ],
    );
  }

  Widget _homeMessage(double rpx) {
    var length = messageList.length;
    List<Message> _message = [];
    var hasNotRead = messageList.where((item) => item.read == false);
    var notReadLength = hasNotRead.length;
    if (notReadLength > 0) {
      var first = hasNotRead.take(1);
      _message.add(Message(
          title: '你有${hasNotRead.length}条消息未读',
          time: messageList[0].time,
          read: false));
    } else {
      _message.addAll(messageList.take(2));
    }
    return Container(
      height: 120 * rpx,
      padding: EdgeInsets.symmetric(horizontal: 20 * rpx, vertical: 10 * rpx),
      decoration: BoxDecoration(color: Colors.white),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Row(
              children: <Widget>[
                LoadImage('antd'),
                SizedBox(
                  width: 10,
                ),
                _messages(_message, notReadLength),
              ],
            ),
          ),
          Container(
            child: Row(
              children: <Widget>[
                notReadLength > 0
                    ? Container(
                        height: 30 * rpx,
                        width: 30 * rpx,
                        margin: EdgeInsets.only(right: 5 * rpx),
                        decoration: BoxDecoration(
                            color: Colours.red,
                            borderRadius: BorderRadius.circular(15 * rpx)),
                        child: Center(
                          child: Text(
                            notReadLength.toString(),
                            style: TextStyle(
                                color: Colors.white, fontSize: 25 * rpx),
                          ),
                        ),
                      )
                    : Container(),
                Images.arrowRight
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _messages(List<Message> message, int notReadLength) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children:
          message.map((item) => _messageItem(item, notReadLength)).toList(),
    );
  }

  Widget _messageItem(Message message, int notReadLength) {
    return Row(
      children: <Widget>[
        Container(
          height: 5,
          width: 5,
          decoration: BoxDecoration(
              color: Colors.black, borderRadius: BorderRadius.circular(2.5)),
        ),
        SizedBox(
          width: 10,
        ),
        Text(message.title),
        SizedBox(
          width: 10,
        ),
        Text(
          message.time,
          style: TextStyle(
            color: Colours.text_gray,
          ),
        )
      ],
    );
  }

  Widget _buildSwiper(double rpx) {
    return Container(
      height: 180 * rpx,
      decoration: BoxDecoration(color: Colors.white),
      child: Swiper(
        itemCount: 3,
        itemBuilder: (context, index) {
          return Container(
            height: 180 * rpx,
            child: LoadImage(
              'ad-${index + 1}',
              format: 'jpg',
              fit: BoxFit.fitWidth,
            ),
          );
        },
        index: 0,
        autoplay: true,
        pagination: SwiperCustomPagination(
            builder: (BuildContext context, SwiperPluginConfig config) {
          return Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: EdgeInsets.only(bottom: 5),
                child: _customPagination(config),
              ));
        }),
        duration: 1500,
        onTap: (index) {
          print('index:$index');
        },
      ),
    );
  }

  Widget _buildTitle(double rpx, String title) {
    return Container(
      child: Text(
        title,
        style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 40 * rpx),
      ),
    );
  }

  Widget _divide() {
    return Container(
      width: double.infinity,
      height: 10,
      color: Colours.bg_color,
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
          height: 3,
          color:
              config.activeIndex == item ? Colours.app_main : Colours.bg_color,
        );
      }).toList(),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

class Message {
  Message(
      {Key key,
      @required this.title,
      @required this.time,
      @required this.read});
  final String title;
  final String time;
  final bool read;
}
