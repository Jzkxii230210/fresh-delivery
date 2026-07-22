import router from '@ohos.router';

@Entry
@Component
struct WalletPage {
  build() {
    Stack({ alignContent: Alignment.Top }) {
      // === 1. 顶部绿色背景区块 ===
      Column()
        .width('100%')
        .height(180)
        .backgroundColor('#10C8A7')

      // === 2. 页面滚动内容区 ===
      Scroll() {
        Column() {
          // --- 顶部导航栏 ---
          Row() {
            Image($r('app.media.startIcon'))
              .width(20).height(20).margin({ right: 12 })
              .onClick(() => { router.back(); })

            Text('我的钱包')
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .fontColor(Color.White)
              .layoutWeight(1)
              .textAlign(TextAlign.Center)

            Row().width(20) // 平衡右侧
          }
          .width('100%')
          .height(50)
          .padding({ left: 16, right: 16 })
          .margin({ bottom: 10 })

          // --- 资产总览白卡片 ---
          Column() {
            Text('总资产(元)')
              .fontSize(12)
              .fontColor('#999999')
              .width('100%')
              .margin({ bottom: 8 })

            Text('350.00')
              .fontSize(32)
              .fontWeight(FontWeight.Bold)
              .fontColor('#333333')
              .width('100%')
              .margin({ bottom: 24 })

            // 三列明细 (红包、优惠券、积分)
            Row() {
              Column() {
                Text('250.00').fontSize(16).fontWeight(FontWeight.Bold).fontColor('#333333').margin({ bottom: 4 })
                Text('红包(元)').fontSize(11).fontColor('#666666')
              }
              .layoutWeight(1)

              Column() {
                Text('100.00').fontSize(16).fontWeight(FontWeight.Bold).fontColor('#333333').margin({ bottom: 4 })
                Text('优惠券(元)').fontSize(11).fontColor('#666666')
              }
              .layoutWeight(1)

              Column() {
                Text('10000').fontSize(16).fontWeight(FontWeight.Bold).fontColor('#333333').margin({ bottom: 4 })
                Text('积分(分)').fontSize(11).fontColor('#666666')
              }
              .layoutWeight(1)
            }
            .width('100%')
          }
          .width('92%')
          .backgroundColor(Color.White)
          .borderRadius(12)
          .padding(20)
          .margin({ bottom: 16 })
          .shadow({ radius: 4, color: 'rgba(0,0,0,0.03)', offsetY: 2 })

          // --- 广告位 Banner ---
          Column() {
            Row() {
              Text('广告位')
                .fontSize(16)
                .fontWeight(FontWeight.Bold)
                .fontColor('#FFFFFF')
            }
            .width('100%')
            .height(100)
            .justifyContent(FlexAlign.Center)
          }
          .width('92%')
          .backgroundColor('#F3D5A3') // 暖橘色广告背景
          .borderRadius(12)
          .padding(16)
          .margin({ bottom: 16 })

          // --- 更多服务卡片 ---
          Column() {
            Text('更多服务')
              .fontSize(15)
              .fontWeight(FontWeight.Bold)
              .fontColor('#333333')
              .width('100%')
              .margin({ bottom: 16 })

            Row() {
              this.ServiceItem('积分兑换', true)
              this.ServiceItem('领券中心', true)
              this.ServiceItem('发票助手', false)
              this.ServiceItem('支付账单', false)
            }
            .width('100%')
            .justifyContent(FlexAlign.SpaceAround)
          }
          .width('92%')
          .backgroundColor(Color.White)
          .borderRadius(12)
          .padding(16)
          .shadow({ radius: 4, color: 'rgba(0,0,0,0.03)', offsetY: 2 })
        }
        .width('100%')
      }
      .scrollBar(BarState.Off)
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F8F8F8')
  }

  // --- 局部复用组件 ---
  @Builder ServiceItem(title: string, hasTag: boolean) {
    Column() {
      Stack({ alignContent: Alignment.TopStart }) {
        Image($r('app.media.startIcon'))
          .width(36).height(36)
          .margin({ top: 4, left: 4 })

        if (hasTag) {
          Text('策划中')
            .fontSize(8)
            .fontColor(Color.White)
            .backgroundColor('#FF8C00')
            .padding({ left: 3, right: 3, top: 1, bottom: 1 })
            .borderRadius(2)
        }
      }
      .width(44)
      .height(40)
      .margin({ bottom: 4 })

      Text(title)
        .fontSize(12)
        .fontColor('#333333')
    }
    .alignItems(HorizontalAlign.Center)
    .onClick(() => {
      if (title === '支付账单') {
        // router.pushUrl({ url: 'pages/wallet/BillPage' })
      }
    })
  }
}