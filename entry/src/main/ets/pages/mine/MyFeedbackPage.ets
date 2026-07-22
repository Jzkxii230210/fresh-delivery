import router from '@ohos.router';

@Entry
@Component
struct MyFeedbackPage {
  // 模拟历史反馈列表
  private feedbackHistory: Array<{
    time: string,
    content: string,
    reply: string
  }> = [
    {
      time: '2099-06-30 11:50',
      content: '【功能体验】这是一条功能建议，这是一条功能建议，这是一条功能建议，这是一条功能建议，这是一条功能建议，如下图所示。希望能改正。',
      reply: '客服回复：您好，感谢您的支持。我会将该意见及时反馈给研发部门，加强改善。'
    },
    {
      time: '2099-06-28 01:50',
      content: '【功能体验】这是一条功能建议，这是一条功能建议，这是一条功能建议，这是一条功能建议，这是一条功能建议，如下图所示。希望能改正。',
      reply: '客服回复：您好，感谢您的支持。我会将该意见及时反馈给研发部门，加强改善。小默买菜的发展离不开您的支持，祝您生活愉快！'
    }
  ];

  build() {
    Column() {
      // === 1. 顶部标题栏 ===
      Row() {
        Image($r('app.media.startIcon'))
          .width(20).height(20).margin({ right: 12 })
          .onClick(() => { router.back(); })

        Text('我的反馈')
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

      // === 2. 历史反馈列表滚动区 ===
      Scroll() {
        Column() {
          List({ space: 12 }) {
            ForEach(this.feedbackHistory, (item) => {
              ListItem() {
                Column() {
                  // 时间戳
                  Text(item.time)
                    .fontSize(11)
                    .fontColor('#999999')
                    .margin({ bottom: 10, top: 4 })

                  // 反馈卡片主体
                  Column() {
                    Text('反馈内容')
                      .fontSize(14)
                      .fontWeight(FontWeight.Bold)
                      .fontColor('#333333')
                      .width('100%')
                      .margin({ bottom: 8 })

                    Text(item.content)
                      .fontSize(13)
                      .fontColor('#333333')
                      .lineHeight(18)
                      .margin({ bottom: 12 })

                    // 附件图片
                    Image($r('app.media.startIcon'))
                      .width(80)
                      .height(80)
                      .borderRadius(6)
                      .margin({ bottom: 12 })

                    // 客服回复气泡
                    Column() {
                      Text(item.reply)
                        .fontSize(12)
                        .fontColor('#666666')
                        .lineHeight(16)
                    }
                    .width('100%')
                    .backgroundColor('#F8F8F8')
                    .borderRadius(8)
                    .padding(10)
                  }
                  .width('100%')
                  .backgroundColor(Color.White)
                  .borderRadius(12)
                  .padding(14)
                  .shadow({ radius: 4, color: 'rgba(0,0,0,0.03)', offsetY: 2 })
                }
                .width('100%')
              }
            })
          }
          .width('92%')
          .padding({ top: 12, bottom: 30 })
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