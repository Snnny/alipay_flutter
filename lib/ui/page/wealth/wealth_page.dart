import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class WealthPage extends StatefulWidget {
  @override
  _WealthPageState createState() => _WealthPageState();
}

class _WealthPageState extends State<WealthPage> {

  EasyRefreshController _controller;

  // 条目总数
  int _count = 20;

  @override
  void initState() {
    super.initState();
    _controller = EasyRefreshController();
  }


  List<String> getDataList() {
    List<String> list = [];
    for (int i = 0; i < 12; i++) {
      list.add(i.toString());
    }
    return list;
  }


  Widget getItemContainer(String item) {
    return Container(
      child: Column(
        children: <Widget>[
          Icon(Icons.people),
          Text('转账')
        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    List<String> datas = getDataList();
    return Container(
      color: Colors.green,
      child: Container(
        height: 300.0,
        color: Colors.blueAccent,
        child: GridView.count(
          crossAxisCount: 4,
          children: datas.map((item){
            return getItemContainer(item);
          }).toList(),
        ),
      ),
    );
  }
}


//import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart' as extended;
//
///// NestedScrollView示例页面
//class NestedScrollViewPage extends StatefulWidget {
//  @override
//  NestedScrollViewPageState createState() {
//    return NestedScrollViewPageState();
//  }
//}
//class NestedScrollViewPageState extends State<NestedScrollViewPage>
//    with SingleTickerProviderStateMixin {
//  // 滚动控制器
//  ScrollController _scrollController;
//  // Tab控制器
//  TabController _tabController;
//  int _tabIndex = 0;
//  // 列表
//  int _listCount = 20;
//  // 表格
//  int _gridCount = 30;
//
//  // 初始化
//  @override
//  void initState() {
//    super.initState();
//    _tabController = TabController(length: 2, vsync: this);
//    _scrollController = ScrollController();
//  }
//
//  @override
//  void dispose() {
//    super.dispose();
//    _tabController.dispose();
//    _scrollController.dispose();
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      body: extended.NestedScrollView(
//        pinnedHeaderSliverHeightBuilder: () {
//          return MediaQuery.of(context).padding.top + kToolbarHeight;
//        },
//        innerScrollPositionKeyBuilder: () {
//          if (_tabController.index == 0) {
//            return Key('Tab0');
//          } else {
//            return Key('Tab1');
//          }
//        },
//        headerSliverBuilder: (context, innerBoxIsScrolled) {
//          return <Widget>[
//            new SliverAppBar(
//              title: Text("NestedScrollView"),
//              centerTitle: true,
//              expandedHeight: 190.0,
//              flexibleSpace: SingleChildScrollView(
//                physics: NeverScrollableScrollPhysics(),
//                child: Container(),
//              ),
//              floating: false,
//              pinned: true,
//              bottom: new PreferredSize(
//                child: new Card(
//                  color: Theme.of(context).primaryColor,
//                  elevation: 0.0,
//                  margin: new EdgeInsets.all(0.0),
//                  shape: new RoundedRectangleBorder(
//                    borderRadius: BorderRadius.all(Radius.circular(0.0)),
//                  ),
//                  child: new TabBar(
//                    controller: _tabController,
//                    onTap: (index) {
//                      setState(() {
//                        _tabIndex = index;
//                      });
//                    },
//                    tabs: <Widget>[
//                      new Tab(
//                        text: 'List',
//                      ),
//                      new Tab(
//                        text: 'Grid',
//                      ),
//                    ],
//                  ),
//                ),
//                preferredSize: new Size(double.infinity, 46.0),
//              ),
//            ),
//          ];
//        },
//        body: IndexedStack(
//          index: _tabIndex,
//          children: <Widget>[
//            extended.NestedScrollViewInnerScrollPositionKeyWidget(
//              Key('Tab0'),
//              EasyRefresh(
//                child: ListView.builder(
//                  padding: EdgeInsets.all(0.0),
//                  itemBuilder: (context, index) {
//                    return SampleListItem();
//                  },
//                  itemCount: _listCount,
//                ),
//                onRefresh: () async {
//                  await Future.delayed(Duration(seconds: 2), () {
//                    setState(() {
//                      _listCount = 20;
//                    });
//                  });
//                },
//                onLoad: () async {
//                  await Future.delayed(Duration(seconds: 2), () {
//                    setState(() {
//                      _listCount += 10;
//                    });
//                  });
//                },
//              ),
//            ),
//            extended.NestedScrollViewInnerScrollPositionKeyWidget(
//              Key('Tab1'),
//              EasyRefresh(
//                child: GridView.builder(
//                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                    crossAxisCount: 2,
//                    childAspectRatio: 6 / 7,
//                  ),
//                  itemBuilder: (context, index) {
//                    return SampleListItem(direction: Axis.horizontal,);
//                  },
//                  itemCount: _gridCount,
//                ),
//                onRefresh: () async {
//                  await Future.delayed(Duration(seconds: 2), () {
//                    setState(() {
//                      _gridCount = 30;
//                    });
//                  });
//                },
//                onLoad: () async {
//                  await Future.delayed(Duration(seconds: 2), () {
//                    setState(() {
//                      _gridCount += 10;
//                    });
//                  });
//                },
//              ),
//            ),
//          ],
//        ),
//      ),
//    );
//  }
//}
//
//class SampleListItem extends StatelessWidget {
//  /// 方向
//  final Axis direction;
//  /// 宽度
//  final double width;
//
//  const SampleListItem({
//    Key key,
//    this.direction = Axis.vertical,
//    this.width = double.infinity,
//  }) : super(key: key);
//
//  @override
//  Widget build(BuildContext context) {
//    return direction == Axis.vertical ? Card(
//      child: Container(
//        child: Row(
//          children: <Widget>[
//            Container(
//              height: 100.0,
//              child: AspectRatio(
//                aspectRatio: 1.0,
//                child: Container(color: Colors.grey[200],),
//              ),
//            ),
//            Expanded(
//              flex: 1,
//              child: Container(
//                  padding: EdgeInsets.all(10.0,),
//                  color: Colors.white,
//                  child: Column(
//                    children: <Widget>[
//                      Row(
//                        children: <Widget>[
//                          Column(
//                            crossAxisAlignment: CrossAxisAlignment.start,
//                            children: <Widget>[
//                              Container(
//                                width: 120.0,
//                                height: 15.0,
//                                color: Colors.grey[200],
//                              ),
//                              Container(
//                                width: 60.0,
//                                height: 10.0,
//                                margin: EdgeInsets.only(top: 8.0),
//                                color: Colors.grey[200],
//                              ),
//                            ],
//                          ),
//                          Expanded(
//                            flex: 1,
//                            child: SizedBox(),
//                          ),
//                          Icon(Icons.star,
//                            color: Colors.grey[200],
//                          )
//                        ],
//                      ),
//                      SizedBox(height: 8.0,),
//                      Column(
//                        crossAxisAlignment: CrossAxisAlignment.start,
//                        children: <Widget>[
//                          Container(
//                            height: 10.0,
//                            color: Colors.grey[200],
//                          ),
//                          SizedBox(height: 4.0,),
//                          Container(
//                            height: 10.0,
//                            color: Colors.grey[200],
//                          ),
//                          SizedBox(height: 4.0,),
//                          Container(
//                            height: 10.0,
//                            width: 150.0,
//                            color: Colors.grey[200],
//                          ),
//                        ],
//                      ),
//                    ],
//                  )
//              ),
//            ),
//          ],
//        ),
//      ),
//    ) : Card(
//      child: Container(
//        alignment: Alignment.center,
//        child: Column(
//          children: <Widget>[
//            Container(
//              height: 100.0,
//              width: width,
//              color: Colors.grey[200],
//            ),
//            Container(
//              width: width,
//              padding: EdgeInsets.all(10.0),
//              child: Column(
//                children: <Widget>[
//                  Row(
//                    children: <Widget>[
//                      Column(
//                        crossAxisAlignment: CrossAxisAlignment.start,
//                        children: <Widget>[
//                          Container(
//                            width: 80.0,
//                            height: 15.0,
//                            color: Colors.grey[200],
//                          ),
//                          Container(
//                            width: 60.0,
//                            height: 10.0,
//                            margin: EdgeInsets.only(top: 8.0),
//                            color: Colors.grey[200],
//                          ),
//                        ],
//                      ),
//                      Expanded(
//                        flex: 1,
//                        child: SizedBox(),
//                      ),
//                      Icon(Icons.star,
//                        color: Colors.grey[200],
//                      )
//                    ],
//                  ),
//                  SizedBox(height: 8.0,),
//                  Column(
//                    crossAxisAlignment: CrossAxisAlignment.start,
//                    children: <Widget>[
//                      Container(
//                        height: 10.0,
//                        color: Colors.grey[200],
//                      ),
//                      SizedBox(height: 4.0,),
//                      Container(
//                        height: 10.0,
//                        color: Colors.grey[200],
//                      ),
//                      SizedBox(height: 4.0,),
//                      Container(
//                        height: 10.0,
//                        width: 100.0,
//                        color: Colors.grey[200],
//                      ),
//                    ],
//                  ),
//                ],
//              ),
//            ),
//          ],
//        ),
//      ),
//    );
//  }
//}