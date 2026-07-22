import router from '@ohos.router';

@Entry
@Component
struct BillPage {
  // 模拟账单列表数据
  private billList: Array<{ title: string, time: string, amount: string, isIncome: boolean, channel: string }> = [
    { title: '到家订单_天虹商场-凤凰城...', time: '2099-05-26 17:41:17', amount: '- ¥ 35.00', isIncome: false, channel: '微信支付' },
    { title: '到家订单_大参林(凤凰...', time: '2099-05-25 17:49:10', amount: '- ¥ 75.00', isIncome: false, channel: '微信支付' },
    { title: '退款_天虹商场-凤凰城店', time: '2099-05-20 16:01:55', amount: '+ ¥ 30.00', isIncome: true, channel: '支付宝' },
  ];

  build() {
    Column() {
      // === 1. 顶部导航栏 ===
      Row() {
        Image($r('app.media.startIcon'))
          .width(20).height(20).margin({ right: 12 })
          .onClick(() => { router.back(); })

        Text('支付账单')
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

      // === 2. 筛选栏 (月份 + 交易类型) ===
      Row() {
        Row() {
          Text('2099-12').fontSize(13).fontColor('#333333').margin({ right: 4 })
          Image($r('app.media.startIcon')).width(10).height(10)
        }

        Blank()

        Row() {
          Text('全部交易类型').fontSize(13).fontColor('#333333').margin({ right: 4 })
          Image($r('app.media.startIcon')).width(10).height(10)
        }
      }
      .width('100%')
      .padding({ left: 16, right: 16, top: 12, bottom: 12 })
      .backgroundColor(Color.White)
      .border({ bottom: { width: 0.5, color: '#EFEFEF' } })

      // === 3. 统计汇总条 (支出与收入) ===
      Row() {
        Text('支出 ¥110.00').fontSize(12).fontColor('#666666').margin({ right: 20 })
        Text('收入 ¥30.00').fontSize(12).fontColor('#666666')
      }
      .width('100%')
      .padding({ left: 16, right: 16, top: 10, bottom: 10 })
      .backgroundColor('#FAFAFA')

      // === 4. 账单流水列表 ===
      Scroll() {
        Column() {
          List() {
            ForEach(this.billList, (item) => {
              ListItem() {
                Row() {
                  // 左侧图标 (支出用商场图标，退款用“退”字图标)
                  if (item.isIncome) {
                    Circle({ width: 36, height: 36 }).fill('#2F80ED')
                      .overlay('退', { align: Alignment.Center }) // 可用文字覆盖
                  } else {
                    Image($r('app.media.startIcon'))
                      .width(36).height(36)
                      .borderRadius(18)
                      .margin({ right: 12 })
                  }

                  // 中间标题与时间
                  Column() {
                    Text(item.title)
                      .fontSize(14)
                      .fontWeight(FontWeight.Medium)
                      .fontColor('#333333')
                      .margin({ bottom: 4 })
                      .maxLines(1)
                      .textOverflow({ overflow: TextOverflow.Ellipsis })

                    Text(item.time)
                      .fontSize(11)
                      .fontColor('#999999')
                  }
                  .layoutWeight(1)
                  .alignItems(HorizontalAlign.Start)
                  .margin({ left: item.isIncome ? 0 : 0 })

                  // 右侧金额与支付渠道
                  Column() {
                    Text(item.amount)
                      .fontSize(15)
                      .fontWeight(FontWeight.Bold)
                      .fontColor(item.isIncome ? '#10C8A7' : '#333333')
                      .margin({ bottom: 4 })

                    Text(item.channel)
                      .fontSize(11)
                      .fontColor('#999999')
                  }
                  .alignItems(HorizontalAlign.End)
                }
                .width('100%')
                .padding(16)
              }
            })
          }
          .width('100%')
          .divider({ strokeWidth: 0.5, color: '#F0F0F0', startMargin: 64, endMargin: 16 })
        }
        .width('100%')
      }
      .scrollBar(BarState.Off)
      .layoutWeight(1)
      .backgroundColor(Color.White)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F8F8F8')
  }
}