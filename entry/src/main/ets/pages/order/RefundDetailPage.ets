import router from '@ohos.router';

@Entry
@Component
struct RefundDetailPage {
  build() {
    Column() {
      // === 1. 顶部标题栏 ===
      Row() {
        Image($r('app.media.back'))
          .width(20).height(20).margin({ right: 12 })
          .onClick(() => { router.back(); })

        Text('退款详情')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor('#333333')
          .layoutWeight(1)
          .textAlign(TextAlign.Center)

        Row().width(20)
      }
      .width('100%')
      .height(50)
      .padding({ left: 16, right: 16 })
      .backgroundColor(Color.White)

      // === 2. 滚动详情区 ===
      Scroll() {
        Column() {
          // --- 顶部：退款进度时间轴卡片 ---
          Column() {
            Text('退款进度')
              .fontSize(14)
              .fontWeight(FontWeight.Bold)
              .fontColor('#333333')
              .width('100%')
              .margin({ bottom: 16 })

            // 时间轴节点 1：退款成功 (最新)
            Row() {
              Column() {
                Circle({ width: 16, height: 16 }).fill('#10C8A7')
                Column().width(2).height(45).backgroundColor('#E0E0E0')
              }
              .width(24)
              .alignItems(HorizontalAlign.Center)
              .margin({ right: 10 })

              Column() {
                Text('退款成功').fontSize(14).fontWeight(FontWeight.Bold).fontColor('#10C8A7').margin({ bottom: 2 })
                Text('实际退款金额68.90元，预计3个工作日内退回微信APP账户，请注意查收，支付优惠不退回')
                  .fontSize(11)
                  .fontColor('#666666')
                  .lineHeight(16)
                  .margin({ bottom: 4 })
                Text('2099-05-13 14:54:05').fontSize(10).fontColor('#999999')
              }
              .layoutWeight(1)
              .alignItems(HorizontalAlign.Start)
            }
            .width('100%')
            .alignItems(VerticalAlign.Top)
            .margin({ bottom: 10 })

            // 时间轴节点 2：退款处理中
            Row() {
              Column() {
                Circle({ width: 14, height: 14 }).fill('#CCCCCC')
              }
              .width(24)
              .alignItems(HorizontalAlign.Center)
              .margin({ right: 10 })

              Column() {
                Text('退款处理中').fontSize(14).fontColor('#999999').margin({ bottom: 2 })
                Text('退款处理中，请你耐心等待').fontSize(11).fontColor('#999999').margin({ bottom: 4 })
                Text('2099-05-13 14:49:57').fontSize(10).fontColor('#999999')
              }
              .layoutWeight(1)
              .alignItems(HorizontalAlign.Start)
            }
            .width('100%')
            .alignItems(VerticalAlign.Top)
          }
          .width('92%')
          .backgroundColor(Color.White)
          .borderRadius(12)
          .padding(16)
          .margin({ top: 12, bottom: 12 })
          .shadow({ radius: 4, color: 'rgba(0,0,0,0.03)', offsetY: 2 })

          // --- 中部：退款商品卡片 ---
          Column() {
            Text('退款商品')
              .fontSize(14)
              .fontWeight(FontWeight.Bold)
              .fontColor('#333333')
              .width('100%')
              .margin({ bottom: 12 })

            Row() {
              Image($r('app.media.wuchangdami'))
                .width(55).height(55).borderRadius(6).margin({ right: 10 })
              Column() {
                Text('东北五常大米 10kg').fontSize(14).fontColor('#333333').fontWeight(FontWeight.Medium).margin({ bottom: 6 })
                Text('￥ 68.90').fontSize(14).fontColor('#333333')
              }
              .layoutWeight(1)
              .alignItems(HorizontalAlign.Start)

              Text('x1').fontSize(13).fontColor('#999999')
            }
            .width('100%')
            .margin({ bottom: 12 })

            Divider().color('#F0F0F0').strokeWidth(0.5).margin({ bottom: 12 })

            Row() {
              Blank()
              Text('共 1 件').fontSize(12).fontColor('#666666')
            }
            .width('100%')
          }
          .width('92%')
          .backgroundColor(Color.White)
          .borderRadius(12)
          .padding(16)
          .margin({ bottom: 12 })
          .shadow({ radius: 4, color: 'rgba(0,0,0,0.03)', offsetY: 2 })

          // --- 底部：退款明细信息 ---
          Column() {
            this.InfoRow('退款原因', '缺货商品退款')
            this.InfoRow('下单编号', '2125538995000052')
            this.InfoRow('退款方式', '微信支付')
            this.InfoRow('退款单号', '2300784962519552')

            Divider().color('#F0F0F0').strokeWidth(0.5).margin({ top: 4, bottom: 12 })

            Row() {
              Text('退款合计').fontSize(14).fontColor('#333333')
              Blank()
              Text('￥ 68.90').fontSize(16).fontColor('#FF4D4F').fontWeight(FontWeight.Bold)
            }
            .width('100%')
          }
          .width('92%')
          .backgroundColor(Color.White)
          .borderRadius(12)
          .padding(16)
          .margin({ bottom: 30 })
          .shadow({ radius: 4, color: 'rgba(0,0,0,0.03)', offsetY: 2 })
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

  @Builder InfoRow(label: string, value: string) {
    Row() {
      Text(label).fontSize(13).fontColor('#666666')
      Blank()
      Text(value).fontSize(13).fontColor('#333333')
    }
    .width('100%')
    .margin({ bottom: 12 })
  }
}