import router from '@ohos.router';

@Entry
@Component
struct PrivacyManagementPage {
  private privacyItems: string[] = [
    '隐私政策',
    '隐私政策摘要',
    '应用权限说明',
    '个人信息收集清单',
    '第三方共享个人信息清单',
    '未成年人隐私政策'
  ];

  build() {
    Column() {
      // === 1. 顶部标题栏 ===
      Row() {
        Image($r('app.media.back'))
          .width(20).height(20).margin({ right: 12 })
          .onClick(() => { router.back(); })

        Text('隐私管理')
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

      // === 2. 隐私条款列表区 ===
      Scroll() {
        Column() {
          List() {
            ForEach(this.privacyItems, (title: string, index: number) => {
              ListItem() {
                Row() {
                  Text(title)
                    .fontSize(14)
                    .fontColor('#333333')

                  Blank()

                  Image($r('app.media.more'))
                    .width(12)
                    .height(12)
                }
                .width('100%')
                .padding(16)
                .onClick(() => {
                  // TODO: 点击跳转至对应的富文本协议webview页
                })
              }
            })
          }
          .width('92%')
          .backgroundColor(Color.White)
          .borderRadius(12)
          .margin({ top: 12 })
          .divider({ strokeWidth: 0.5, color: '#F0F0F0', startMargin: 16, endMargin: 16 })
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
}