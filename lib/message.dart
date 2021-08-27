import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:huofu/api/announcementlist.dart';
import 'package:huofu/iBackIcon.dart';
import 'package:huofu/messageDetail.dart';
import 'package:huofu/model/announcement.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class Message extends StatefulWidget {
  @override
  _MessageState createState() => _MessageState();
}

class _MessageState extends State {
  RefreshController _refreshController = RefreshController();
  List<AnnouncementModel> announcements = [];
  int page = 1;

  @override
  void initState() {
    super.initState();
    _onRefresh();
  }

  void _onRefresh() {
    announcementlist(1).then((value) {
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
    announcementlist(page).then((value) {
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
          '公告中心',
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
            AnnouncementModel announce = announcements[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) {
                  return MessageDetail(
                    model: announce,
                  );
                }));
              },
              behavior: HitTestBehavior.opaque,
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
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        announce.title,
                        style: TextStyle(
                          color: Color(0xFF0D1333),
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Image.asset(
                      'images/message_next@2x.png',
                      width: 20,
                      height: 20,
                    )
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
