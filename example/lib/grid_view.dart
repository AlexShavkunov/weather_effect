import 'package:flutter/material.dart';
import 'package:flutter_weather_bg/bg/weather_color_bg.dart';
import 'package:flutter_weather_bg/flutter_weather_bg.dart';
import 'package:flutter_weather_bg/utils/print_utils.dart';

/// 已宫格的形式展示多样的天气效果
/// 同时，支持切换列数
class GridViewWidget extends StatefulWidget {
  @override
  _GridViewWidgetState createState() => _GridViewWidgetState();
}

class _GridViewWidgetState extends State<GridViewWidget> {
  int _count = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("GridView"),
          actions: [
            PopupMenuButton<int>(
              itemBuilder: (context) {
                return <PopupMenuEntry<int>>[
                  ...[1, 2, 3, 4, 5,]
                      .map((e) => PopupMenuItem<int>(
                            value: e,
                            child: Text("$e"),
                          ))
                      .toList(),
                ];
              },
              onSelected: (count) {
                setState(() {
                  _count = count;
                });
              },
            )
          ],
        ),
        body: Container(
          child: GridView.count(
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            crossAxisCount: _count,
            childAspectRatio: 1 / 2,
            children: WeatherType.values
                .map((e) => GridItemWidget(
                      weatherType: e,
                      count: _count,
                    ))
                .toList(),
          ),
        ));
  }
}

class GridItemWidget extends StatelessWidget {
  final WeatherType weatherType;
  final int count;

  GridItemWidget({Key key, this.weatherType, this.count}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    weatherPrint("grid item size: ${MediaQuery.of(context).size}");
    return Stack(
      children: [
        WeatherBg(
          weatherType: weatherType,
          width: MediaQuery.of(context).size.width / count,
          height: MediaQuery.of(context).size.width * 2,
        ),
        Center(
          child: Text(
            WeatherUtil.getWeatherDesc(weatherType),
            style: TextStyle(
                color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}
