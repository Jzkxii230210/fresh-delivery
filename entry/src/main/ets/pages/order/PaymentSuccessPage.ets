import router from '@ohos.router';

@Entry
@Component
struct PaymentSuccessPage {
  // 模拟推荐商品数据
  private recommendList: number[] = [1, 2, 3, 4];

  build() {
    Scroll() {
      Column() {
        // === 1. 顶部支付成功状态区 ===
        Column() {
          Row({ space: 8 }) {
            Circle({ width: 24, height: 24 }).fill('#10C8A7')
            Text('支付成功')
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .fontColor('#333333')
          }
          .margin({ bottom: 20 })

          // 核心操作按钮 (返回首页 / 查看订单)
          Row({ space: 16 }) {
            Button('返回首页')
              .width(130)
              .height(36)
              .backgroundColor(Color.White)
              .fontColor('#666666')
              .border({ width: 1, color: '#CCCCCC' })
              .fontSize(14)
              .borderRadius(18)
              .onClick(() => {
                // router.clear(); // 清空路由栈返回首页
              })

            Button('查看订单')
              .width(130)
              .height(36)
              .backgroundColor(Color.White)
              .fontColor('#10C8A7')
              .border({ width: 1, color: '#10C8A7' })
              .fontSize(14)
              .borderRadius(18)
              .onClick(() => {
                router.pushUrl({ url: 'pages/order/OrderDetailPage' });
              })
          }
        }
        .width('100%')
        .padding({ top: 30, bottom: 30 })
        .backgroundColor(Color.White)
        .margin({ bottom: 12 })

        // === 2. 更多精选商品标题 ===
        Row() {
          Image($r('app.media.startIcon')).width(14).height(14).margin({ right: 6 })
          Text('更多精选商品').fontSize(14).fontColor('#FF4D4F')
          Image($r('app.media.startIcon')).width(14).height(14).margin({ left: 6 })
        }
        .width('100%')
        .justifyContent(FlexAlign.Center)
        .margin({ bottom: 12 })

        // === 3. 商品瀑布流推荐 (双列 Grid) ===
        Grid() {
          ForEach(this.recommendList, () => {
            GridItem() {
              this.ProductCard()
            }
          })
        }
        .columnsTemplate('1fr 1fr')
        .columnsGap(10)
        .rowsGap(10)
        .width('92%')
        .margin({ bottom: 30 })
      }
      .width('100%')
    }
    .scrollBar(BarState.Off)
    .width('100%')
    .height('100%')
    .backgroundColor('#F8F8F8')
  }

  // --- 局部复用组件：推荐商品卡片 ---
  @Builder ProductCard() {
    Column() {
      Image($r('app.media.startIcon'))
        .width('100%')
        .aspectRatio(1)
        .borderRadius({ topLeft: 8, topRight: 8 })

      Column() {
        Text('花菜 约500g')
          .fontSize(14)
          .fontColor('#333333')
          .fontWeight(FontWeight.Medium)
          .margin({ bottom: 4 })

        Text('产地直供，营养丰富，多...')
          .fontSize(11)
          .fontColor('#999999')
          .margin({ bottom: 10 })
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })

        Row() {
          Text('¥7.99').fontSize(16).fontColor('#FF4D4F').fontWeight(FontWeight.Bold).margin({ right: 4 })
          Text('¥9.90').fontSize(12).fontColor('#999999').decoration({ type: TextDecorationType.LineThrough })

          Blank()

          Stack({ alignContent: Alignment.Center }) {
            Circle({ width: 22, height: 22 }).fill('#10C8A7')
            Image($r('app.media.startIcon')).width(12).height(12)
          }
        }
        .width('100%')
      }
      .padding(10)
      .alignItems(HorizontalAlign.Start)
      .width('100%')
    }
    .backgroundColor(Color.White)
    .borderRadius(8)
  }
}