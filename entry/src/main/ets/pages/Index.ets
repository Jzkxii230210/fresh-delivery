import router from '@ohos.router';

/**
 * 应用入口页 - 自动跳转到启动页
 */
@Entry
@Component
struct Index {
  aboutToAppear() {
    // 延迟跳转到启动页
    setTimeout(() => {
      router.replaceUrl({ url: 'pages/splash/SplashPage' });
    }, 100);
  }

  build() {
    Column() {
      // 启动过渡页面
      Column() {
        Image($r('app.media.startIcon'))
          .width(80)
          .height(80)
          .margin({ bottom: 20 })

        Text('生鲜配送')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor('#10C8A7')

        Text('新鲜直达 品质生活')
          .fontSize(12)
          .fontColor('#999999')
          .margin({ top: 8 })
      }
      .width('100%')
      .height('100%')
      .justifyContent(FlexAlign.Center)
      .backgroundColor('#FFFFFF')
    }
    .width('100%')
    .height('100%')
  }
}
