import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:huofu/api/message.dart';
import 'package:huofu/api/messageread.dart';
import 'package:huofu/iBackIcon.dart';
import 'package:huofu/model/message.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class Notice extends StatefulWidget {
  @override
  NoticeState createState() => NoticeState();
}

class NoticeState extends State {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  List<MessageModel> announcements = [];
  int page = 1;

  @override
  void initState() {
    super.initState();
    _onRefresh();
  }

  void _onRefresh() {
    message(1).then((value) {
      setState(() {
        announcements = value.data ?? [];
        page = 2;
      });
      if ((value.data ?? []).length == 10) {
        _refreshController.resetNoData();
      }
      _refreshController.refreshCompleted();
    }).catchError((error) {
      _refreshController.refreshFailed();
    });
  }

  void _onLoading() {
    message(page).then((value) {
      setState(() {
        announcements.addAll(value.data ?? []);
      });
      if ((value.data ?? []).length < 10) {
        _refreshController.loadNoData();
      } else {
        setState(() {
          page = page + 1;
        });
        _refreshController.loadComplete();
      }
    }).catchError((error) {
      _refreshController.loadFailed();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFAFAFA),
      appBar: AppBar(
        title: Text(
          '消息中心',
        ),
        leading: IBackIcon(
          left: 16,
        ),
      ),
      body: SmartRefresher(
        enablePullDown: true,
        enablePullUp: true,
        header: WaterDropHeader(),
        footer: ClassicFooter(),
        controller: _refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        child: ListView.separated(
          padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
          separatorBuilder: (context, index) {
            return Container(
              height: 8,
            );
          },
          itemBuilder: (context, index) {
            MessageModel message = announcements[index];
            return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                messageread(message.id);
              },
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x21C7C3D0),
                      offset: Offset(0, 2),
                      blurRadius: 8,
                      spreadRadius: 0,
                    )
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      message.title,
                      style: TextStyle(
                        color: Color(0xFF0D1333),
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Container(
                      height: 5,
                    ),
                    Text(
                      formatDate(message.createtime,
                          [yyyy, '-', mm, '-', dd, ' ', HH, ':', nn, ':', ss]),
                      style: TextStyle(
                        color: Color(0xFF9C9EA6),
                        fontSize: 11,
                      ),
                    ),
                    Container(
                      height: 6,
                    ),
                    Text(
                      message.contents,
                      style: TextStyle(
                        color: Color(0xFF5F6173),
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          itemCount: announcements.length,
        ),
      ),
    );
  }
}
