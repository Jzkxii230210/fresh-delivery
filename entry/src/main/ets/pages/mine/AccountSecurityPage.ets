import router from '@ohos.router';
import promptAction from '@ohos.promptAction';

@Entry
@Component
struct AccountSecurityPage {
  // 模拟第三方绑定状态
  @State isWeChatBound: boolean = true;
  @State isAppleBound: boolean = true;

  build() {
    Column() {
      // === 1. 顶部标题栏 ===
      Row() {
        Image($r('app.media.startIcon'))
          .width(20).height(20).margin({ right: 12 })
          .onClick(() => { router.back(); })

        Text('账号与安全')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor('#333333')
          .layoutWeight(1)
          .textAlign(TextAlign.Center)

        Row().width(20) // 平衡右侧
      }
      .width('100%')
      .height(50)
      .padding({ left: 16, right: 16 })
      .backgroundColor(Color.White)

      // === 2. 页面主体设置列表区 ===
      Scroll() {
        Column() {
          // --- 分组一：账号设置 (手机号) ---
          Column() {
            Row() {
              Text('手机').fontSize(14).fontColor('#333333')
              Blank()
              Text('136****5678').fontSize(13).fontColor('#666666').margin({ right: 6 })
              Image($r('app.media.startIcon')).width(12).height(12)
            }
            .width('100%')
            .padding(16)
            .onClick(() => {
              promptAction.showToast({ message: '修改绑定手机号' });
            })
          }
          .width('92%')
          .backgroundColor(Color.White)
          .borderRadius(12)
          .margin({ top: 12, bottom: 12 })
          .shadow({ radius: 4, color: 'rgba(0,0,0,0.03)', offsetY: 2 })

          // --- 分组二：账号绑定 (微信、Apple) ---
          Column() {
            Text('账号绑定')
              .fontSize(13)
              .fontColor('#999999')
              .width('100%')
              .margin({ bottom: 8, left: 4 })

            Column() {
              // 微信绑定行
              Row() {
                Text('微信').fontSize(14).fontColor('#333333')
                Blank()
                Text(this.isWeChatBound ? '小默先生' : '未绑定')
                  .fontSize(13)
                  .fontColor(this.isWeChatBound ? '#666666' : '#10C8A7')
                  .margin({ right: 6 })
                Image($r('app.media.startIcon')).width(12).height(12)
              }
              .width('100%')
              .padding(16)
              .onClick(() => {
                this.isWeChatBound = !this.isWeChatBound;
              })

              Divider().color('#F0F0F0').strokeWidth(0.5).margin({ left: 16 })

              // Apple 绑定行
              Row() {
                Text('Apple').fontSize(14).fontColor('#333333')
                Blank()
                Text(this.isAppleBound ? '小默先生' : '未绑定')
                  .fontSize(13)
                  .fontColor(this.isAppleBound ? '#666666' : '#10C8A7')
                  .margin({ right: 6 })
                Image($r('app.media.startIcon')).width(12).height(12)
              }
              .width('100%')
              .padding(16)
              .onClick(() => {
                this.isAppleBound = !this.isAppleBound;
              })
            }
            .width('100%')
            .backgroundColor(Color.White)
            .borderRadius(12)
            .shadow({ radius: 4, color: 'rgba(0,0,0,0.03)', offsetY: 2 })
          }
          .width('92%')
          .margin({ bottom: 16 })
          .alignItems(HorizontalAlign.Start)

          // --- 分组三：高级设置 (注销账号) ---
          Column() {
            Text('高级设置')
              .fontSize(13)
              .fontColor('#999999')
              .width('100%')
              .margin({ bottom: 8, left: 4 })

            Column() {
              Row() {
                Text('注销账号').fontSize(14).fontColor('#333333')
                Blank()
                Image($r('app.media.startIcon')).width(12).height(12)
              }
              .width('100%')
              .padding(16)
              .onClick(() => {
                promptAction.showToast({ message: '进入账号注销流程' });
              })
            }
            .width('100%')
            .backgroundColor(Color.White)
            .borderRadius(12)
            .shadow({ radius: 4, color: 'rgba(0,0,0,0.03)', offsetY: 2 })
          }
          .width('92%')
          .alignItems(HorizontalAlign.Start)
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