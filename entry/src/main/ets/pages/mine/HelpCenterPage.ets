import router from '@ohos.router';
import promptAction from '@ohos.promptAction';

@Entry
@Component
struct HelpCenterPage {
  private hotQuestions: string[] = [
    '优惠券无法使用？',
    '取消订单后货款怎么返还？',
    '刚下单发现信息填错了怎么办？',
    '订单能不能自提？',
    '账号密码怎么修改？',
    '如何更换绑定手机号？',
    '如何催单？',
    '商品变质如何处理？'
  ];

  build() {
    Stack({ alignContent: Alignment.Bottom }) {

      // === 1. 顶部标题栏与主体滚动区域 ===
      Column() {
        // 顶部导航栏
        Row() {
          Image($r('app.media.startIcon'))
            .width(20).height(20).margin({ right: 12 })
            .onClick(() => { router.back(); })

          Text('帮助与客服')
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

        Scroll() {
          Column() {
            // --- 搜索框 ---
            Row() {
              Row() {
                Image($r('app.media.startIcon')).width(16).height(16).margin({ right: 8 })
                TextInput({ placeholder: '输入问题关键词' })
                  .layoutWeight(1)
                  .height(36)
                  .backgroundColor(Color.Transparent)
                  .fontSize(13)
                  .padding(0)
              }
              .width('100%')
              .height(40)
              .backgroundColor('#F5F5F5')
              .borderRadius(20)
              .padding({ left: 14, right: 14 })
            }
            .width('92%')
            .margin({ top: 12, bottom: 12 })

            // --- 自助服务宫格 ---
            Column() {
              Text('自助服务')
                .fontSize(14)
                .fontWeight(FontWeight.Bold)
                .fontColor('#333333')
                .width('100%')
                .margin({ bottom: 16 })

              Row() {
                this.ServiceGridItem('意见反馈')
                this.ServiceGridItem('发票中心')
                this.ServiceGridItem('售后退款')
                this.ServiceGridItem('账号注销')
              }
              .width('100%')
              .justifyContent(FlexAlign.SpaceAround)
            }
            .width('92%')
            .backgroundColor(Color.White)
            .borderRadius(12)
            .padding(16)
            .margin({ bottom: 12 })
            .shadow({ radius: 4, color: 'rgba(0,0,0,0.03)', offsetY: 2 })

            // --- 热门问题列表 ---
            Column() {
              Text('热门问题')
                .fontSize(14)
                .fontWeight(FontWeight.Bold)
                .fontColor('#333333')
                .width('100%')
                .padding({ left: 16, top: 16, bottom: 8 })

              List() {
                ForEach(this.hotQuestions, (question) => {
                  ListItem() {
                    Row() {
                      Text(question).fontSize(14).fontColor('#333333')
                      Blank()
                      Image($r('app.media.startIcon')).width(12).height(12)
                    }
                    .width('100%')
                    .padding(16)
                  }
                })
              }
              .width('100%')
              .divider({ strokeWidth: 0.5, color: '#F0F0F0', startMargin: 16, endMargin: 16 })
            }
            .width('92%')
            .backgroundColor(Color.White)
            .borderRadius(12)
            .margin({ bottom: 90 }) // 留白防止被底部固定按钮遮挡
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

      // === 2. 底部固定的“在线咨询”按钮 ===
      Row() {
        Button('在线咨询')
          .width('100%')
          .height(44)
          .backgroundColor('#10C8A7')
          .fontColor(Color.White)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .borderRadius(22)
          .onClick(() => {
            promptAction.showToast({ message: '正在连接在线客服...' });
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

  // --- 自助服务宫格单项 ---
  @Builder ServiceGridItem(title: string) {
    Column() {
      Image($r('app.media.startIcon'))
        .width(36).height(36)
        .borderRadius(18)
        .margin({ bottom: 6 })

      Text(title)
        .fontSize(12)
        .fontColor('#333333')
    }
    .alignItems(HorizontalAlign.Center)
    .onClick(() => {
      if (title === '意见反馈') {
        // router.pushUrl({ url: 'pages/profile/FeedbackPage' })
      }
    })
  }
}