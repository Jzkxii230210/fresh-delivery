import router from '@ohos.router';

@Entry
@Component
struct OrderDetailPage {
  // 模拟订单状态类型: 'wait' | 'finished' | 'closed' | 'refund'
  @State orderStatus: string = 'wait';

  build() {
    Column() {
      // === 1. 顶部绿色导航栏 ===
      Row() {
        Image($r('app.media.startIcon'))
          .width(20).height(20).margin({ right: 12 })
          .onClick(() => { router.back(); })

        Text('订单详情')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.White)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)

        Image($r('app.media.startIcon')).width(20).height(20) // 右上角分享/扩展图标
      }
      .width('100%')
      .height(50)
      .padding({ left: 16, right: 16 })
      .backgroundColor('#10C8A7')

      // === 2. 滚动详情区 ===
      Scroll() {
        Column() {
          // --- 顶部状态提示卡片 (根据 orderStatus 动态渲染) ---
          Column() {
            Row() {
              Text(this.getStatusTitle())
                .fontSize(18)
                .fontWeight(FontWeight.Bold)
                .fontColor('#333333')

              // 点击状态可跳转到订单跟踪页
              Image($r('app.media.startIcon')).width(14).height(14).margin({ left: 4 })
                .onClick(() => {
                  // TODO: 订单跟踪页待实现
                  // router.pushUrl({ url: 'pages/order/OrderTrackPage' });
                })
            }
            .margin({ bottom: 8 })

            Text(this.getStatusDesc())
              .fontSize(13)
              .fontColor('#666666')
              .margin({ bottom: 16 })

            // 动态按钮组
            Row({ space: 12 }) {
              if (this.orderStatus === 'wait') {
                Button('取消订单')
                  .width(100).height(34).backgroundColor(Color.White).fontColor('#10C8A7')
                  .border({ width: 1, color: '#10C8A7' }).fontSize(13).borderRadius(17)
                Button('联系客服')
                  .width(100).height(34).backgroundColor(Color.White).fontColor('#666666')
                  .border({ width: 1, color: '#CCCCCC' }).fontSize(13).borderRadius(17)
              } else if (this.orderStatus === 'finished' || this.orderStatus === 'closed') {
                Button('再次购买')
                  .width(100).height(34).backgroundColor('#10C8A7').fontColor(Color.White)
                  .fontSize(13).borderRadius(17)
                Button('联系客服')
                  .width(100).height(34).backgroundColor(Color.White).fontColor('#666666')
                  .border({ width: 1, color: '#CCCCCC' }).fontSize(13).borderRadius(17)
              } else if (this.orderStatus === 'refund') {
                Button('再次购买')
                  .width(90).height(34).backgroundColor('#10C8A7').fontColor(Color.White).fontSize(12).borderRadius(17)
                Button('退款详情')
                  .width(90).height(34).backgroundColor(Color.White).fontColor('#666666')
                  .border({ width: 1, color: '#CCCCCC' }).fontSize(12).borderRadius(17)
                Button('联系客服')
                  .width(90).height(34).backgroundColor(Color.White).fontColor('#666666')
                  .border({ width: 1, color: '#CCCCCC' }).fontSize(12).borderRadius(17)
              }
            }
          }
          .width('92%')
          .backgroundColor(Color.White)
          .borderRadius(12)
          .padding(16)
          .margin({ top: 12, bottom: 12 })

          // --- 骑手配送信息卡片 (仅在已完成/配送时显示) ---
          if (this.orderStatus === 'finished') {
            Row() {
              Image($r('app.media.startIcon')).width(40).height(40).borderRadius(20).margin({ right: 12 })
              Column() {
                Text('张**').fontSize(14).fontWeight(FontWeight.Bold).fontColor('#333333').margin({ bottom: 2 })
                Text('达达快递').fontSize(11).fontColor('#007DFF').backgroundColor('#E5F2FF').padding({ left: 4, right: 4 }).borderRadius(2)
              }
              .alignItems(HorizontalAlign.Start)
              Blank()
              Row({ space: 4 }) {
                Image($r('app.media.startIcon')).width(16).height(16)
                Text('呼叫').fontSize(13).fontColor('#10C8A7')
              }
              .padding({ left: 12, right: 12, top: 6, bottom: 6 })
              .border({ width: 0.5, color: '#10C8A7' })
              .borderRadius(16)
            }
            .width('92%')
            .backgroundColor(Color.White)
            .borderRadius(12)
            .padding(14)
            .margin({ bottom: 12 })
          }

          // --- 商品清单与费用明细卡片 ---
          Column() {
            Row() {
              Image($r('app.media.startIcon')).width(16).height(16).borderRadius(2).margin({ right: 6 })
              Text('天虹商场-凤凰城店').fontSize(14).fontWeight(FontWeight.Bold).fontColor('#333333')
              Image($r('app.media.startIcon')).width(12).height(12).margin({ left: 2 })
            }
            .width('100%')
            .margin({ bottom: 12 })

            // 商品1
            this.ProductItem('东北五常大米 10kg', '￥68.90', '1', '￥68.90')
            // 商品2
            this.ProductItem('本地鸡蛋8枚 约500g/份', '￥6.50', '1', '￥6.50')

            Divider().color('#F0F0F0').strokeWidth(0.5).margin({ top: 8, bottom: 12 })

            // 费用明细
            this.FeeRow('运费', '￥4')
            this.FeeRow('时段运费', '￥2')
            this.FeeRow('包装费', '￥1.2')
            this.FeeRow('优惠券', '-￥3', true)
            this.FeeRow('红包', '-￥5', true)

            Divider().color('#F0F0F0').strokeWidth(0.5).margin({ top: 8, bottom: 12 })

            // 实付金额
            Row() {
              Text('共节省 ¥8').fontSize(12).fontColor('#FF4D4F')
              Blank()
              Text('实付金额：').fontSize(13).fontColor('#333333')
              Text('￥ 74.6').fontSize(18).fontColor('#FF4D4F').fontWeight(FontWeight.Bold)
            }
            .width('100%')
            .margin({ bottom: 12 })

            Divider().color('#F0F0F0').strokeWidth(0.5).margin({ bottom: 12 })

            Row() {
              Image($r('app.media.startIcon')).width(16).height(16).margin({ right: 6 })
              Text('联系商家').fontSize(13).fontColor('#333333')
            }
            .width('100%')
            .justifyContent(FlexAlign.Center)
          }
          .width('92%')
          .backgroundColor(Color.White)
          .borderRadius(12)
          .padding(14)
          .margin({ bottom: 12 })

          // --- 配送信息与订单信息卡片 ---
          Column() {
            this.InfoBlockTitle('配送信息')
            this.InfoRow('送达时间：', '立即送达 05月12日 14:20-15:20')
            this.InfoRow('收货地址：', '张小乙 136****5678\n深圳市龙华区凤凰大道龙岭十二区38栋')
            this.InfoRow('配送方式：', '达达快递')

            Divider().color('#F0F0F0').strokeWidth(0.5).margin({ top: 8, bottom: 12 })

            this.InfoBlockTitle('订单信息')
            this.InfoRow('订单号码：', '2125538995000052')
            this.InfoRow('下单时间：', '2099-05-12 13:45:50')
            this.InfoRow('支付方式：', '微信支付')
            this.InfoRow('订单备注：', '其他商品继续配送（缺货商品退款）')
          }
          .width('92%')
          .backgroundColor(Color.White)
          .borderRadius(12)
          .padding(14)
          .margin({ bottom: 30 })
        }
      }
      .scrollBar(BarState.Off)
      .layoutWeight(1)
      .backgroundColor('#F8F8F8')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F8F8F8')
  }

  // --- 辅助 Builder ---
  getStatusTitle(): string {
    if (this.orderStatus === 'wait') return '待商家接单 >';
    if (this.orderStatus === 'finished') return '订单已完成 >';
    if (this.orderStatus === 'closed') return '订单已关闭 >';
    return '退款已到账 >';
  }

  getStatusDesc(): string {
    if (this.orderStatus === 'wait') return '订单已付款，请耐心等待商家接单';
    if (this.orderStatus === 'finished') return '感谢你使用小默买菜';
    if (this.orderStatus === 'closed') return '期待你再次使用小默买菜';
    return '你的退款74.6元已退回到你的支付账户，请查收';
  }

  @Builder ProductItem(name: string, price: string, count: string, total: string) {
    Row() {
      Image($r('app.media.startIcon')).width(50).height(50).borderRadius(6).margin({ right: 10 })
      Column() {
        Text(name).fontSize(13).fontColor('#333333').fontWeight(FontWeight.Medium).margin({ bottom: 4 })
        Text(`${price}  x${count}`).fontSize(12).fontColor('#666666')
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)

      Text(total).fontSize(13).fontColor('#333333').fontWeight(FontWeight.Medium)
    }
    .width('100%')
    .margin({ bottom: 10 })
  }

  @Builder FeeRow(label: string, val: string, isRed: boolean = false) {
    Row() {
      Text(label).fontSize(12).fontColor('#666666')
      Blank()
      Text(val).fontSize(12).fontColor(isRed ? '#FF4D4F' : '#333333')
    }
    .width('100%')
    .margin({ bottom: 8 })
  }

  @Builder InfoBlockTitle(title: string) {
    Text(title)
      .fontSize(14)
      .fontWeight(FontWeight.Bold)
      .fontColor('#333333')
      .width('100%')
      .margin({ bottom: 10 })
  }

  @Builder InfoRow(label: string, val: string) {
    Row() {
      Text(label).fontSize(12).fontColor('#666666').width(75)
      Text(val).fontSize(12).fontColor('#333333').layoutWeight(1).lineHeight(16)
    }
    .width('100%')
    .margin({ bottom: 8 })
    .alignItems(VerticalAlign.Top)
  }
}