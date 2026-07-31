import router from '@ohos.router';
const PRIMARY_GREEN = '#00C896'
const TEXT_MAIN = '#333333'
const TEXT_GRAY = '#999999'
const BG_WHITE = '#FFFFFF'

@Entry
@Component
export struct WechatAuthPage {
  @State selectCustom: boolean = true
  @State avatarUrl: Resource = $r('app.media.big')
  @State nickName: string = '小毕先生'

  @Builder
  OverlayTextM() {
    Text('M').fontSize(24).fontColor(BG_WHITE)
  }

  build() {
    Column() {
      Row() {
        Image($r('app.media.back'))
          .width(24)
          .height(24)
          .onClick(() => router.back())
        Blank()
        Rect().width(24).height(24).fillOpacity(0)
      }
      .width('100%')
      .padding({ left: 16, top: 12 })

      Scroll() {
        Column() {
          // 顶部应用申请标题区
          Row() {
            Image($r('app.media.logo'))
              .width(44)
              .height(44)
              .borderRadius(8)
            Column() {
              Text('小毕买菜').fontSize(18).fontColor(TEXT_MAIN)
              Text('申请使用').fontSize(16).fontColor(TEXT_GRAY)
            }
            .margin({ left: 10 })
          }
          .width('100%')
          .margin({ top: 30 })

          Text('获取你的微信昵称、头像')
            .fontSize(26)
            .fontWeight(FontWeight.Medium)
            .fontColor('#000')
            .width('100%')
            .margin({ top: 24 })

          Text('你可选择使用不同的昵称、头像登录')
            .fontSize(16)
            .fontColor(TEXT_GRAY)
            .width('100%')
            .margin({ top: 16 })

          Rect().width('100%').height(1).fill('#EEEEEE').margin({ top: 12, bottom: 20 })

          // 微信账号选项
          Row() {
            Image(this.avatarUrl).width(70).height(70).borderRadius(35)
            Column() {
              Text(this.nickName).fontSize(20).fontColor('#000')
              Text('微信昵称头像').fontSize(14).fontColor(TEXT_GRAY).margin({ top: 4 })
            }
            .layoutWeight(1).margin({ left: 12 })
            if (this.selectCustom) {
              Text('✓').fontSize(28).fontColor(PRIMARY_GREEN)
            }
          }
          .width('100%')

          // 新建昵称头像
          Row() {
            Text('+').fontSize(26).fontColor(TEXT_GRAY)
            Text('新建昵称头像').fontSize(18).fontColor(TEXT_MAIN).margin({ left: 12 })
            Blank()
            Text('>').fontSize(20).fontColor(TEXT_GRAY)
          }
          .width('100%').margin({ top: 24 })

          Blank().height(120)

          // 允许按钮
          Button('允许')
            .width('100%')
            .height(56)
            .backgroundColor(PRIMARY_GREEN)
            .fontSize(19)
            .fontColor(BG_WHITE)
            .borderRadius(12)
            .onClick(() => {
              router.replaceUrl({ url: 'pages/login/BindPhonePage' })
            })

          // 拒绝按钮
          Button('拒绝')
            .width('100%')
            .height(56)
            .backgroundColor('#F2F2F2')
            .fontSize(19)
            .fontColor(PRIMARY_GREEN)
            .borderRadius(12)
            .margin({ top: 16 })
            .onClick(() => router.back())
        }
        .width('100%')
        .padding({ left: 24, right: 24 })
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(BG_WHITE)
  }
}
