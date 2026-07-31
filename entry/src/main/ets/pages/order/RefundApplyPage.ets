import router from '@ohos.router';

// --- 模拟数据模型 ---
class RefundOrder {
  orderNo: string = '';
  refundNo: string = '';
  status: string = '';
  time: string = '';
  productName: string = '';
  price: string = '';
  qty: number = 1;
  refundTotal: string = '';
  productImage?: Resource;
}

@Entry
@Component
export struct AfterSaleListPage {
  // 完美复刻原型图的模拟数据
  private refundList: RefundOrder[] = [
    {
      orderNo: '2125538995000052',
      refundNo: '2300784962519552',
      status: '退款成功',
      time: '2099-05-13 14:49:57',
      productName: '东北五常大米 10kg',
      price: '68.90',
      qty: 1,
      refundTotal: '68.90',
      productImage: $r('app.media.wuchangdami') // 实际开发请替换为真实大米图片资源
    }
  ];

  build() {
    Column() {
      // === 1. 顶部导航栏 ===
      Row() {
        Image($r('app.media.back')) // 替换为左侧返回箭头 Icon
          .width(20)
          .height(20)
          .onClick(() => {
            router.back();
          })

        Text('售后退款')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#333333')
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
          .margin({ right: 20 }) // 为了让标题绝对居中，抵消左侧返回图标的宽度
      }
      .width('100%')
      .height(50)
      .padding({ left: 16, right: 16 })
      .backgroundColor(Color.White)

      // === 2. 售后订单列表区 ===
      List() {
        ForEach(this.refundList, (item: RefundOrder) => {
          ListItem() {
            this.RefundCard(item)
          }
        })
      }
      .width('100%')
      .layoutWeight(1)
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F8F8F8') // 整体浅灰色背景
  }

  // --- 局部复用组件：售后退款卡片 ---
  @Builder RefundCard(item: RefundOrder) {
    Column() {
      // 1. 订单编号与状态行
      Row() {
        Text(`订单号: ${item.orderNo}`).fontSize(13).fontColor('#333333')
        Blank()
        Text(item.status).fontSize(13).fontColor('#FF8C00') // 醒目的橙色状态
      }
      .width('100%')
      .margin({ bottom: 8 })

      // 2. 退款单号与时间行
      Row() {
        Text(`退款单号: ${item.refundNo}`).fontSize(12).fontColor('#999999')
        Blank()
        Text(item.time).fontSize(12).fontColor('#999999')
      }
      .width('100%')
      .margin({ bottom: 12 })

      // 分割线
      Divider().color('#F0F0F0').strokeWidth(0.5)

      // 3. 商品信息区
      Row() {
        Image(item.productImage)
          .width(64)
          .height(64)
          .borderRadius(4)
          .margin({ right: 12 })
          .backgroundColor('#F5F5F5') // 占位背景色

        Column() {
          Text(item.productName)
            .fontSize(14)
            .fontColor('#333333')
            .maxLines(1)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
            .width('100%')
            .margin({ top: 2 })

          Blank() // 自动撑开，将价格和数量推到底部

          Row() {
            Text(`￥${item.price}`).fontSize(14).fontColor('#333333')
            Blank()
            Text(`x${item.qty}`).fontSize(13).fontColor('#333333')
          }
          .width('100%')
          .margin({ bottom: 2 })
        }
        .height(64) // 与图片等高
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Start)
      }
      .width('100%')
      .padding({ top: 16, bottom: 12 })

      // 4. 退款总额明细区
      Row() {
        // 红色的“退”字小图标
        Stack({ alignContent: Alignment.Center }) {
          Circle({ width: 16, height: 16 }).fill('#FF4D4F')
          Text('退').fontSize(10).fontColor(Color.White)
        }
        .margin({ right: 6 })

        Text(`退款总额 ￥${item.refundTotal}`).fontSize(13).fontColor('#333333')
      }
      .width('100%')
      .margin({ bottom: 16 })

      // 分割线
      Divider().color('#F0F0F0').strokeWidth(0.5)

      // 5. 底部操作按钮区
      Row() {
        Blank()
        Button('查看详情')
          .backgroundColor(Color.White)
          .fontColor('#666666')
          .fontSize(13)
          .border({ width: 0.5, color: '#D9D9D9' }) // 浅灰色描边
          .borderRadius(4) // 小圆角
          .padding({ left: 12, right: 12, top: 6, bottom: 6 })
          .height(28)
          .onClick(() => {
            router.pushUrl({ url: 'pages/order/RefundDetailPage' });
          })
      }
      .width('100%')
      .padding({ top: 12 })
    }
    .width('92%')
    .backgroundColor(Color.White)
    .borderRadius(8)
    .padding(16)
    .margin({ top: 12, left: '4%', right: '4%' }) // 居中留白
  }
}