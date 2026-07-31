import router from '@ohos.router';

@Entry
@Component
struct ActivityDetailPage {
  build() {
    Column() {
      // === 顶部导航栏 ===
      Row() {
        // 左侧关闭按钮 (×)
        Image($r('app.media.guanbi'))
          .width(20)
          .height(20)
          .onClick(() => {
            router.back();
          })

        // 中间标题
        Text('活动详情')
          .fontSize(17)
          .fontWeight(FontWeight.Medium)
          .fontColor('#333333')
          .layoutWeight(1)
          .textAlign(TextAlign.Center)

        // 右侧分享/扩展按钮
        Image($r('app.media.fenxiang'))
          .width(20)
          .height(20)
          .onClick(() => {
            // TODO: 唤起分享面板
          })
      }
      .width('100%')
      .height(50)
      .padding({ left: 16, right: 16 })
      .backgroundColor(Color.White)

      // === 图片内容区域 ===
      Image($r('app.media.zongzi'))
        .width('100%')
        .layoutWeight(1)
        .objectFit(ImageFit.Cover)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F8F8F8')
  }
}
