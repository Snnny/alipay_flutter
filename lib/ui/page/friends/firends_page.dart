import 'package:alipay_fluttur/ui/widgets/load_image.dart';
import 'package:flutter/material.dart';
import 'package:alipay_fluttur/common/style/resources.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class FriendsPage extends StatefulWidget {
  @override
  _FriendsPageState createState() => _FriendsPageState();
}

class _FriendsPageState extends State<FriendsPage> {
  List<ListItem> items = List<ListItem>();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    items.add(ListItem(id: -1,title: '优酷VIP会员', content: '【送会员】每日一签 12月4日运势', time: '6:30', icon: 'icon-1', read: false));
    items.add(ListItem(id: 10,title: '优酷VIP会员', content: '【送会员】每日一签 12月4日运势', time: '6:30', icon: 'icon-1', read: false));
    items.add(ListItem(id: 11,title: '蚂蚁森林', content: '您收到100w+赞', time: '7:40', icon: 'icon-2'));
    items.add(ListItem(id: 12,title: '淘票票', content: '漫威《黑寡妇》全球首支预预告来了哈哈哈哈哈哈哈哈哈哈哈哈哈', time: '昨天', icon: 'icon-3'));
    items.add(ListItem(id: 13,title: '支付宝账号安全险', content: '保障升级通知', time: '昨天', icon: 'icon-4', read: false));
    items.add(ListItem(id: 14,title: '花呗', content: '交易提醒', time: '昨天', icon: 'icon-5'));
    items.add(ListItem(id: 15,title: '芝麻信用', content: '来，跟我一起瓜分500万不？', time: '昨天', icon: 'icon-6'));
    items.add(ListItem(id: 16,title: '滴滴出行', content: '30元专车券|感恩节，对自己说声谢谢', time: '昨天', icon: 'icon-7'));
    items.add(ListItem(id: 17,title: '支付宝账号安全险', content: '保障升级通知', time: '昨天', icon: 'icon-4'));
    items.add(ListItem(id: 18,title: '花呗', content: '交易提醒', time: '昨天', icon: 'icon-5'));
    items.add(ListItem(id: 19,title: '芝麻信用', content: '来，跟我一起瓜分500万不？', time: '昨天', icon: 'icon-6'));
    items.add(ListItem(id: 20,title: '滴滴出行', content: '30元专车券|感恩节，对自己说声谢谢', time: '昨天', icon: 'icon-7'));
  }

  @override
  Widget build(BuildContext context) {
    double rpx = MediaQuery.of(context).size.width / 750;
    return Scaffold(
        appBar: AppBar(
          title: Text('朋友'),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
                icon: Icon(
                  PAYICons.friends,
                  color: Colors.white,
                ),
                onPressed: () {}),
            IconButton(
                icon: Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 30,
                ),
                onPressed: () {}),
          ],
        ),
        body: ListView.builder(
                shrinkWrap: true,
                itemCount: items.length,
                itemBuilder: (context, index) {
                  if(index == 0) {
                    return Column(
                      children: <Widget>[
                        Container(
                          height: 220.0 * rpx,
                          padding: EdgeInsets.symmetric(vertical: 40*rpx),
                          decoration: BoxDecoration(
                              color: Colors.white
                          ),
                          child: Row(
                            children: <Widget>[
                              _buildTitleItem(rpx, 'title-1', '生活号', '简单生活更多发现', false),
                              _buildTitleItem(rpx, 'title-2', '小程序', '发现更多服务', false),
                              _buildTitleItem(rpx, 'title-3', '生活圈', '和朋友分享生活', true),
                            ],
                          ),
                        ),
                        _divide(),
                      ],
                    );
                  }
                  return Slidable(
                    key: ValueKey(items[index].id),
                    actionPane: SlidableDrawerActionPane(),
                    secondaryActions: <Widget>[
                      IconSlideAction(
                        closeOnTap: false, // 点击按钮防止slide关闭
                        iconWidget: Text('取消\n关注', style: TextStyle(color: Colors.white, fontSize: 35 *rpx)),
                        color: Colors.grey[400],
                      ),
                      IconSlideAction(
                          iconWidget: Text('删除', style: TextStyle(color: Colors.white, fontSize: 35 *rpx),),
                          color: Colors.blueAccent,
                          onTap: (){
                            print('删除');
                            setState(() {
                              items.removeAt(index);
                            });
                          }
                      ),
                    ],
                    child: Container(
                      height: 140 *rpx,
                      child: ClickItem(
                        title: items[index].title,
                        icon: items[index].icon,
                        content: items[index].content,
                        time: items[index].time,
                        hasRead: items[index].read,
                      ),
                    ),
                  );
                },
              )
    );
  }

  Widget _buildTitleItem(double rpx, String imgUrl, String title, String subTitle, bool isLast) {
    return  Expanded(
      flex: 1,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 30 *rpx,),
        decoration: BoxDecoration(
            border: Border(
                right: BorderSide(color: isLast ? Colors.white : Colours.bg_color)
            )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            LoadImage(imgUrl, format: 'jpg', width: 60.0 *rpx, height: 60.0 *rpx,),
            Text(title, style: TextStyle(fontWeight: FontWeight.w400, fontSize: 30*rpx),),
            Text(subTitle, overflow: TextOverflow.ellipsis,)
          ],
        ),
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

}


class ClickItem extends StatelessWidget {

  const ClickItem({
    Key key,
    this.onTap,
    @required this.title,
    this.content: "",
    this.time: "",
    this.textAlign: TextAlign.start,
    this.maxLines: 1,
    this.bgColor: Colors.white,
    @required this.icon,
    this.hasBottomBorder: true,
    this.hasRead: true,
  }): super(key: key);

  final GestureTapCallback onTap;
  final String title;
  final String content;
  final String time;
  final TextAlign textAlign;
  final int maxLines;
  final Color bgColor;
  final String icon;
  final bool hasBottomBorder;
  final bool hasRead;


  bool isImage(String url) {
    return url.endsWith('jpg') || url.endsWith('jpeg') || url.endsWith('png') || url.endsWith('gif');
  }

  @override
  Widget build(BuildContext context) {
    bool contentIsImage = isImage(content);
    return Container(
      color: Colors.white,
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  width: 44.0,
                  height: 44.0,
                  padding: EdgeInsets.all(4.0),
                  margin: EdgeInsets.only(left: 15.0),
                  child: Center(
                    child: LoadImage(icon, format: 'jpg', fit: BoxFit.cover,),
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: hasRead ? Container():Container(
                    height: 8.0,
                    width: 8.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: Colours.red
                    ),
                  ),
                )
              ],
            ),

            Expanded(
              flex: 1,
              child: Container(
                margin: const EdgeInsets.only(left: 15.0),
                padding: const EdgeInsets.fromLTRB(0, 15.0, 15.0, 15.0),
                constraints: BoxConstraints(
                  maxHeight: double.infinity,
                  minHeight: 50.0,
                ),
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: hasBottomBorder ? Divider.createBorderSide(context) : BorderSide.none,
                  ),
//            color: bgColor,
                ),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          title,
                          style: TextStyle(fontSize: 16.0),
                        ),
                        Text(
                          time,
                          style: TextStyle(fontSize: 14.0),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: Text(
                            content,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          )
                        )
                      ],
                    ),
                  ],
                )
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ListItem {
  ListItem(
      {Key key,
        @required this.id,
        @required this.title,
        @required this.content,
        @required this.icon,
        @required this.time,
        this.read: true
      });

  final String title;
  final String content;
  final String icon;
  final String time;
  final bool read;
  final int id;
}

