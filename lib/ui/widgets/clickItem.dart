import 'package:alipay_fluttur/common/style/resources.dart';
import 'package:alipay_fluttur/ui/widgets/load_image.dart';
import 'package:flutter/material.dart';

class ClickItem extends StatelessWidget {

  const ClickItem({
    Key key,
    this.onTap,
    @required this.title,
    this.content: "",
    this.textAlign: TextAlign.start,
    this.maxLines: 1,
    this.bgColor: Colors.white,
    @required this.icon,
    this.iconColor: Colours.app_main,
    this.iconSize: 28.0,
    this.hasBottomBorder: true,
  }): super(key: key);

  final GestureTapCallback onTap;
  final String title;
  final String content;
  final TextAlign textAlign;
  final int maxLines;
  final Color bgColor;
  final IconData icon;
  final Color iconColor;
  final bool hasBottomBorder;
  final double iconSize;


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
            Container(
              width: 30.0,
              margin: EdgeInsets.only(left: 15.0),
              child: Center(
                child: Icon(icon, size: iconSize, color: iconColor,),
              ),
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
                child: Row(
                  //为了数字类文字居中
                  crossAxisAlignment: maxLines == 1 ? CrossAxisAlignment.center : CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      title,
                      style: TextStyle(fontSize: 18.0),
                    ),
                    const Spacer(),
                    Expanded(
                      flex: 4,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8.0, left: 16.0),
                        child: contentIsImage
                            ? Align(child: ClipOval(child: SizedBox(width: 30.0, height: 30.0, child: LoadImage(content, fit: BoxFit.fill,)),), alignment: Alignment.centerRight,)
                            : Text(
                            content,
                            maxLines: maxLines,
                            textAlign: maxLines == 1 ? TextAlign.right : textAlign,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.subtitle.copyWith(fontSize: 15.0)
                        ),
                      ),
                    ),
                    Opacity(
                      // 无点击事件时，隐藏箭头图标
                      opacity: onTap == null ? 0 : 1,
                      child: Padding(
                        padding: EdgeInsets.only(top: maxLines == 1 ? 0.0 : 2.0),
                        child: Images.arrowRight,
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
