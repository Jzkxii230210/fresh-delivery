import router from '@ohos.router';

@Entry
@Component
struct CheckoutPage {
  // 选中的支付方式索引 (0: 支付宝, 1: 微信, 2: 建行, 3: 招行)
  @State selectedPayIndex: number = 0;

  private payMethods: Array<{ name: string }> = [
    { name: '支付宝支付' },
    { name: '微信支付' },
    { name: '建行龙支付' },
    { name: '招商银行一网通' }
  ];

  build() {
    Column() {
      // === 1. 顶部导航栏 ===
      Row() {
        Image($r('app.media.startIcon'))
          .width(20).height(20).margin({ right: 12 })
          .onClick(() => { router.back(); })

        Text('安全支付')
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

      // === 2. 核心支付内容区 ===
      Scroll() {
        Column() {
          // --- 顶部金额与倒计时卡片 ---
          Column() {
            Text('¥ 74.60')
              .fontSize(32)
              .fontWeight(FontWeight.Bold)
              .fontColor('#333333')
              .margin({ bottom: 6 })

            Row() {
              Text('剩余时间：').fontSize(12).fontColor('#999999')
              Text('29:48').fontSize(12).fontColor('#007DFF')
            }
          }
          .width('92%')
          .backgroundColor(Color.White)
          .borderRadius(12)
          .padding(24)
          .margin({ top: 16, bottom: 12 })
          .shadow({ radius: 4, color: 'rgba(0,0,0,0.03)', offsetY: 2 })

          // --- 支付方式选择列表 ---
          Column() {
            Text('请选择支付方式')
              .fontSize(13)
              .fontColor('#999999')
              .width('100%')
              .margin({ bottom: 12 })

            List({ space: 16 }) {
              ForEach(this.payMethods, (item, index) => {
                ListItem() {
                  Row() {
                    // 支付渠道图标占位
                    Image($r('app.media.startIcon'))
                      .width(28).height(28)
                      .borderRadius(4)
                      .margin({ right: 12 })

                    Text(item.name)
                      .fontSize(15)
                      .fontColor('#333333')
                      .fontWeight(FontWeight.Medium)

                    Blank()

                    // 单选框状态
                    if (this.selectedPayIndex === index) {
                      Circle({ width: 20, height: 20 }).fill('#10C8A7')
                    } else {
                      Circle({ width: 20, height: 20 }).fill(Color.Transparent)
                        .border({ width: 1, color: '#CCCCCC' })
                    }
                  }
                  .width('100%')
                  .onClick(() => {
                    this.selectedPayIndex = index;
                  })
                }
              })
            }
            .width('100%')
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
      .layoutWeight(1)
      .backgroundColor('#F8F8F8')

      // === 3. 底部立即支付按钮栏 ===
      Row() {
        Button('立即支付 ¥74.60')
          .width('100%')
          .height(44)
          .backgroundColor('#10C8A7')
          .fontColor(Color.White)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .borderRadius(22)
          .onClick(() => {
            // TODO: 调用支付 SDK 成功后跳转至支付成功页
            // router.pushUrl({ url: 'pages/order/PaymentSuccessPage' })
          })
      }
      .width('100%')
      .backgroundColor(Color.White)
      .padding({ left: 16, right: 16, top: 12, bottom: 12 })
      .shadow({ radius: 8, color: 'rgba(0,0,0,0.05)', offsetY: -2 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F8F8F8')
  }
}