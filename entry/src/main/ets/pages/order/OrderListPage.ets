// 订单数据接口
interface MockOrder {
  status: string
  btnText: string
}

@Entry
@Component
export struct OrderListPage {
  // 当前选中的订单状态 Tab 索引 (0:全部, 1:待付款, 2:待配送, 3:待收货, 4:待评价)
  @State currentOrderTab: number = 0;

  // 模拟订单状态与数据
  private tabs: string[] = ['全部', '待付款', '待配送', '待收货', '待评价'];
  private mockOrders: MockOrder[] = [
    { status: '待商家接单', btnText: '取消订单' },
    { status: '已完成', btnText: '再次购买' },
    { status: '已关闭', btnText: '再次购买' }
  ];

  build() {
    Column() {
      // === 1. 顶部标题栏、搜索与消息 ===
      Column() {
        Row() {
          Text('订单')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor('#333333')

          Blank()

          // 搜索框
          Row() {
            Image($r('app.media.startIcon')).width(14).height(14).margin({ right: 6 })
            Text('搜索订单号/关键词').fontSize(12).fontColor('#999999')
          }
          .width(180)
          .height(32)
          .backgroundColor('#F5F5F5')
          .borderRadius(16)
          .padding({ left: 10 })
          .margin({ right: 12 })

          // 消息通知图标带红点
          Stack({ alignContent: Alignment.TopEnd }) {
            Image($r('app.media.startIcon')).width(22).height(22).margin({ top: 4, right: 4 })
            Circle({ width: 8, height: 8 }).fill('#FF4D4F')
          }
        }
        .width('100%')
        .height(50)
        .padding({ left: 16, right: 16 })

        // 订单状态 Tab 栏
        Row() {
          ForEach(this.tabs, (item: string, index: number) => {
            Column() {
              Text(item)
                .fontSize(14)
                .fontWeight(this.currentOrderTab === index ? FontWeight.Bold : FontWeight.Normal)
                .fontColor(this.currentOrderTab === index ? '#10C8A7' : '#666666')
                .margin({ bottom: 6 })

              Divider()
                .color(this.currentOrderTab === index ? '#10C8A7' : Color.Transparent)
                .strokeWidth(2.5)
                .width(18)
                .lineCap(LineCapStyle.Round)
            }
            .layoutWeight(1)
            .onClick(() => {
              this.currentOrderTab = index;
            })
          })
        }
        .width('100%')
        .padding({ top: 4 })
      }
      .width('100%')
      .backgroundColor(Color.White)

      // === 2. 订单列表滚动区 ===
      Scroll() {
        Column() {
          // --- 经常光顾商家横向推荐区 ---
          Column() {
            Row() {
              Text('经常光顾').fontSize(14).fontWeight(FontWeight.Bold).fontColor('#333333')
              Blank()
              Text('查看更多 >').fontSize(12).fontColor('#999999')
            }
            .width('100%')
            .padding({ left: 16, right: 16, top: 12, bottom: 8 })

            List({ space: 12 }) {
              ListItem().margin({ left: 16 })
              ForEach([1, 2, 3, 4, 5], () => {
                ListItem() {
                  Column() {
                    Image($r('app.media.startIcon')).width(48).height(48).borderRadius(24).margin({ bottom: 4 })
                    Text('天虹商场...').fontSize(10).fontColor('#333333').maxLines(1).textOverflow({ overflow: TextOverflow.Ellipsis })
                  }
                  .width(56)
                }
              })
              ListItem().margin({ right: 4 })
            }
            .listDirection(Axis.Horizontal)
            .scrollBar(BarState.Off)
            .width('100%')
            .height(80)
          }
          .backgroundColor(Color.White)
          .margin({ bottom: 10 })

          // --- 订单列表卡片 ---
          List({ space: 12 }) {
            ForEach(this.mockOrders, (order: MockOrder) => {
              ListItem() {
                this.OrderCard(order.status, order.btnText)
              }
            })
          }
          .width('92%')
          .scrollBar(BarState.Off)
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

  // --- 局部复用组件：单个订单卡片 ---
  @Builder OrderCard(statusText: string, actionBtnText: string) {
    Column() {
      // 1. 卡片头部：店铺名称与订单状态
      Row() {
        Row() {
          Image($r('app.media.startIcon')).width(16).height(16).borderRadius(2).margin({ right: 6 })
          Text('天虹商场-凤凰城店').fontSize(14).fontWeight(FontWeight.Bold).fontColor('#333333')
          Image($r('app.media.startIcon')).width(12).height(12).margin({ left: 2 })
        }

        Blank()

        Text(statusText)
          .fontSize(13)
          .fontColor(statusText === '待商家接单' ? '#FF8C00' : '#666666')
          .fontWeight(FontWeight.Medium)
      }
      .width('100%')
      .margin({ bottom: 12 })

      // 2. 商品缩略信息行
      Row() {
        Image($r('app.media.startIcon'))
          .width(60)
          .height(60)
          .borderRadius(6)
          .margin({ right: 10 })

        Column() {
          Text('东北五常大米 10kg')
            .fontSize(14)
            .fontColor('#333333')
            .fontWeight(FontWeight.Medium)
            .margin({ bottom: 6 })

          Text('¥ 68.90')
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
      .margin({ bottom: 12 })

      // 3. 价格合计行
      Row() {
        Blank()
        Row({ space: 4 }) {
          Text('共1件').fontSize(12).fontColor('#666666')
          Text('实付').fontSize(12).fontColor('#666666')
          Text('¥ 68.90').fontSize(15).fontColor('#333333').fontWeight(FontWeight.Bold)
        }
      }
      .width('100%')
      .margin({ bottom: 12 })

      Divider().color('#F0F0F0').strokeWidth(0.5).margin({ bottom: 12 })

      // 4. 底部操作按钮行
      Row() {
        Blank()
        Button(actionBtnText)
          .width(88)
          .height(30)
          .backgroundColor(Color.White)
          .fontColor(actionBtnText === '取消订单' ? '#666666' : '#10C8A7')
          .border({ width: 0.5, color: actionBtnText === '取消订单' ? '#CCCCCC' : '#10C8A7' })
          .fontSize(13)
          .borderRadius(15)
      }
      .width('100%')
    }
    .width('100%')
    .backgroundColor(Color.White)
    .borderRadius(12)
    .padding(14)
  }
}