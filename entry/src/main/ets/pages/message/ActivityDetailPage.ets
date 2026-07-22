import router from '@ohos.router';

@Entry
@Component
struct ActivityDetailPage {
  build() {
    Stack({ alignContent: Alignment.Top }) {

      // === 1. 底层端午主题背景色 ===
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor('#0B6623') // 经典节日深绿色

      // === 2. 中间滚动内容区 (海报文案与插图) ===
      Scroll() {
        Column() {
          // 顶部留白，避免被浮动导航栏遮挡
          Row().height(70).width('100%')

          // 海报主标题文案区
          Column() {
            Text('端午节')
              .fontSize(60)
              .fontWeight(FontWeight.Bold)
              .fontColor(Color.White)
              .margin({ bottom: 4 })

            Text('DRAGON BOAT FESTIVAL')
              .fontSize(11)
              .fontColor('rgba(255, 255, 255, 0.7)')
              .letterSpacing(6)
              .margin({ bottom: 20 })

            Text('粽香五月 · 粽享端午')
              .fontSize(18)
              .fontColor(Color.White)
              .fontWeight(FontWeight.Medium)
              .margin({ bottom: 12 })

            Text('端午节 “粽” 享美丽')
              .fontSize(24)
              .fontColor('#FFD700') // 金色高亮文字
              .fontWeight(FontWeight.Bold)
              .margin({ bottom: 24 })

            // 活动时间标签
            Text('活动时间：6月25号 -- 6月30号')
              .fontSize(13)
              .fontColor(Color.White)
              .backgroundColor('rgba(0, 0, 0, 0.25)')
              .padding({ left: 16, right: 16, top: 8, bottom: 8 })
              .borderRadius(18)
              .margin({ bottom: 40 })
          }
          .width('100%')
          .alignItems(HorizontalAlign.Center)

          // 底部粽子与竹篮插图占位
          Image($r('app.media.startIcon'))
            .width('100%')
            .height(320)
            .objectFit(ImageFit.Cover)
        }
        .width('100%')
      }
      .scrollBar(BarState.Off)
      .width('100%')
      .height('100%')

      // === 3. 顶部固定导航栏 (覆盖在最上层) ===
      Row() {
        // 左侧关闭按钮 (×)
        Image($r('app.media.startIcon'))
          .width(20)
          .height(20)
          .onClick(() => {
            router.back();
          })

        // 中间标题
        Text('活动详情')
          .fontSize(17)
          .fontWeight(FontWeight.Medium)
          .fontColor(Color.White)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)

        // 右侧分享/扩展按钮
        Image($r('app.media.startIcon'))
          .width(20)
          .height(20)
          .onClick(() => {
            // TODO: 唤起分享面板
          })
      }
      .width('100%')
      .height(50)
      .padding({ left: 16, right: 16 })
      .backgroundColor(Color.Transparent) // 透明背景悬浮在海报之上
    }
    .width('100%')
    .height('100%')
  }
}