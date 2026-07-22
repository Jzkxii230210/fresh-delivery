import router from '@ohos.router';

@Entry
@Component
struct AfterSaleListPage {
  // 模拟售后退款列表数据
  private afterSaleList: Array<{
    orderNo: string,
    refundNo: string,
    time: string,
    status: string,
    prodName: string,
    price: string,
    total: string
  }> = [
    {
      orderNo: '2125538995000052',
      refundNo: '2300784962519552',
      time: '2099-05-13 14:49:57',
      status: '退款成功',
      prodName: '东北五常大米 10kg',
      price: '￥68.90',
      total: '￥ 68.90'
    }
  ];

  build() {
    Column() {
      // === 1. 顶部标题栏 ===
      Row() {
        Image($r('app.media.startIcon'))
          .width(20).height(20).margin({ right: 12 })
          .onClick(() => { router.back(); })

        Text('售后退款')
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

      // === 2. 售后列表滚动区 ===
      Scroll() {
        Column() {
          List({ space: 12 }) {
            ForEach(this.afterSaleList, (item) => {
              ListItem() {
                this.AfterSaleCard(item)
              }
            })
          }
          .width('92%')
          .padding({ top: 12, bottom: 20 })
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

  // --- 局部复用组件：单条售后退款卡片 ---
  @Builder AfterSaleCard(item: {
    orderNo: string,
    refundNo: string,
    time: string,
    status: string,
    prodName: string,
    price: string,
    total: string
  }) {
    Column() {
      // 1. 卡片头部：订单号与退款状态
      Row() {
        Column() {
          Text(`订单号：${item.orderNo}`)
            .fontSize(12)
            .fontColor('#333333')
            .margin({ bottom: 2 })

          Text(`退款单号：${item.refundNo}    ${item.time}`)
            .fontSize(10)
            .fontColor('#999999')
        }
        .alignItems(HorizontalAlign.Start)
        .layoutWeight(1)

        Text(item.status)
          .fontSize(13)
          .fontColor('#FF8C00')
          .fontWeight(FontWeight.Medium)
      }
      .width('100%')
      .margin({ bottom: 12 })

      Divider().color('#F0F0F0I').strokeWidth(0.5).margin({ bottom: 12 })

      // 2. 商品缩略信息
      Row() {
        Image($r('app.media.startIcon'))
          .width(60)
          .height(60)
          .borderRadius(6)
          .margin({ right: 10 })

        Column() {
          Text(item.prodName)
            .fontSize(14)
            .fontColor('#333333')
            .fontWeight(FontWeight.Medium)
            .margin({ bottom: 6 })

          Text(item.price)
            .fontSize(14)
            .fontColor('#333333')
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Start)

        Text('x1')
          .fontSize(13)
          .fontColor('#999999')
      }
      .width('100%')
      .margin({ bottom: 10 })

      // 3. 退款总额行
      Row() {
        Row({ space: 4 }) {
          Circle({ width: 14, height: 14 }).fill('#FF4D4F')
          Text(`退款总额 ${item.total}`).fontSize(13).fontColor('#333333').fontWeight(FontWeight.Medium)
        }
      }
      .width('100%')
      .margin({ bottom: 12 })

      Divider().color('#F0F0F0').strokeWidth(0.5).margin({ bottom: 12 })

      // 4. 底部“查看详情”按钮
      Row() {
        Blank()
        Button('查看详情')
          .width(88)
          .height(30)
          .backgroundColor(Color.White)
          .fontColor('#666666')
          .border({ width: 0.5, color: '#CCCCCC' })
          .fontSize(13)
          .borderRadius(15)
          .onClick(() => {
            // router.pushUrl({ url: 'pages/profile/RefundDetailPage' })
          })
      }
      .width('100%')
    }
    .width('100%')
    .backgroundColor(Color.White)
    .borderRadius(12)
    .padding(14)
    .shadow({ radius: 4, color: 'rgba(0,0,0,0.03)', offsetY: 2 })
  }
}