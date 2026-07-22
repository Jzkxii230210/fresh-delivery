import router from '@ohos.router';

@Entry
@Component
struct ThirdPartyAuthModal {
  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      // 半透明背景
      Column().width('100%').height('100%').backgroundColor('rgba(0,0,0,0.4)')
        .onClick(() => {
          router.back();
        })

      // 底部授权确认卡片 (以微信/QQ授权为例)
      Column() {
        // 顶部应用申请提示
        Row({ space: 8 }) {
          Image($r('app.media.startIcon')).width(20).height(20).borderRadius(4)
          Text('小默买菜 申请使用').fontSize(13).fontColor('#666666')
        }
        .width('100%')
        .margin({ bottom: 16 })

        Text('获取你的微信昵称、头像')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor('#333333')
          .width('100%')
          .margin({ bottom: 8 })

        Text('你可选择使用不同的昵称、头像登录')
          .fontSize(12)
          .fontColor('#999999')
          .width('100%')
          .margin({ bottom: 24 })

        // 授权账号项
        Row() {
          Image($r('app.media.startIcon')).width(44).height(44).borderRadius(22).margin({ right: 12 })
          Column() {
            Text('小默先生').fontSize(15).fontWeight(FontWeight.Bold).fontColor('#333333').margin({ bottom: 2 })
            Text('微信昵称头像').fontSize(12).fontColor('#999999')
          }
          .alignItems(HorizontalAlign.Start)
          .layoutWeight(1)

          // 勾选状态图标
          Image($r('app.media.startIcon')).width(16).height(16)
        }
        .width('100%')
        .padding(12)
        .backgroundColor('#FAFAFA')
        .borderRadius(8)
        .margin({ bottom: 12 })

        // 新建昵称头像入口
        Row() {
          Stack({ alignContent: Alignment.Center }) {
            Circle({ width: 44, height: 44 }).fill('#F0F0F0')
            Image($r('app.media.startIcon')).width(16).height(16)
          }
          .margin({ right: 12 })

          Text('新建昵称头像').fontSize(14).fontColor('#333333').layoutWeight(1)
          Image($r('app.media.startIcon')).width(12).height(12)
        }
        .width('100%')
        .padding(12)
        .backgroundColor('#FAFAFA')
        .borderRadius(8)
        .margin({ bottom: 30 })

        // 底部操作按钮 (允许 / 拒绝)
        Button('允许')
          .width('100%')
          .height(44)
          .backgroundColor('#10C8A7')
          .fontColor(Color.White)
          .fontSize(15)
          .fontWeight(FontWeight.Medium)
          .borderRadius(22)
          .margin({ bottom: 12 })
          .onClick(() => {
            // 授权成功，跳转到主页
            router.replaceUrl({ url: 'pages/main/MainPage' });
          })

        Button('拒绝')
          .width('100%')
          .height(44)
          .backgroundColor('#F5F5F5')
          .fontColor('#666666')
          .fontSize(15)
          .fontWeight(FontWeight.Medium)
          .borderRadius(22)
          .margin({ bottom: 20 })
          .onClick(() => {
            router.back();
          })
      }
      .width('100%')
      .padding(24)
      .backgroundColor(Color.White)
      .borderRadius({ topLeft: 20, topRight: 20 })
    }
    .width('100%')
    .height('100%')
  }
}