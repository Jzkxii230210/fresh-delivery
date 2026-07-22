import router from '@ohos.router';
import promptAction from '@ohos.promptAction';

@Entry
@Component
struct AboutUsPage {
  build() {
    Column() {
      // === 1. 顶部标题栏 ===
      Row() {
        Image($r('app.media.startIcon'))
          .width(20).height(20).margin({ right: 12 })
          .onClick(() => { router.back(); })

        Text('关于我们')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor('#333333')
          .layoutWeight(1)
          .textAlign(TextAlign.Center)

        Row().width(20)
      }
      .width('100%')
      .height(50)
      .padding({ left: 16, right: 16 })
      .backgroundColor(Color.White)

      // === 2. 滚动主体内容区 ===
      Scroll() {
        Column() {
          // --- 品牌 Logo 与版本号区域 ---
          Column() {
            // App Logo 占位
            Image($r('app.media.startIcon'))
              .width(80)
              .height(80)
              .borderRadius(16)
              .margin({ bottom: 12 })

            Text('小默买菜')
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .fontColor('#333333')
              .margin({ bottom: 6 })

            Text('Version 1.0.6')
              .fontSize(12)
              .fontColor('#999999')
          }
          .width('100%')
          .alignItems(HorizontalAlign.Center)
          .padding({ top: 30, bottom: 30 })

          // --- 功能菜单列表卡片 ---
          Column() {
            // 给我们评分
            Row() {
              Text('给我们评分').fontSize(14).fontColor('#333333')
              Blank()
              Image($r('app.media.startIcon')).width(12).height(12)
            }
            .width('100%')
            .padding(16)
            .onClick(() => {
              promptAction.showToast({ message: '感谢您的支持与好评！' });
            })

            Divider().color('#F0F0F0').strokeWidth(0.5).margin({ left: 16 })

            // 分享给好友
            Row() {
              Text('分享给好友').fontSize(14).fontColor('#333333')
              Blank()
              Image($r('app.media.startIcon')).width(12).height(12)
            }
            .width('100%')
            .padding(16)
            .onClick(() => {
              promptAction.showToast({ message: '正在调起分享面板...' });
            })

            Divider().color('#F0F0F0').strokeWidth(0.5).margin({ left: 16 })

            // 版本更新
            Row() {
              Text('版本更新').fontSize(14).fontColor('#333333')
              Blank()
              Text('已是最新版本').fontSize(13).fontColor('#999999').margin({ right: 6 })
              Image($r('app.media.startIcon')).width(12).height(12)
            }
            .width('100%')
            .padding(16)
            .onClick(() => {
              promptAction.showToast({ message: '当前已是最新版本 V1.0.6' });
            })
          }
          .width('92%')
          .backgroundColor(Color.White)
          .borderRadius(12)
          .margin({ bottom: 40 })
          .shadow({ radius: 4, color: 'rgba(0,0,0,0.03)', offsetY: 2 })

          // --- 底部版权信息 ---
          Column() {
            Text('默林工作室 版权所有')
              .fontSize(11)
              .fontColor('#999999')
              .margin({ bottom: 4 })

            Text('Copyright © 2099 Murrin Studio.')
              .fontSize(11)
              .fontColor('#999999')
              .margin({ bottom: 2 })

            Text('All Rights Reserved.')
              .fontSize(11)
              .fontColor('#999999')
          }
          .width('100%')
          .alignItems(HorizontalAlign.Center)
          .margin({ bottom: 20 })
        }
        .width('100%')
      }
      .scrollBar(BarState.Off)
      .layoutWeight(1)
      .backgroundColor('#F8F8F8')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F8F8F8')
  }
}