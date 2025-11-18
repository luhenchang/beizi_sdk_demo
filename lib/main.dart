import 'package:beizi_sdk/beizi_sdk_export.dart';
import 'package:beizi_sdk_demo/reward_video_page.dart';
import 'package:beizi_sdk_demo/widgets/blurred_background.dart';
import 'package:beizi_sdk_demo/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'data/common.dart';
import 'data/init_data.dart';
import 'interstitialPage.dart';
import 'native_page.dart';
import 'native_unified_page.dart';
import 'splash_page.dart';
import 'union_download_app_info_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: 'HomePage',
      routes: {
        'HomePage': (context) => const HomePage(title: '首页'),
        'SplashShowPage': (context) => const SplashPage(title: '开屏页面'),
        'InterstitialShowPage': (context) =>
            const InterstitialPage(title: '插屏页面'),
        'RewardVideoPage': (context) =>
            const RewardedVideoPage(title: '激励视频页面'),
        'NativePage': (context) => const NativePage(title: '原生页面'),
        'NativeUnifiedPage': (context) =>
            const NativeUnifiedPage(title: '原生自渲染页面'),
        'UnionDownloadAppInfoPage': (context) =>
            const UnionDownloadAppInfoPage(),
      },
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  InitStatus initStatus = InitStatus.normal;
  SplashAd? _splashAd;
  late SplashAdListener _adCallBack;
  late SplashBottomWidget splashBottom = SplashBottomWidget(
    height: 100,
    backgroundColor: "#FFFFFFFF",
    children: [
      ImageComponent(
        width: 25,
        height: 25,
        x: 170,
        y: 10,
        imagePath: 'assets/images/img.png',
      ),
      TextComponent(
        fontSize: 24,
        color: "#00ff00",
        x: 140,
        y: 50,
        text: 'Hello Android!',
      ),
    ],
  );

  @override
  void initState() {
    _adCallBack = SplashAdListener(
      onAdLoaded: () {
        _splashAd?.showAd();
      },
    );
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    BeiZis.init(
      appId,
      BeiziCustomController(
        isPersonalRecommend: true,
        shouldForbidSensor: true,
      ),
    ).then((value) {
      _splashAd = SplashAd(
        adSpaceId: splashSpaceId,
        totalTime: timeOut,
        listener: _adCallBack,
      );
      WidgetsBinding.instance.addPostFrameCallback((_) {
        // 此时可以安全获取 MediaQuery 信息
        var width = MediaQuery.of(context).size.width.toInt();
        var height = MediaQuery.of(context).size.height.toInt();
        _splashAd?.loadAd(
          width: width,
          height: height - 100,
          splashBottomWidget: splashBottom,
        );
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          const BlurredBackground(),
          Column(
            children: [
              const SizedBox(height: 100, width: 0),
              ButtonWidget(
                buttonText: getInitResult(initStatus),
                backgroundColor: getInitColor(initStatus),
                callBack: () {},
              ),
              const SizedBox(height: 20, width: 0),
              ButtonWidget(
                buttonText: '开屏show案例页面',
                callBack: () {
                  // 使用命名路由跳转
                  Navigator.pushNamed(context, 'SplashShowPage');
                },
              ),
              const SizedBox(height: 20, width: 0),
              ButtonWidget(
                buttonText: '插屏show案例页面',
                callBack: () {
                  // 使用命名路由跳转
                  Navigator.pushNamed(context, 'InterstitialShowPage');
                },
              ),
              const SizedBox(height: 20, width: 0),
              ButtonWidget(
                buttonText: '激励视频案例页面',
                callBack: () {
                  // 使用命名路由跳转
                  Navigator.pushNamed(context, 'RewardVideoPage');
                },
              ),
              const SizedBox(height: 20, width: 0),
              ButtonWidget(
                buttonText: '点击跳转原生页面',
                callBack: () {
                  // 使用命名路由跳转
                  Navigator.pushNamed(context, 'NativePage');
                },
              ),
              const SizedBox(height: 20, width: 0),
              ButtonWidget(
                buttonText: '点击跳转自渲染页面',
                callBack: () {
                  // 使用命名路由跳转
                  Navigator.pushNamed(context, 'NativeUnifiedPage');
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  String getInitResult(InitStatus status) {
    switch (status) {
      case InitStatus.normal:
        return '点击初始化SDK';
      case InitStatus.initialing:
        return '初始化中';
      case InitStatus.alreadyInit:
        return '已初始化';
      case InitStatus.success:
        return '初始化成功';
      case InitStatus.failed:
        return '初始化失败';
    }
  }

  Color? getInitColor(InitStatus initStatus) {
    switch (initStatus) {
      case InitStatus.normal:
        return Colors.blue;
      case InitStatus.initialing:
        return Colors.grey;
      case InitStatus.alreadyInit:
        return Colors.green;
      case InitStatus.success:
        return Colors.green;
      case InitStatus.failed:
        return Colors.red;
    }
  }
}
