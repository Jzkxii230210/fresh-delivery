import router from '@ohos.router';

class TrackStep {
  title: string = '';
  time: string = '';
  desc: string = '';

  constructor(title: string, time: string, desc: string) {
    this.title = title;
    this.time = time;
    this.desc = desc;
  }
}

@Entry
@Component
struct OrderTrackPage {
  private trackSteps: TrackStep[] = [
    new TrackStep('订单已完成', '2099-05-12 12:05', '感谢你使用小默买菜'),
    new TrackStep('配送中', '2099-05-12 12:05', '配送员已取货开始为你配送，配送员：欧**'),
    new TrackStep('配送员已到店', '2099-05-12 13:50', '配送员已到店，配送员：欧**'),
    new TrackStep('配送员已接单', '2099-05-12 13:45', '配送员正在前往商家，配送员：欧**'),
    new TrackStep('拣货完成', '2099-05-12 12:05', '商家已完成拣货，等待配送'),
    new TrackStep('商家已接单', '2099-05-12 13:50', '商品准备中，预计 2099-05-12 14:20 前拣货完成'),
    new TrackStep('已支付', '2099-05-12 13:45', '订单支付成功，预订送达时间：14:20-15:20')
  ];

  build() {
    Column() {
      // 顶部导航栏
      Row() {
        Image($r('app.media.back'))
          .width(20).height(20).margin({ right: 12 })
          .onClick(() => { router.back(); })

        Text('订单跟踪')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor('#333333')
          .layoutWeight(1)
          .textAlign(TextAlign.Center)

        Row().width(20) // 占位
      }
      .width('100%')
      .height(50)
      .padding({ left: 16, right: 16 })
      .backgroundColor(Color.White)

      // 时间轴列表
      Scroll() {
        Column() {
          List() {
            ForEach(this.trackSteps, (step: TrackStep, index: number) => {
              ListItem() {
                Row() {
                  // 左侧时间轴图标与竖线
                  Column() {
                    Circle({ width: 20, height: 20 }).fill(index === 0 ? '#10C8A7' : '#E0E0E0')
                    // 竖线 (最后一条不显示)
                    if (index < this.trackSteps.length - 1) {
                      Column().width(2).height(50).backgroundColor('#E0E0E0')
                    }
                  }
                  .width(30)
                  .alignItems(HorizontalAlign.Center)
                  .margin({ right: 12 })

                  // 右侧内容卡片
                  Column() {
                    Row() {
                      Text(step.title).fontSize(14).fontWeight(FontWeight.Bold).fontColor('#333333')
                      Blank()
                      Text(step.time).fontSize(11).fontColor('#999999')
                    }
                    .width('100%')
                    .margin({ bottom: 4 })

                    Text(step.desc)
                      .fontSize(12)
                      .fontColor('#666666')
                      .lineHeight(16)
                      .margin({ bottom: 12 })
                  }
                  .layoutWeight(1)
                  .backgroundColor(Color.White)
                  .padding(12)
                  .borderRadius(8)
                  .shadow({ radius: 2, color: 'rgba(0,0,0,0.02)', offsetY: 1 })
                }
                .width('100%')
                .alignItems(VerticalAlign.Top)
              }
            })
          }
          .width('92%')
          .padding({ top: 16 })
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