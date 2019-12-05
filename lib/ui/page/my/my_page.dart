import 'package:alipay_fluttur/ui/widgets/clickItem.dart';
import 'package:flutter/material.dart';
import 'package:alipay_fluttur/common/style/resources.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> with AutomaticKeepAliveClientMixin{

  RefreshController _refreshController = RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    double rpx = MediaQuery.of(context).size.width / 750;

    Future<void>  _onRefresh(){
      print('_onRefresh');
      _refreshController.refreshCompleted();
      return null;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '我的',
          style: TextStyle(fontSize: 38 * rpx),
        ),
        actions: <Widget>[
          FlatButton(
              onPressed: () {},
              child: Text(
                '设置',
                style:
                    TextStyle(color: Colours.material_bg, fontSize: 30 * rpx),
              ))
        ],
        elevation: 0,
//        bottom: PreferredSize(
//            child: Text('底部'),
//          preferredSize: Size.fromHeight(100)
//        ),
      ),
      body: Container(
        color: Colours.bg_color,
        child: SmartRefresher(
          controller: _refreshController,
          enablePullDown: true,
          enablePullUp: false,
          onRefresh: _onRefresh,
          header: CustomHeader(
            builder: (BuildContext context,RefreshStatus mode){
              Widget body;
              TextStyle style = TextStyle(color: Colors.white);
              if(mode==RefreshStatus.idle){
                body =  Text("下拉刷新", style: style,);
              }
              else if(mode==RefreshStatus.refreshing){
                body =  Text("刷新中...", style: style,);
              }
              else if(mode == RefreshStatus.failed){
                body = Text("加载失败！点击重试！", style: style,);
              }
              else if(mode == RefreshStatus.canRefresh){
                body = Text("松手刷新", style: style);
              }
              else{
                body = Container(
                );
              }
              return Container(
                color: Colours.app_main,
                height: 250*rpx,
                child: Center(child:body),
              );
            },
          ),
          child: _buildContent(rpx),
        ),
      ),
    );
  }

  Widget _buildContent(double rpx) {
    return ListView(
      physics: BouncingScrollPhysics(),
      children: <Widget>[
        Container(
          height: 160 * rpx,
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          decoration: BoxDecoration(color: Colours.app_main),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Row(
                  children: <Widget>[
                    _renderAvator(rpx),
                    SizedBox(
                      width: 20 * rpx,
                    ),
                    _renderUserInfo(rpx)
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
                size: 30 * rpx,
              )
            ],
          ),
        ),
        ClickItem(
          title: '支付宝会员',
          content: '2个积分待领取',
          onTap: () {},
          icon: PAYICons.vip2,
        ),
        ClickItem(
            title: '商家服务',
            onTap: () {},
            icon: PAYICons.sorter,
            hasBottomBorder: false,
            iconSize: 24.0),
        SizedBox(height: 15 * rpx,),
        ClickItem(
          title: '账单',
          onTap: () {},
          icon: PAYICons.zhang_dan,
          iconColor: Colours.yellow,
        ),
        ClickItem(
            title: '总资产',
            content: '账号保障免费升级',
            onTap: () {},
            icon: PAYICons.chart,
            iconSize: 24.0),
        ClickItem(
            title: '余额',
            content: '0.0元',
            onTap: () {},
            icon: PAYICons.wealth,
            iconSize: 26.0),
        ClickItem(
            title: '余额宝',
            onTap: () {},
            icon: PAYICons.yu_e_bao,
            iconColor: Colours.red,
            iconSize: 26.0),
        ClickItem(
            title: '花呗',
            onTap: () {},
            icon: PAYICons.hua_bei,
            iconSize: 24.0),
        ClickItem(
            title: '余利宝',
            onTap: () {},
            icon: PAYICons.yu_li_bao,
            iconColor: Colours.green,
            iconSize: 24.0),
        ClickItem(
            title: '银行卡',
            onTap: () {},
            icon: PAYICons.bank_card2,
            iconColor: Colours.yellow,
            hasBottomBorder: false,
            iconSize: 26.0),
        SizedBox(height: 15 * rpx,),
        ClickItem(
            title: '芝麻信用',
            onTap: () {},
            icon: PAYICons.xin_yong,
            iconColor: Colours.green,
            iconSize: 24.0),
        ClickItem(
            title: '蚂蚁保险',
            onTap: () {},
            icon: PAYICons.bao_xian,
            iconSize: 32.0),
        ClickItem(
            title: '借呗',
            onTap: () {},
            icon: PAYICons.jie_bei,
            iconSize: 24.0),
        ClickItem(
            title: '网商银行',
            onTap: () {},
            icon: PAYICons.bank,
            iconColor: Colours.green,
            hasBottomBorder: false,
            iconSize: 28.0),
        SizedBox(height: 15 * rpx,),
        ClickItem(
            title: '支付宝公益',
            onTap: () {},
            icon: PAYICons.gong_yi,
            iconSize: 24.0),
        ClickItem(
            title: '我的客服',
            onTap: () {},
            icon: PAYICons.ke_fu,
            hasBottomBorder: false,
            iconSize: 32.0),
        SizedBox(height: 40 *rpx,)
      ],
    );
  }

  Widget _renderAvator(double rpx) {
    return Container(
      width: 140 * rpx,
      height: 140 * rpx,
      child: Stack(
        children: <Widget>[
          Container(
            width: 120 * rpx,
            height: 120 * rpx,
            padding: EdgeInsets.all(2 * rpx),
            decoration: BoxDecoration(
              color: Colours.app_main_light,
              borderRadius: BorderRadius.circular(5 * rpx),
            ),
            child: Image.network(
              'https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=493817149,1840500933&fm=26&gp=0.jpg',
              fit: BoxFit.fill,
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              width: 26,
              height: 26,
              padding: const EdgeInsets.all(1.0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14.0)),
              child: Icon(PAYICons.vip, size: 20, color: Colors.purple),
            ),
          )
        ],
      ),
    );
  }

  Widget _renderUserInfo(double rpx) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          '晴晴晴天',
          style: TextStyle(color: Colors.white, fontSize: 34 * rpx),
        ),
        SizedBox(
          height: 5 * rpx,
        ),
        Opacity(
          opacity: .7,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 3.0),
            decoration: BoxDecoration(
                border: Border.all(width: .5, color: Colors.white),
                borderRadius: BorderRadius.circular(15.0)),
            child: Center(
              child: Text(
                '270937005@qq.com',
                style: TextStyle(
                    color: Colors.white, fontSize: 26 * rpx, letterSpacing: .5),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
