import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';

class Guide extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return GuideState();
  }
}

class GuideState extends State {
  List<String> banners = [
    'images/guide1@2x.png',
    'images/guide2@2x.png',
    'images/guide3@2x.png'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Swiper(
          autoplay: false,
          loop: false,
          outer: true,
          pagination: SwiperPagination(
            builder: DotSwiperPaginationBuilder(
              activeColor: Color(0xFF602FDA),
              color: Color(0xFFEDE6FF),
              size: 8,
              activeSize: 8,
              space: 12,
            ),
          ),
          itemBuilder: (context, index) {
            String banner = banners[index];
            Widget container = Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AspectRatio(
                    aspectRatio: 750 / 932,
                    child: Image.asset(
                      banner,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    height: 72,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (index == 0)
                          Text(
                            '便捷入金出金',
                            style: TextStyle(
                              fontSize: 22,
                              color: Color(0xFF602FDA),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        if (index == 1)
                          Text(
                            '智能挖矿',
                            style: TextStyle(
                              fontSize: 22,
                              color: Color(0xFF602FDA),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        if (index == 1)
                          Text(
                            '开启财富密码',
                            style: TextStyle(
                              fontSize: 22,
                              color: Color(0xFF602FDA),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        if (index == 2)
                          Text(
                            '邀请奖励',
                            style: TextStyle(
                              fontSize: 22,
                              color: Color(0xFF602FDA),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        if (index == 2)
                          Text(
                            '坐拥团队返佣',
                            style: TextStyle(
                              fontSize: 22,
                              color: Color(0xFF602FDA),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                      ],
                    ),
                  )
                ],
              ),
            );
            if (index == 2) {
              return GestureDetector(
                onHorizontalDragStart: (detail) {
                  Navigator.pop(context);
                },
                child: container,
              );
            }
            return container;
          },
          itemCount: banners.length,
        ),
      ),
    );
  }
}
